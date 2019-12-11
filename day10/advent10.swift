import Foundation

struct Point: Hashable, Equatable {
    let x: Int
    let y: Int

    func hash(into hasher: inout Hasher) {
        hasher.combine(x)
        hasher.combine(y)
    }
}

//Bresenham line algo:

func getPoints(start: Point, end: Point) -> [Point] {
    var x0 = start.x
    var y0 = start.y
    var x1 = end.x
    var y1 = end.y
    var steep = false
    var points = [Point]()

    if abs(x0 - x1) < abs(y0 - y1) {
        swap(&x0, &y0)
        swap(&x1, &y1)
        steep = true
    }

    if x0 > x1 {
        swap(&x0, &x1)
        swap(&y0, &y1)
    }

    let dx = x1 - x0
    let dy = y1 - y0
    let derr = abs(dy) * 2
    var err = 0

    var y = y0
    var onPoint = false

    for x in x0...x1 {

        if onPoint {
            if steep {
                points.append(Point(x: y, y: x))
            } else {
                points.append(Point(x: x, y: y))
            }

            onPoint = false
        }

        err += derr

        if err == 0 { //horiz or vert line
            onPoint = true
        }

        if err > dx {
            y += y1 > y0 ? 1 : -1
            err -= dx * 2

            if err == 0 {
                onPoint = true
            }
        }
    }

    //we don't need end coordinate
    if !points.isEmpty {
        points.removeLast(1)
    }
    
    return points
}

let input = """
.###.#...#.#.##.#.####..
.#....#####...#.######..
#.#.###.###.#.....#.####
##.###..##..####.#.####.
###########.#######.##.#
##########.#########.##.
.#.##.########.##...###.
###.#.##.#####.#.###.###
##.#####.##..###.#.##.#.
.#.#.#####.####.#..#####
.###.#####.#..#..##.#.##
########.##.#...########
.####..##..#.###.###.#.#
....######.##.#.######.#
###.####.######.#....###
############.#.#.##.####
##...##..####.####.#..##
.###.#########.###..#.##
#.##.#.#...##...#####..#
##.#..###############.##
##.###.#####.##.######..
##.#####.#.#.##..#######
...#######.######...####
#....#.#.#.####.#.#.#.##
"""

var asteroidBelt: [Point: Int] = [Point: Int]()

let lines = input.components(separatedBy: "\n")

for (yindex, line) in lines.enumerated() {
    for (xindex, value) in line.enumerated() {
        if value == "#" {
            asteroidBelt[Point(x: xindex, y: yindex)] = 0
        }
    }
}


for (coordFirst, _) in asteroidBelt {
    inner: for (coordSecond, _) in asteroidBelt {

        if coordFirst == coordSecond { continue }

        let points = getPoints(start: coordFirst, end: coordSecond)

        if points.isEmpty {
            asteroidBelt[coordFirst]! += 1
            
            continue inner
        }
        
        for point in points {
            if let _ = asteroidBelt[point] {
                continue inner
            }
        }

        asteroidBelt[coordFirst]! += 1
    }
}

let result = asteroidBelt.max { a, b in a.value < b.value }

let center = (result?.key)!
print("Center x: \(center.x) y: \(center.y)")

var vaporAsteroid = [Point]()

outer: for (coord, _) in asteroidBelt {
    if center == coord { continue }
    
    let points = getPoints(start: center, end: coord)
    
    if points.isEmpty {
        vaporAsteroid.append(coord)
        
        continue
    }
    
    for point in points {
        if let _ = asteroidBelt[point] { continue outer }
    }
    
    vaporAsteroid.append(coord)
}

struct Angles {
    let angle: Float
    let index: Int
}

var ang = [Angles]()

for (index, coord) in vaporAsteroid.enumerated() {
    let dx: Int = coord.x - center.x
    let dy: Int = center.y - coord.y
    var a: Float = atan2(Float(dx), Float(dy))

    if a < 0 {
        a += .pi * 2.0
    }
    
    let b = Angles(angle: a, index: index)

    ang.append(b)
}

ang.sort { return $0.angle < $1.angle }

let resultIndex = ang[199]

print("Vaporized 200: \(vaporAsteroid[resultIndex.index].x * 100 + vaporAsteroid[resultIndex.index].y)")

