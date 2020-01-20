import Foundation

var program = """
1,330,331,332,109,3862,1101,0,1182,15,1101,1465,0,24,1002,0,1,570,1006,570,36,102,1,571,0,1001,570,-1,570,1001,24,1,24,1106,0,18,1008,571,0,571,1001,15,1,15,1008,15,1465,570,1006,570,14,21101,58,0,0,1105,1,786,1006,332,62,99,21102,333,1,1,21101,73,0,0,1105,1,579,1102,0,1,572,1102,0,1,573,3,574,101,1,573,573,1007,574,65,570,1005,570,151,107,67,574,570,1005,570,151,1001,574,-64,574,1002,574,-1,574,1001,572,1,572,1007,572,11,570,1006,570,165,101,1182,572,127,102,1,574,0,3,574,101,1,573,573,1008,574,10,570,1005,570,189,1008,574,44,570,1006,570,158,1105,1,81,21101,340,0,1,1106,0,177,21101,477,0,1,1106,0,177,21101,514,0,1,21102,1,176,0,1105,1,579,99,21102,1,184,0,1106,0,579,4,574,104,10,99,1007,573,22,570,1006,570,165,1002,572,1,1182,21102,1,375,1,21102,211,1,0,1105,1,579,21101,1182,11,1,21101,0,222,0,1105,1,979,21101,0,388,1,21102,233,1,0,1106,0,579,21101,1182,22,1,21101,0,244,0,1106,0,979,21102,1,401,1,21102,255,1,0,1105,1,579,21101,1182,33,1,21102,1,266,0,1106,0,979,21102,1,414,1,21101,0,277,0,1106,0,579,3,575,1008,575,89,570,1008,575,121,575,1,575,570,575,3,574,1008,574,10,570,1006,570,291,104,10,21101,1182,0,1,21102,313,1,0,1105,1,622,1005,575,327,1101,1,0,575,21102,327,1,0,1105,1,786,4,438,99,0,1,1,6,77,97,105,110,58,10,33,10,69,120,112,101,99,116,101,100,32,102,117,110,99,116,105,111,110,32,110,97,109,101,32,98,117,116,32,103,111,116,58,32,0,12,70,117,110,99,116,105,111,110,32,65,58,10,12,70,117,110,99,116,105,111,110,32,66,58,10,12,70,117,110,99,116,105,111,110,32,67,58,10,23,67,111,110,116,105,110,117,111,117,115,32,118,105,100,101,111,32,102,101,101,100,63,10,0,37,10,69,120,112,101,99,116,101,100,32,82,44,32,76,44,32,111,114,32,100,105,115,116,97,110,99,101,32,98,117,116,32,103,111,116,58,32,36,10,69,120,112,101,99,116,101,100,32,99,111,109,109,97,32,111,114,32,110,101,119,108,105,110,101,32,98,117,116,32,103,111,116,58,32,43,10,68,101,102,105,110,105,116,105,111,110,115,32,109,97,121,32,98,101,32,97,116,32,109,111,115,116,32,50,48,32,99,104,97,114,97,99,116,101,114,115,33,10,94,62,118,60,0,1,0,-1,-1,0,1,0,0,0,0,0,0,1,6,30,0,109,4,1202,-3,1,587,20101,0,0,-1,22101,1,-3,-3,21102,0,1,-2,2208,-2,-1,570,1005,570,617,2201,-3,-2,609,4,0,21201,-2,1,-2,1105,1,597,109,-4,2106,0,0,109,5,1202,-4,1,630,20102,1,0,-2,22101,1,-4,-4,21101,0,0,-3,2208,-3,-2,570,1005,570,781,2201,-4,-3,653,20101,0,0,-1,1208,-1,-4,570,1005,570,709,1208,-1,-5,570,1005,570,734,1207,-1,0,570,1005,570,759,1206,-1,774,1001,578,562,684,1,0,576,576,1001,578,566,692,1,0,577,577,21102,702,1,0,1106,0,786,21201,-1,-1,-1,1106,0,676,1001,578,1,578,1008,578,4,570,1006,570,724,1001,578,-4,578,21102,731,1,0,1105,1,786,1106,0,774,1001,578,-1,578,1008,578,-1,570,1006,570,749,1001,578,4,578,21102,756,1,0,1106,0,786,1106,0,774,21202,-1,-11,1,22101,1182,1,1,21102,1,774,0,1106,0,622,21201,-3,1,-3,1105,1,640,109,-5,2105,1,0,109,7,1005,575,802,20101,0,576,-6,20101,0,577,-5,1106,0,814,21101,0,0,-1,21101,0,0,-5,21102,1,0,-6,20208,-6,576,-2,208,-5,577,570,22002,570,-2,-2,21202,-5,51,-3,22201,-6,-3,-3,22101,1465,-3,-3,2102,1,-3,843,1005,0,863,21202,-2,42,-4,22101,46,-4,-4,1206,-2,924,21102,1,1,-1,1105,1,924,1205,-2,873,21101,35,0,-4,1105,1,924,1201,-3,0,878,1008,0,1,570,1006,570,916,1001,374,1,374,1202,-3,1,895,1101,0,2,0,2101,0,-3,902,1001,438,0,438,2202,-6,-5,570,1,570,374,570,1,570,438,438,1001,578,558,921,21002,0,1,-4,1006,575,959,204,-4,22101,1,-6,-6,1208,-6,51,570,1006,570,814,104,10,22101,1,-5,-5,1208,-5,47,570,1006,570,810,104,10,1206,-1,974,99,1206,-1,974,1101,1,0,575,21101,0,973,0,1105,1,786,99,109,-7,2106,0,0,109,6,21101,0,0,-4,21101,0,0,-3,203,-2,22101,1,-3,-3,21208,-2,82,-1,1205,-1,1030,21208,-2,76,-1,1205,-1,1037,21207,-2,48,-1,1205,-1,1124,22107,57,-2,-1,1205,-1,1124,21201,-2,-48,-2,1106,0,1041,21101,0,-4,-2,1105,1,1041,21101,-5,0,-2,21201,-4,1,-4,21207,-4,11,-1,1206,-1,1138,2201,-5,-4,1059,2101,0,-2,0,203,-2,22101,1,-3,-3,21207,-2,48,-1,1205,-1,1107,22107,57,-2,-1,1205,-1,1107,21201,-2,-48,-2,2201,-5,-4,1090,20102,10,0,-1,22201,-2,-1,-2,2201,-5,-4,1103,1201,-2,0,0,1106,0,1060,21208,-2,10,-1,1205,-1,1162,21208,-2,44,-1,1206,-1,1131,1106,0,989,21101,439,0,1,1106,0,1150,21101,0,477,1,1105,1,1150,21101,514,0,1,21102,1,1149,0,1106,0,579,99,21101,0,1157,0,1106,0,579,204,-2,104,10,99,21207,-3,22,-1,1206,-1,1138,2101,0,-5,1176,2101,0,-4,0,109,-6,2106,0,0,4,13,38,1,11,1,38,1,11,1,38,1,11,1,38,1,11,1,38,1,11,1,34,5,11,1,15,13,6,1,15,1,15,1,11,1,6,1,15,1,15,1,11,1,6,1,15,1,15,1,11,1,6,1,15,1,15,1,11,1,6,1,15,1,15,1,11,1,6,1,5,11,15,1,11,1,6,1,31,1,11,1,6,1,31,1,11,1,6,1,31,1,11,1,6,9,23,1,1,11,14,1,23,1,1,1,24,1,23,7,20,1,25,1,3,1,20,1,9,7,7,11,16,1,9,1,5,1,7,1,1,1,3,1,3,1,16,1,7,11,5,1,1,1,3,1,3,1,16,1,7,1,1,1,5,1,1,1,5,1,1,1,3,1,3,1,16,1,7,1,1,1,5,11,3,1,3,1,16,1,7,1,1,1,7,1,5,1,5,1,3,1,16,11,7,7,5,1,3,1,24,1,21,1,3,1,24,1,21,7,22,1,25,1,1,1,12,11,25,9,44,1,5,1,44,1,5,1,44,1,5,1,34,11,5,1,34,1,15,1,34,1,15,1,34,1,15,1,34,1,15,1,34,1,15,1,34,1,11,5,34,1,11,1,38,1,11,1,38,1,11,1,38,1,11,1,38,1,11,1,38,13,4
""".components(separatedBy: ",").compactMap{ Int($0) }

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
    public var outputHandler: ((Int) -> (Bool))?
    
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
                    let continueRunning = outputHandler(firstValue)
                    
                    if !continueRunning { return }
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

func goUP(point: Point) -> Point { Point(x: point.x, y: point.y - 1) }
func goDOWN(point: Point) -> Point { Point(x: point.x, y: point.y + 1) }
func goLEFT(point: Point) -> Point { Point(x: point.x - 1, y: point.y) }
func goRIGHT(point: Point) -> Point { Point(x: point.x + 1, y: point.y) }

let leftRobot = Int(Character("<").asciiValue!)
let rightRobot = Int(Character(">").asciiValue!)
let upRobot = Int(Character("^").asciiValue!) 
let downRobot = Int(Character("V").asciiValue!)

var robot = IntComputer()
robot.setProgram(program: program)

// 35: scaffold
// 46: space
// <,>,^,V: robot
// 10: new line

var x = 0
var y = 0

var scaffoldMap = [Point: Int]()
var stringMap = ""

robot.outputHandler = { output in
    let char = Character(UnicodeScalar(output)!)
    stringMap.append(char)

    switch output {
    case 10:
        y += 1
        x = 0
    case 35:
        scaffoldMap[Point(x: x, y: y)] = 35
        x += 1

    case 46:
        scaffoldMap[Point(x: x, y: y)] = 46
        x += 1

    case leftRobot, rightRobot, upRobot, downRobot:
        scaffoldMap[Point(x: x, y: y)] = output
        x += 1

    default:
        x += 1
    }

    return true
}

robot.run()

var count = 0

for (point, type) in scaffoldMap where type == 35 {
    let up = goUP(point: point)
    let down = goDOWN(point: point)
    let left = goLEFT(point: point)
    let right = goRIGHT(point: point)
    
    if let upType = scaffoldMap[up],
       let downType = scaffoldMap[down],
       let leftType = scaffoldMap[left],
       let rightType = scaffoldMap[right] {
    
        if upType == 35 && downType == 35 && leftType == 35 && rightType == 35 {
            print(point.x, point.y)

            count += point.x * point.y
        }
    }
}

print(count)

print(stringMap)

//part 2

var robot2 = IntComputer()
program[0] = 2
robot2.setProgram(program: program)



robot2.outputHandler = { output in
    print(output)

    return true
}

let inputRoutineString = """
A,B,A,C,B,C,A,B,A,C
R,10,L,8,R,10,R,4
L,6,L,6,R,10
L,6,R,12,R,12,R,10
n

"""

let inputRoutine = Array(inputRoutineString).map { $0.asciiValue! }
var c = 0

robot2.inputHandler = {

    let r = Int(inputRoutine[c])

    c += 1

    return r
}

robot2.run()
