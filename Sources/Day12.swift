import Algorithms

struct Day12: AdventDay {

    struct Data {

        struct Shape {
            let id: Int
            let mat: [[Int]]

            var square: Int {
                mat.reduce(into: 0) { res, row in
                    res += row.reduce(0, +)
                }
            }
        }

        struct Region {
            var dim: [Int]
            let shapes: [Int]

            var square: Int {
                dim[0] * dim[1]
            }
        }

        let regions: [Region]
        let shapes: [Shape]
    }

    var data: String

    var entities: Data {
        var regions: [Data.Region] = []
        var shapes: [Data.Shape] = []

        let comps = data.components(separatedBy: "\n\n")

        for c in comps {
            if c.contains("x") {
                let rgs = c.components(separatedBy: .newlines)
                for rg in rgs {
                    let p = rg.components(separatedBy: ": ")

                    let dim = p[0].components(separatedBy: "x").map { Int($0)! }
                    let shapes = p[1].components(separatedBy: " ").map { Int($0)! }

                    regions.append(Data.Region(dim: dim, shapes: shapes))
                }
            } else {
                let sh = c.components(separatedBy: ":")

                let shapeID = Int(sh[0])!
                let mat = sh[1].components(separatedBy: .newlines)
                    .dropFirst()
                    .map { str in
                        str.map { $0 == "#" ? 1 : 0 }
                    }

                shapes.append(Data.Shape(id: shapeID, mat: mat))
            }
        }
        
        return Data(regions: regions, shapes: shapes)
    }

    func part1() -> Any {
        return entities.simplePack()
    }

    func part2() -> Any {
        1
    }
}

extension Day12.Data {

    func simplePack() -> Int {
        return regions.reduce(into: 0) { res, region in
            var square = region.dim[0] * region.dim[1]

            for (i, n) in region.shapes.enumerated() {
                square -= shapes[i].square * n
            }

            res += square >= 0 ? 1 : 0
        }
    }
}
