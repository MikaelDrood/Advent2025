import Algorithms
import RegexBuilder

struct Day04: AdventDay {

    var data: String

    var entities: [[Character]] {
        let regex = Regex {
            Capture { OneOrMore { .anyNonNewline } }
        }

        return data.matches(of: regex).map { Array($0.1) }
    }

    func part1() -> Any {
        var ans = 0

        for r in 0 ..< entities.count {
            for c in 0 ..< entities[0].count {
                ans += isAccassable(r, c, entities) ? 1 : 0
            }
        }

        return ans
    }

    func part2() -> Any {
        var entities = entities

        var didRemove = true
        var ans = 0

        while didRemove {
            didRemove = false

            for r in 0 ..< entities.count {
                for c in 0 ..< entities[0].count {
                    guard isAccassable(r, c, entities) else { continue }

                    entities[r][c] = "."

                    didRemove = true
                    ans += 1
                }
            }
        }

        return ans
    }

    private func isAccassable(_ r: Int, _ c: Int, _ entities: [[Character]]) -> Bool {
        guard entities[r][c] == "@" else { return false }

        var adjC = 0

        for m in [(-1, -1), (0, -1), (1, -1), (-1, 0), (1, 0), (-1, 1), (0, 1), (1, 1)] {
            let rr = r + m.0, cc = c + m.1

            guard rr >= 0, rr < entities.count, cc >= 0, cc < entities[0].count else { continue }

            adjC += entities[rr][cc] == "@" ? 1 : 0

            if adjC == 4 {
                return false
            }
        }


        return true
    }
}
