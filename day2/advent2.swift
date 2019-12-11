func start(input: String, noun: Int, verb: Int) -> Int {
    var memory = input.components(separatedBy: ",").compactMap{ Int($0) }
    memory[1] = noun
    memory[2] = verb

    var IP = 0

    while (true) {
        //get opcode
        let opcode = memory[IP]
        
        if opcode == 1 {
            let leftoperand = memory[memory[IP + 1]]
            let rightoperand = memory[memory[IP + 2]]
            let store = memory[IP + 3]
            
            let result = leftoperand + rightoperand
            
            memory[store] = result
            
            IP += 4
            
        } else if opcode == 2 {
            let leftoperand = memory[memory[IP + 1]]
            let rightoperand = memory[memory[IP + 2]]
            let store = memory[IP + 3]
            
            let result = leftoperand * rightoperand
            
            memory[store] = result
            
            IP += 4
            
        } else if opcode == 99 {
            break
        }
    }
    
    return memory[0]
}

outerLoop: for noun in 0..<100 {
    for verb in 0..<100 {
        let result = start(input: input, noun: noun, verb: verb)
        
        if result == 19690720 {
            print(noun, verb)
            break outerLoop
        }
    }
}
