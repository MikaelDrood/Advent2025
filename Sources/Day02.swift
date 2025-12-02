import Algorithms
import RegexBuilder

struct Day02: AdventDay {

    var data: String

    var entities: [[Int]] {
        let regex = Regex {
            Capture { OneOrMore(.digit) }
            "-"
            Capture { OneOrMore(.digit) }
            ZeroOrMore { "," }
        }

        return data.matches(of: regex).map { [Int($0.1)!, Int($0.2)!] }
    }

    func part1() -> Any {
        var ans = 0

        for range in entities {
            for id in range[0] ... range[1] {
                ans += isValid(id: id) ? 0 : id
            }
        }

        return ans
    }

    private func isValid(id: Int) -> Bool {
        let str = String(id)

        guard str.count % 2 == 0 else { return true }

        let lh = str.count / 2

        return str.prefix(lh) != str.suffix(lh)
    }

    func part2() -> Any {
        var ans = 0

        for range in entities {
            for id in range[0] ... range[1] {
                ans += isValid2(id: id) ? 0 : id
            }
        }

        return ans
    }

    private func isValid2(id: Int) -> Bool {
        let str = String(id)
        
        var rptStr = ""
        var shift = 1

        while rptStr != str, shift <= str.count / 2 {
            defer {
                shift += 1
            }

            guard str.count % shift == 0 else { continue }

            let rpt = str.count / shift
            rptStr = String(repeating: String(str.prefix(shift)), count: rpt)
        }

        return rptStr != str
    }
}
