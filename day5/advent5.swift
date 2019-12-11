import Foundation

let input = """
3,225,1,225,6,6,1100,1,238,225,104,0,1101,65,39,225,2,14,169,224,101,-2340,224,224,4,224,1002,223,8,223,101,7,224,224,1,224,223,223,1001,144,70,224,101,-96,224,224,4,224,1002,223,8,223,1001,224,2,224,1,223,224,223,1101,92,65,225,1102,42,8,225,1002,61,84,224,101,-7728,224,224,4,224,102,8,223,223,1001,224,5,224,1,223,224,223,1102,67,73,224,1001,224,-4891,224,4,224,102,8,223,223,101,4,224,224,1,224,223,223,1102,54,12,225,102,67,114,224,101,-804,224,224,4,224,102,8,223,223,1001,224,3,224,1,224,223,223,1101,19,79,225,1101,62,26,225,101,57,139,224,1001,224,-76,224,4,224,1002,223,8,223,1001,224,2,224,1,224,223,223,1102,60,47,225,1101,20,62,225,1101,47,44,224,1001,224,-91,224,4,224,1002,223,8,223,101,2,224,224,1,224,223,223,1,66,174,224,101,-70,224,224,4,224,102,8,223,223,1001,224,6,224,1,223,224,223,4,223,99,0,0,0,677,0,0,0,0,0,0,0,0,0,0,0,1105,0,99999,1105,227,247,1105,1,99999,1005,227,99999,1005,0,256,1105,1,99999,1106,227,99999,1106,0,265,1105,1,99999,1006,0,99999,1006,227,274,1105,1,99999,1105,1,280,1105,1,99999,1,225,225,225,1101,294,0,0,105,1,0,1105,1,99999,1106,0,300,1105,1,99999,1,225,225,225,1101,314,0,0,106,0,0,1105,1,99999,108,226,226,224,102,2,223,223,1005,224,329,101,1,223,223,1107,226,677,224,1002,223,2,223,1005,224,344,101,1,223,223,8,226,677,224,102,2,223,223,1006,224,359,101,1,223,223,108,677,677,224,1002,223,2,223,1005,224,374,1001,223,1,223,1108,226,677,224,1002,223,2,223,1005,224,389,101,1,223,223,1007,677,677,224,1002,223,2,223,1006,224,404,1001,223,1,223,1108,677,677,224,102,2,223,223,1006,224,419,1001,223,1,223,1008,226,677,224,102,2,223,223,1005,224,434,101,1,223,223,107,677,677,224,102,2,223,223,1006,224,449,1001,223,1,223,1007,226,677,224,102,2,223,223,1005,224,464,101,1,223,223,7,677,226,224,102,2,223,223,1005,224,479,101,1,223,223,1007,226,226,224,102,2,223,223,1005,224,494,101,1,223,223,7,677,677,224,102,2,223,223,1006,224,509,101,1,223,223,1008,677,677,224,1002,223,2,223,1006,224,524,1001,223,1,223,108,226,677,224,1002,223,2,223,1006,224,539,101,1,223,223,8,226,226,224,102,2,223,223,1006,224,554,101,1,223,223,8,677,226,224,102,2,223,223,1005,224,569,1001,223,1,223,1108,677,226,224,1002,223,2,223,1006,224,584,101,1,223,223,1107,677,226,224,1002,223,2,223,1005,224,599,101,1,223,223,107,226,226,224,102,2,223,223,1006,224,614,1001,223,1,223,7,226,677,224,102,2,223,223,1005,224,629,1001,223,1,223,107,677,226,224,1002,223,2,223,1005,224,644,1001,223,1,223,1107,677,677,224,102,2,223,223,1006,224,659,101,1,223,223,1008,226,226,224,1002,223,2,223,1006,224,674,1001,223,1,223,4,223,99,226
"""

var memory = input.components(separatedBy: ",").compactMap{ Int($0) }
memory.append(0)
memory.append(0)
memory.append(0)
memory.append(0)

enum AddressMode {
    case position
    case immediate
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
    case halt
}

struct DecodedOpcode {
    var first: AddressMode = .immediate
    var second: AddressMode = .immediate
    var third: AddressMode = .immediate
    var op: Instruction = .halt
    var size: Int = 0
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
    
    if cmode == 1 { decodedOpcode.first = .immediate } else { decodedOpcode.first = .position }
    if bmode == 1 { decodedOpcode.second = .immediate } else { decodedOpcode.second = .position }
    if amode == 1 { decodedOpcode.third = .immediate } else { decodedOpcode.third = .position }
   
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
    default:
        print("ups")
    }
    
    return decodedOpcode
}

var IP = 0

while true {
    let opcode = memory[IP]
    
    let decoded = decodeOpcode(opcode: opcode)
    
    var first = memory[IP + 1]
    var second = memory[IP + 2]
    var third = memory[IP + 3]
    
    switch decoded.op {
    case .add:
        if decoded.first == .position { first = memory[first] }
        if decoded.second == .position { second = memory[second] }
        
        memory[third] = first + second
        
        IP += decoded.size
        
    case .mul:
        if decoded.first == .position { first = memory[first] }
        if decoded.second == .position { second = memory[second] }
        
        memory[third] = first * second
        
        IP += decoded.size
        
    case .halt:
        break
        
    case .input:
        memory[first] = 5
        
        IP += decoded.size
        
    case .output:
        print(memory[first])
        
        IP += decoded.size
        
    case .jt:
        if decoded.first == .position { first = memory[first] }
        if decoded.second == .position { second = memory[second] }
        
        if first != 0 {
            IP = second
        } else {
            IP += decoded.size
        }
        
    case .jf:
        if decoded.first == .position { first = memory[first] }
        if decoded.second == .position { second = memory[second] }
        
        if first == 0 {
            IP = second
        } else {
            IP += decoded.size
        }
        
    case .lt:
        if decoded.first == .position { first = memory[first] }
        if decoded.second == .position { second = memory[second] }
        
        if first < second {
            memory[third] = 1
        } else {
            memory[third] = 0
        }
        
        IP += decoded.size
        
    case .eq:
        if decoded.first == .position { first = memory[first] }
        if decoded.second == .position { second = memory[second] }
        
        if first == second {
            memory[third] = 1
        } else {
            memory[third] = 0
        }
        
        IP += decoded.size
    }
}
