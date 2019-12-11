func requiredFuel(input: Int) -> Int {
    var sumFuel = input
    
    var nextFuel = input / 3 - 2;
    
    while (nextFuel > 0) {
        sumFuel += nextFuel
        nextFuel = nextFuel / 3 - 2
    }
    
    return sumFuel
}

let result = input.components(separatedBy: "\n").compactMap{ Int($0) }.map{ $0 / 3 - 2 }.map{ requiredFuel(input: $0) }.reduce(0, +)