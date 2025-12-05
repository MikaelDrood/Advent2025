import Algorithms
import RegexBuilder

struct Day05: AdventDay {

    var data: String
    
    var entities: ([[Int]], [Int]) {
        let components = data.components(separatedBy: .newlines)

        var fresh: [[Int]] = []
        var avail: [Int] = []

        for c in components {
            guard c != "" else { continue }

            if c.contains("-") {
                fresh.append(c.components(separatedBy: "-").map { Int($0)! })
            } else {
                avail.append(Int(c)!)
            }
        }

        return (fresh, avail)
    }

    func part1() -> Any {
        let (fresh, available) = entities

        return available.reduce(into: 0) { res, id in
            res += fresh.contains { $0[0] <= id && $0[1] >= id } ? 1 : 0
        }
    }

    func part2() -> Any {
        var (fresh, _) = entities
        var res: [[Int]] = []

        fresh = fresh.sorted { $0[0] == $1[0] ? $0[1] < $1[1] : $0[0] < $1[0] }

        for f in fresh {
            guard !res.isEmpty else {
                res.append(f)
                continue
            }

            if let last = res.last, last[1] >= f[0] {
                let li = res.count - 1
                res[li][1] = max(res[li][1], f[1])
            } else {
                res.append(f)
            }
        }

        return res.reduce(into: 0) { res, range in
            res += range[1] - range[0] + 1
        }
    }
}
