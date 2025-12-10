import Algorithms

struct Day09: AdventDay {

    struct P {
        let r: Int
        let c: Int
    }

    var data: String

    var entities: [P] {
        data.components(separatedBy: .newlines)
            .map {
                let cord = $0.components(separatedBy: ",")
                return P(r: Int(cord[1])!, c: Int(cord[0])!)
            }
    }

    func part1() -> Any {
        let rC = entities.map(\.r).max()!
//        let cC = entities.map(\.c).max()!
//
//        let topL = closestPoint(entities, to: P(r: 0, c: 0))
//        let bottomR = closestPoint(entities, to: P(r: rC - 1, c: cC - 1))
//
//        let topR = closestPoint(entities, to: P(r: 0, c: cC - 1))
//        let bottomL = closestPoint(entities, to: P(r: rC - 1, c: 0))
//
//        print("r ", rC, "c ", cC)
//        print("tl: ", topL)
//        print("tr: ", topR)
//        print("bl: ", bottomL)
//        print("br: ", bottomR)
//
//        let s1 = (abs(bottomR.r - topL.r) + 1) * (abs(bottomR.c - topL.c) + 1)
//        let s2 = (abs(bottomL.r - topR.r) + 1) * (abs(topR.c - bottomL.c) + 1)
//
//        return max(s1, s2)
        var ans = 0

        for i in 0 ..< entities.count - 1 {
            let p1 = entities[i]

            for j in i + 1 ..< entities.count {
                let p2 = entities[j]

                let dr = abs(p1.r - p2.r) + 1
                let dc = abs(p1.c - p2.c) + 1

                let s = dr * dc
                ans = max(ans, s)
            }
        }
        return ans
    }

    func closestPoint(_ points: [P], to start: P) -> P {
        func d(_ p: P) -> Int {
            let dr = abs(p.r - start.r) + 1, dc = abs(p.c - start.c) + 1
            return dr * dr + dc * dc
        }

        return points.sorted {
            d($0) < d($1)
        }.first!
    }

    func part2() -> Any {
        1
    }
}
