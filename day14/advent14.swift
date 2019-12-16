import Foundation

let input = """
2 MPHSH, 3 NQNX => 3 FWHL
144 ORE => 1 CXRVG
1 PGNF => 8 KHFD
3 JDVXN => 5 FSTFV
1 ZMZL, 30 PVDSG => 6 SMBH
1 CFDNS, 2 PTZNC, 10 XCKN => 9 SKVP
1 JWNR => 1 QCVHS
10 MHRML => 1 KXNWH
4 PVDSG => 3 VBZJZ
10 TLBV => 1 ZVNH
1 PVQB, 5 JDVXN => 4 WDPCN
4 NQNX, 7 KHFD, 9 SDWSL => 6 HWVM
1 SMBH => 2 PCWR
1 CXNZD, 5 SKVP, 7 LVWTF => 9 QFQJV
2 HWVM => 7 GPXP
3 CXRVG, 3 GXNL => 8 PVDSG
1 PTZNC, 2 CFDNS => 7 LCKSX
14 NQNX, 8 FWHL => 5 XCKN
12 PVDSG, 3 PVQB => 8 TLBV
8 PVQB => 8 ZKCK
1 GPXP => 5 LCGN
5 VGNR, 1 ZMZL => 9 SMGNP
2 SMGNP => 7 CXNZD
6 SMGNP, 2 HWVM, 9 PTZNC => 7 GLMVK
18 QNZVM => 7 NLCVJ
1 JDVXN, 10 GMFW, 6 VBZJZ => 9 ZMZL
1 HCFRV, 1 ZKCK, 1 SMGNP, 1 LCKSX => 7 JXZFV
13 NLCVJ, 6 ZMZL => 7 SDWSL
3 SMBH => 4 PVQB
20 QNZVM, 1 PTZNC, 7 PVQB => 7 HFLGH
2 CXNZD => 8 VLNVF
4 GMFW => 4 JDVXN
23 VGNR => 3 HSBH
1 FWHL, 32 MPHSH => 7 ZNSV
5 WDPCN, 6 ZKCK, 3 QNZVM => 4 MWHMH
1 FSTFV, 3 ZKCK, 1 LVWTF => 9 LGHD
2 SKVP, 2 MWHMH, 12 QCVHS, 6 HFLGH, 3 NRGBW, 1 ZVNH, 2 LGHD => 4 SBQKM
13 PVQB, 2 HSBH, 5 TLBV => 9 LVWTF
6 FSTFV => 2 JWNR
7 ZKCK => 9 NRGBW
8 HFLGH, 3 KXNWH, 15 VLNVF, 2 VGNR, 2 SDMS, 10 MWHMH, 7 KHFD, 1 FSTFV => 4 WTRPM
5 SKVP => 4 SDMS
100 ORE => 7 GMFW
9 GXNL => 7 MPHSH
2 GXNL, 5 GMFW => 9 NQNX
3 SDWSL, 8 LVWTF, 2 GPXP => 5 HCFRV
140 ORE => 4 GXNL
1 WDPCN, 4 NLCVJ => 1 MHRML
1 VBZJZ => 7 PGNF
1 ZNSV => 1 CFDNS
1 GLMVK, 7 SDMS => 5 GBZRN
14 WTRPM, 93 SBQKM, 37 JXZFV, 4 NRGBW, 12 QFQJV, 24 SMBH, 3 LCGN, 15 GBZRN, 16 PCWR, 11 XCKN => 1 FUEL
1 WDPCN, 5 FWHL => 8 PTZNC
1 ZNSV => 9 VGNR
5 PGNF => 5 QNZVM
"""

struct Element {
    var name = ""
    var number = 0
}

struct Reaction {
    var output: Element
    var inputs: [Element]
}

let testInputLines = input.components(separatedBy: "\n")

var nanoFactory: [String: Reaction] = [String: Reaction]()

for line in testInputLines {
    let leftandright = line.components(separatedBy: "=>")
    let left = leftandright[0]
    let right = leftandright[1]
    
    let rightChemical = right.trimmingCharacters(in: .whitespacesAndNewlines).components(separatedBy: " ")
    let leftChemicals = left.components(separatedBy: ",")
    
    var lc = [Element]()
    
    for c in leftChemicals {
        let nc = c.trimmingCharacters(in: .whitespacesAndNewlines).components(separatedBy: " ")
        
        let chemical = Element(name: nc[1], number: Int(nc[0])!)
        lc.append(chemical)
    }
    
    let rc = Element(name: rightChemical[1], number: Int(rightChemical[0])!)
    
    let r = Reaction(output: rc, inputs: lc)
    
    nanoFactory[r.output.name] = r
}

func isReaction(reaction: Reaction, name: String, nanoFactory: [String: Reaction]) -> Bool {
    if name == "ORE" { return false }
    
    for input in reaction.inputs {
        if input.name == "ORE" { continue }
        if input.name == name { return true }
        
        if isReaction(reaction: nanoFactory[input.name]!, name: name, nanoFactory: nanoFactory) {
            return true
        }
    }
    
    return false
}

func nextItem(items: [String: Int], nanoFactory: [String: Reaction]) -> (String, Int) {
    for (name, number) in items {
        if name == "ORE" { continue }
        
        var isPart = true
        
        for (otherName, _) in items where name != otherName {
            guard let reaction = nanoFactory[otherName] else { continue }
            
            if isReaction(reaction: reaction, name: name, nanoFactory: nanoFactory) {
                isPart = false
                break
            }
        }
        
        if isPart {
            return (name, number)
        }
    }
    
    return ("", 0)
}

func fuelForOre(fuel: Int, nanoFactory: [String: Reaction]) -> Int {
    var items: [String: Int] = ["FUEL": fuel]
    
    while items.count > 1 || items.keys.first != "ORE" {
        let (name, number) = nextItem(items: items, nanoFactory: nanoFactory)
        
        guard let reaction = nanoFactory[name] else { fatalError() }
        
        items.removeValue(forKey: name)
        
        let howMuch = (number + reaction.output.number - 1) / reaction.output.number
        
        for input in reaction.inputs {
            let add = input.number * howMuch
            let existing = items[input.name] ?? 0
            let total = add + existing
            
            items[input.name] = total
        }
    }
    
    return items["ORE"]!
}

//part 1

let oneFuelForOre = fuelForOre(fuel: 1, nanoFactory: nanoFactory)
print(oneFuelForOre)

//part 2
let stock = 1000000000000

let fuel1 = 10000
let fuel2 = 100000
var ore1 = fuelForOre(fuel: fuel1, nanoFactory: nanoFactory)
var ore2 = fuelForOre(fuel: fuel2, nanoFactory: nanoFactory)

//  y = kx + b
// y - y1 = (y2 - y1) / (x2 - x1) * x
//

var k = Float((ore2 - ore1)) / Float((fuel2 - fuel1))
var b = Float(ore1) - k * Float(fuel1)
var neededFuel = (Float(stock) - b) / k

print(neededFuel)
