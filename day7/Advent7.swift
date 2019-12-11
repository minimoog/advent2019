import Foundation
import SwiftUI
import PlaygroundSupport

let input = """
3,8,1001,8,10,8,105,1,0,0,21,38,55,64,89,114,195,276,357,438,99999,3,9,101,3,9,9,102,3,9,9,1001,9,5,9,4,9,99,3,9,101,2,9,9,1002,9,3,9,101,5,9,9,4,9,99,3,9,101,3,9,9,4,9,99,3,9,1002,9,4,9,101,5,9,9,1002,9,5,9,101,5,9,9,102,3,9,9,4,9,99,3,9,101,3,9,9,1002,9,4,9,101,5,9,9,102,5,9,9,1001,9,5,9,4,9,99,3,9,102,2,9,9,4,9,3,9,101,2,9,9,4,9,3,9,102,2,9,9,4,9,3,9,101,2,9,9,4,9,3,9,102,2,9,9,4,9,3,9,1002,9,2,9,4,9,3,9,101,1,9,9,4,9,3,9,101,1,9,9,4,9,3,9,1001,9,1,9,4,9,3,9,1002,9,2,9,4,9,99,3,9,1002,9,2,9,4,9,3,9,1001,9,1,9,4,9,3,9,102,2,9,9,4,9,3,9,102,2,9,9,4,9,3,9,101,2,9,9,4,9,3,9,1002,9,2,9,4,9,3,9,102,2,9,9,4,9,3,9,101,1,9,9,4,9,3,9,102,2,9,9,4,9,3,9,1002,9,2,9,4,9,99,3,9,101,2,9,9,4,9,3,9,101,2,9,9,4,9,3,9,102,2,9,9,4,9,3,9,102,2,9,9,4,9,3,9,1001,9,1,9,4,9,3,9,102,2,9,9,4,9,3,9,101,2,9,9,4,9,3,9,101,1,9,9,4,9,3,9,1001,9,1,9,4,9,3,9,1001,9,2,9,4,9,99,3,9,1001,9,1,9,4,9,3,9,1002,9,2,9,4,9,3,9,1001,9,2,9,4,9,3,9,101,1,9,9,4,9,3,9,101,1,9,9,4,9,3,9,102,2,9,9,4,9,3,9,1002,9,2,9,4,9,3,9,102,2,9,9,4,9,3,9,1002,9,2,9,4,9,3,9,101,1,9,9,4,9,99,3,9,1002,9,2,9,4,9,3,9,1001,9,1,9,4,9,3,9,101,2,9,9,4,9,3,9,1002,9,2,9,4,9,3,9,101,1,9,9,4,9,3,9,101,2,9,9,4,9,3,9,1001,9,1,9,4,9,3,9,1002,9,2,9,4,9,3,9,102,2,9,9,4,9,3,9,1001,9,1,9,4,9,99
"""

var code = input.components(separatedBy: ",").compactMap{ Int($0) }

code.append(contentsOf: [0, 0, 0, 0, 0, 0, 0, 0])

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

struct AmpCode {
    var memory = [Int]()
    internal var IP = 0
    internal var phaseEntered = false
    
    mutating func run(input: [Int]) -> Int? {
        
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
            return nil
            
        case .input:
            if !phaseEntered {
                memory[first] = input[0]
                phaseEntered = true
            } else {
                memory[first] = input[1]
            }
            
            IP += decoded.size
            
        case .output:
            IP += decoded.size
            
            return memory[first]
            
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
    }
}

func permute<C: Collection>(items: C) -> [[C.Iterator.Element]] {
    var scratch = Array(items) // This is a scratch space for Heap's algorithm
    var result: [[C.Iterator.Element]] = [] // This will accumulate our result
    
    // Heap's algorithm
    func heap(_ n: Int) {
        if n == 1 {
            result.append(scratch)
            return
        }
        
        for i in 0..<n-1 {
            heap(n-1)
            let j = (n%2 == 1) ? 0 : i
            scratch.swapAt(j, n-1)
        }
        heap(n-1)
    }
    
    // Let's get started
    heap(scratch.count)
    
    // And return the result we built up
    return result
}

let phasesPermutes = permute(items: [5, 6, 7, 8, 9])

func runSequence(code: [Int], phases: [Int]) -> Int {
    var gain = 0
    var copycode = code
    
    var aAmp = AmpCode(memory: code)
    var bAmp = AmpCode(memory: code)
    var cAmp = AmpCode(memory: code)
    var dAmp = AmpCode(memory: code)
    var eAmp = AmpCode(memory: code)
    
    while true {
        guard let aresult = aAmp.run(input: [phases[0], gain]) else { break }
        guard let bresult = bAmp.run(input: [phases[1], aresult]) else { break }
        guard let cresult = cAmp.run(input: [phases[2], bresult]) else { break }
        guard let dresult = dAmp.run(input: [phases[3], cresult]) else { break }
        guard let eresult = eAmp.run(input: [phases[4], dresult]) else { break }
        
        gain = eresult
    }
    
    return gain
}

var gains = [Int]()

for phases in phasesPermutes {
    gains.append(runSequence(code: code, phases: phases))
}

let result = gains.max()

struct ContentView: View {
    var body: some View {
        Text("\(result!)")
    }
}

PlaygroundPage.current.setLiveView(ContentView())

