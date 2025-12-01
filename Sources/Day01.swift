import Algorithms
import RegexBuilder

struct Day01: AdventDay {

    var data: String

    var entities: [(String, Int)] {
        let regex = Regex {
            Capture { One(.anyGraphemeCluster) }
            Capture { OneOrMore(.digit) }
            ZeroOrMore { .newlineSequence }
        }

        return data.matches(of: regex).map { (String($0.1), Int($0.2)!) }
    }

    func part1() -> Any {
        var position = 50
        var code = 0

        for act in entities {
            position += act.1 % 100 * (act.0 == "L" ? -1 : 1)
            position = (position + 100) % 100

            code += position == 0 ? 1 : 0
        }

        return code
    }

    func part2() -> Any {
        var position = 50
        var code = 0

// shame on me
        for act in entities {
            code += act.1 / 100

            for _ in 0 ..< act.1 % 100 {
                position += act.0 == "L" ? -1 : 1

                if position == 100 {
                    position = 0
                } else if position == -1 {
                    position = 99
                }

                if position == 0 {
                    code += 1
                }
            }
        }

        return code
    }
}
