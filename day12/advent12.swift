import Foundation

//<x=10, y=15, z=7>
//<x=15, y=10, z=0>
//<x=20, y=12, z=3>
//<x=0, y=-3, z=13>

/*
public func gcd(_ m: Int, _ n: Int, using gcdAlgorithm: (Int, Int) -> (Int) = gcdIterativeEuklid) -> Int {
    return gcdAlgorithm(m, n)
}

public func gcdIterativeEuklid(_ m: Int, _ n: Int) -> Int {
    var a: Int = 0
    var b: Int = max(m, n)
    var r: Int = min(m, n)
    
    while r != 0 {
        a = b
        b = r
        r = a % b
    }
    return b
}

public func gcdRecursiveEuklid(_ m: Int, _ n: Int) -> Int {
    let r: Int = m % n
    if r != 0 {
        return gcdRecursiveEuklid(n, r)
    } else {
        return n
    }
}


public func lcm(_ m: Int, _ n: Int, using gcdAlgorithm: (Int, Int) -> (Int) = gcdIterativeEuklid) throws -> Int {
    guard m & n != 0 else { throw LCMError.divisionByZero }
    return m / gcdAlgorithm(m, n) * n
}
*/

class Planet {
    var x: Int
    var y: Int
    var z: Int
    var vx = 0
    var vy = 0
    var vz = 0

    init(x: Int, y: Int , z: Int) {
        self.x = x
        self.y = y
        self.z = z
    }

    func applyVelocity() {
        x += vx
        y += vy
        z += vz
    }

    var energy: Int {
        get {
            return (abs(x) + abs(y) + abs(z)) * (abs(vx) + abs(vy) + abs(vz))
        }
    }
}

var moons: [Planet] = [Planet]()


//test
//<x=-1, y=0, z=2>
//<x=2, y=-10, z=-7>
//<x=4, y=-8, z=8>
//<x=3, y=5, z=-1>

moons.append(Planet(x: 10, y: 15, z: 7))
moons.append(Planet(x: 15, y: 10, z: 0))
moons.append(Planet(x: 20, y: 12, z: 3))
moons.append(Planet(x: 0, y: -3, z: 13))

for  i in 1..<1000000000 {

    for (index, planet) in moons.enumerated() {

        //apply gravity
        for (otherindex, otherplanet) in moons.enumerated() {
            if otherindex == index { continue }

            if otherplanet.x > planet.x {
                planet.vx += 1
            } else if otherplanet.x < planet.x {
                planet.vx -= 1
            }

            if otherplanet.y > planet.y {
                planet.vy += 1
            } else if otherplanet.y < planet.y {
                planet.vy -= 1
            }

            if otherplanet.z > planet.z {
                planet.vz += 1
            } else if otherplanet.z < planet.z {
                planet.vz -= 1
            }
        }
    }

    //apply velocity
    for planets in moons {
        planets.applyVelocity()
    }

    if 
       moons[0].z == 7 &&
       moons[1].z == 0 &&
       moons[2].z == 3 &&
       moons[3].z == 13 && 

       moons[0].vz == 0 &&   
       moons[1].vz == 0 && 
       moons[2].vz == 0 &&   
       moons[3].vz == 0
     
    {
        print(i)
        break
    }
}

//161428
//231614
//102356


