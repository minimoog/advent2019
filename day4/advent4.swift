import Foundation

extension Int {
    func toDigits() -> [Int] {
        var number = self
        var digits: [Int] = [Int]()
        
        while number > 0 {
            digits.append(number % 10)
            number = number / 10
        }
        
        return digits.reversed()
    }
}

func isIncreasing(digits: [Int]) -> Bool {
    
    for i in 0..<digits.count - 1 {
        if digits[i + 1] < digits[i] { return false }
    }
    
    return true
}

func hasDouble(digits: [Int]) -> Bool {
    let counts = digits.reduce(into: [:]) { counts, digit in counts[digit, default: 0] += 1 }
    
    //print(counts)
    
    for (_, count) in counts {
        if count == 2 { return true }
    }
    
    return false
}

var count = 0

for i in 402328...864247 {
    let digits = i.toDigits()

    if !isIncreasing(digits: digits) { continue }
    if !hasDouble(digits: digits) { continue }

    count += 1
}

print(count)
