import Foundation

enum AddressMode {
    case position
    case immediate
    case relative
}

enum Instruction {
    case add
    case mul
    case input
    case output
    case jt
    case jf
    case lt
    case eq
    case arb
    case halt
}

struct DecodedOpcode {
    var first: AddressMode = .position
    var second: AddressMode = .position
    var third: AddressMode = .position
    var op: Instruction = .halt
    var size: Int = 0
}

func decodeAddressMode(mode: Int) -> AddressMode {
    switch mode {
    case 0: return .position
    case 1: return .immediate
    case 2: return .relative
    default: return .position
    }
}

func decodeOpcode(opcode: Int) -> DecodedOpcode {
    var decodedOpcode = DecodedOpcode()
    
    let type = opcode % 100
    
    let c = opcode / 100
    let b = c / 10
    let a = b / 10
    
    let cmode = c % 10
    let bmode = b % 10
    let amode = a % 10
    
    decodedOpcode.first = decodeAddressMode(mode: cmode)
    decodedOpcode.second = decodeAddressMode(mode: bmode)
    decodedOpcode.third = decodeAddressMode(mode: amode)
    
    switch type {
    case 1:
        decodedOpcode.op = .add
        decodedOpcode.size = 4
    case 2:
        decodedOpcode.op = .mul
        decodedOpcode.size = 4
    case 99:
        decodedOpcode.op = .halt
        decodedOpcode.size = 0
    case 3:
        decodedOpcode.op = .input
        decodedOpcode.size = 2
    case 4:
        decodedOpcode.op = .output
        decodedOpcode.size = 2
    case 5:
        decodedOpcode.op = .jt
        decodedOpcode.size = 3
    case 6:
        decodedOpcode.op = .jf
        decodedOpcode.size = 3
    case 7:
        decodedOpcode.op = .lt
        decodedOpcode.size = 4
    case 8:
        decodedOpcode.op = .eq
        decodedOpcode.size = 4
    case 9:
        decodedOpcode.op = .arb
        decodedOpcode.size = 2
    default:
        print("ups")
    }
    
    return decodedOpcode
}

struct IntComputer {
    internal var memory = [Int: Int]()
    internal var IP = 0
    internal var phaseEntered = false
    internal var relativeBase = 0
    internal var outputs = [Int]()
    
    mutating func setProgram(program: [Int]) {
        for (index, value) in program.enumerated() {
            memory[index] = value
        }
    }
    
    internal func fetchFromMemory(param: Int, mode: AddressMode) -> Int {
        if mode == .position {
            return memory[param]!
        } else if mode == .immediate {
            return param
        } else if mode == .relative {
            return memory[relativeBase + param]!
        }
        
        return -1
    }
    
    internal func decodeOutputAddress(value: Int, mode: AddressMode) -> Int {
        if mode == .position {
            return value
        } else if mode == .relative {
            return relativeBase + value
        }
        
        return -1
    }
    
    internal mutating func storeToMemory(value: Int, param: Int, mode: AddressMode) {
        switch mode {
        case .position:
            memory[param] = value
        case .relative:
            memory[relativeBase + param] = value
        case .immediate:
            print("not supported")
            return
        }
    }
    
    mutating func run(input: [Int]) -> [Int] {
        
        IP = 0
        relativeBase = 0
        
        while true {
            let opcode = memory[IP]!
            
            let decoded: DecodedOpcode = decodeOpcode(opcode: opcode)
            
            
            switch decoded.op {
            case .add:
                let firstValue = fetchFromMemory(param: memory[IP+1]!, mode: decoded.first)
                let secondValue = fetchFromMemory(param: memory[IP+2]!, mode: decoded.second)
                storeToMemory(value: firstValue + secondValue, param: memory[IP+3]!, mode: decoded.third)
                
                IP += decoded.size
                
            case .mul:
                let firstValue = fetchFromMemory(param: memory[IP+1]!, mode: decoded.first)
                let secondValue = fetchFromMemory(param: memory[IP+2]!, mode: decoded.second)
                storeToMemory(value: firstValue * secondValue, param: memory[IP+3]!, mode: decoded.third)
               
                IP += decoded.size
                
            case .halt:
                return outputs
                
            case .input:
                storeToMemory(value: input[0], param: memory[IP+1]!, mode: decoded.first)
                
                IP += decoded.size
                
            case .output:
                let firstValue = fetchFromMemory(param: memory[IP+1]!, mode: decoded.first)
                IP += decoded.size
                
                outputs.append(firstValue)
                
                //outputClosure(memory[firstValue])
                
            case .jt:
                let firstValue = fetchFromMemory(param: memory[IP+1]!, mode: decoded.first)
                let secondValue = fetchFromMemory(param: memory[IP+2]!, mode: decoded.second)
                
                if firstValue != 0 {
                    IP = secondValue
                } else {
                    IP += decoded.size
                }
                
            case .jf:
                let firstValue = fetchFromMemory(param: memory[IP+1]!, mode: decoded.first)
                let secondValue = fetchFromMemory(param: memory[IP+2]!, mode: decoded.second)
                
                if firstValue == 0 {
                    IP = secondValue
                } else {
                    IP += decoded.size
                }
                
            case .lt:
                let firstValue = fetchFromMemory(param: memory[IP+1]!, mode: decoded.first)
                let secondValue = fetchFromMemory(param: memory[IP+2]!, mode: decoded.second)
               
                if firstValue < secondValue {
                    storeToMemory(value: 1, param: memory[IP+3]!, mode: decoded.third)
                } else {
                    storeToMemory(value: 0, param: memory[IP+3]!, mode: decoded.third)
                }
                
                IP += decoded.size
                
            case .eq:
                let firstValue = fetchFromMemory(param: memory[IP+1]!, mode: decoded.first)
                let secondValue = fetchFromMemory(param: memory[IP+2]!, mode: decoded.second)
                
                if firstValue == secondValue {
                    storeToMemory(value: 1, param: memory[IP+3]!, mode: decoded.third)
                } else {
                    storeToMemory(value: 0, param: memory[IP+3]!, mode: decoded.third)
                }
                
                IP += decoded.size
            case .arb:
                let firstValue = fetchFromMemory(param: memory[IP+1]!, mode: decoded.first)
                
                relativeBase += firstValue
                
                IP += decoded.size
            }
        }
    }
}
