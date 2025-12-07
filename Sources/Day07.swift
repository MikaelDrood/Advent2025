import Algorithms

struct Day07: AdventDay {

    struct P: Hashable {
        let r: Int
        let c: Int

        init(_ r: Int, _ c: Int) {
            self.r = r
            self.c = c
        }
    }

    var data: String

    var entities: [[Character]] {
        data.components(separatedBy: .newlines).map { Array($0) }
    }

    func part1() -> Any {
        var ans = 0
        var visited: Set<P> = []

        let rc = entities.count
        let startC = entities[0].firstIndex(of: "S")!

        var next: [P] = [P(0, startC)]

        while !next.isEmpty {
            let p = next.removeFirst()

            guard !visited.contains(p) else { continue }
            guard p.r + 1 < rc else { continue }

            visited.insert(p)

            switch entities[p.r][p.c] {
            case "^":
                ans += 1
                
                next.append(P(p.r + 1, p.c - 1))
                next.append(P(p.r + 1, p.c + 1))
            case ".", "S":
                next.append(P(p.r + 1, p.c))
            default:
                break
            }
        }

        return ans
    }

    func part2() -> Any {
        var visited: Set<P> = []
        let rc = entities.count, cc = entities[0].count

        let startC = entities[0].firstIndex(of: "S")!
        var next: [P] = [P(0, startC)]

        var ansMap: [[Int]] = Array(repeating: Array(repeating: 0, count: cc), count: rc)
        ansMap[0][startC] = 1

        while !next.isEmpty {
            let p = next.removeFirst()

            guard !visited.contains(p) else { continue }
            guard p.r + 1 < rc else { continue }

            visited.insert(p)

            switch entities[p.r][p.c] {
            case "^":
                let nl = P(p.r + 1, p.c - 1)
                ansMap[nl.r][nl.c] += ansMap[p.r][p.c]
                next.append(nl)

                let nr = P(p.r + 1, p.c + 1)
                ansMap[nr.r][nr.c] += ansMap[p.r][p.c]
                next.append(nr)
            case ".", "S":
                let n = P(p.r + 1, p.c)
                ansMap[n.r][n.c] += ansMap[p.r][p.c]
                next.append(n)
            default:
                break
            }
        }

        return ansMap[rc - 1].reduce(0, +)
    }
}
