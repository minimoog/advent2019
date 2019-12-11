import Foundation

let program = """
3,8,1005,8,311,1106,0,11,0,0,0,104,1,104,0,3,8,102,-1,8,10,1001,10,1,10,4,10,1008,8,0,10,4,10,1002,8,1,29,3,8,102,-1,8,10,1001,10,1,10,4,10,108,0,8,10,4,10,101,0,8,50,1,2,19,10,1006,0,23,1,103,14,10,1,1106,15,10,3,8,1002,8,-1,10,1001,10,1,10,4,10,1008,8,1,10,4,10,102,1,8,88,1006,0,59,3,8,1002,8,-1,10,101,1,10,10,4,10,1008,8,1,10,4,10,1002,8,1,113,2,101,12,10,2,1001,0,10,2,1006,14,10,3,8,1002,8,-1,10,101,1,10,10,4,10,108,0,8,10,4,10,102,1,8,146,1,1106,11,10,1006,0,2,1,9,8,10,3,8,1002,8,-1,10,1001,10,1,10,4,10,1008,8,1,10,4,10,101,0,8,180,1,6,13,10,1,1102,15,10,2,7,1,10,3,8,1002,8,-1,10,1001,10,1,10,4,10,108,0,8,10,4,10,1002,8,1,213,1006,0,74,2,1005,9,10,3,8,1002,8,-1,10,101,1,10,10,4,10,1008,8,0,10,4,10,1002,8,1,243,3,8,1002,8,-1,10,101,1,10,10,4,10,108,1,8,10,4,10,101,0,8,264,2,104,8,10,3,8,1002,8,-1,10,1001,10,1,10,4,10,108,1,8,10,4,10,1001,8,0,290,101,1,9,9,1007,9,952,10,1005,10,15,99,109,633,104,0,104,1,21101,387512640296,0,1,21101,0,328,0,1106,0,432,21102,1,665749660564,1,21101,339,0,0,1106,0,432,3,10,104,0,104,1,3,10,104,0,104,0,3,10,104,0,104,1,3,10,104,0,104,1,3,10,104,0,104,0,3,10,104,0,104,1,21102,179318226984,1,1,21101,386,0,0,1105,1,432,21101,46266346499,0,1,21101,0,397,0,1105,1,432,3,10,104,0,104,0,3,10,104,0,104,0,21102,709580555028,1,1,21102,420,1,0,1106,0,432,21102,1,988220642068,1,21101,0,431,0,1106,0,432,99,109,2,21202,-1,1,1,21101,40,0,2,21102,1,463,3,21102,1,453,0,1106,0,496,109,-2,2106,0,0,0,1,0,0,1,109,2,3,10,204,-1,1001,458,459,474,4,0,1001,458,1,458,108,4,458,10,1006,10,490,1102,0,1,458,109,-2,2105,1,0,0,109,4,2102,1,-1,495,1207,-3,0,10,1006,10,513,21101,0,0,-3,21201,-3,0,1,22101,0,-2,2,21102,1,1,3,21101,532,0,0,1106,0,537,109,-4,2106,0,0,109,5,1207,-3,1,10,1006,10,560,2207,-4,-2,10,1006,10,560,22102,1,-4,-4,1105,1,628,21201,-4,0,1,21201,-3,-1,2,21202,-2,2,3,21102,1,579,0,1105,1,537,22101,0,1,-4,21101,1,0,-1,2207,-4,-2,10,1006,10,598,21101,0,0,-1,22202,-2,-1,-2,2107,0,-3,10,1006,10,620,22101,0,-1,1,21102,620,1,0,106,0,495,21202,-2,-1,-2,22201,-4,-2,-4,109,-5,2105,1,0
""".components(separatedBy: ",").compactMap{ Int($0) }

print(program)

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
    internal var relativeBase = 0
    
    public var inputHandler: (() -> (Int))?
    public var outputHandler: ((Int) -> ())?

    mutating func setProgram(program: [Int]) {
        for (index, value) in program.enumerated() {
            memory[index] = value
        }
    }
    
    internal func fetchFromMemory(param: Int, mode: AddressMode) -> Int {
        if mode == .position {
            return memory[param, default: 0]
        } else if mode == .immediate {
            return param
        } else if mode == .relative {
            return memory[relativeBase + param, default: 0]
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
    
    mutating func run() {
        
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
                return
                
            case .input:
                if let inputHandler = inputHandler {
                    let input = inputHandler()

                    storeToMemory(value: input, param: memory[IP+1]!, mode: decoded.first)
                }                
                
                IP += decoded.size
                
            case .output:
                let firstValue = fetchFromMemory(param: memory[IP+1]!, mode: decoded.first)
                IP += decoded.size
                
                if let outputHandler = outputHandler {
                    outputHandler(firstValue)
                }
                
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

struct Point: Hashable, Equatable {
    var x: Int
    var y: Int

    func hash(into hasher: inout Hasher) {
        hasher.combine(x)
        hasher.combine(y)
    }
}

struct Robot {
    enum Direction {
        case UP
        case DOWN
        case LEFT
        case RIGHT
    }    

    var coord = Point(x: 0, y: 0)
    var orientation: Direction = .UP
 
    mutating func rotateLeft() {
        switch orientation {
        case .UP:
            orientation = .LEFT
        case .LEFT:
            orientation = .DOWN
        case .DOWN:
            orientation = .RIGHT
        case .RIGHT:
            orientation = .UP
        }
    }

    mutating func rotateRight() {
        switch orientation {
        case .UP:
            orientation = .RIGHT
        case .RIGHT:
            orientation = .DOWN
        case .DOWN:
            orientation = .LEFT
        case .LEFT:
            orientation = .UP
        }
    }

    mutating func move() {
        switch orientation {
        case .UP:
            coord.y -= 1
        case .RIGHT:
            coord.x += 1
        case .DOWN:
            coord.y += 1
        case .LEFT:
            coord.x -= 1
        }
    }
}

var floor = [Point: Int]()
var robot = Robot()
var computer = IntComputer()
computer.setProgram(program: program)

computer.inputHandler = {
    
    //get the current color
    if let panel = floor[robot.coord] {
        return panel
    } else {
        return 0 // or 1 for second part
    }
}

var outputs = [Int]()

computer.outputHandler = { output in

    outputs.append(output)

    if outputs.count == 2 {
        if outputs[0] == 0 {
            //black
            floor[robot.coord] = 0
        } else {
            //white
            floor[robot.coord] = 1
        }

        if outputs[1] == 0 {
            robot.rotateLeft()
        } else {
            robot.rotateRight()
        }

        robot.move()
        outputs = []
    }

    return
}

computer.run()

print(floor.count)
