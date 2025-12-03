import Algorithms
import RegexBuilder

struct Day03: AdventDay {

    var data: String

    var entities: [[Int]] {
        let regex = Regex {
            Capture { OneOrMore(.digit) }
            ZeroOrMore { .newlineSequence }
        }

        return data.matches(of: regex).map { $0.1.map { $0.wholeNumberValue! } }
    }

    func part1() -> Any {
        var sum = 0

        for bank in entities {
            var b1 = 0, b2 = 0

            for battery in bank {
                if b1 * 10 + b2 < b2 * 10 + battery {
                    b1 = b2
                    b2 = battery
                } else if b1 * 10 + b2 < b1 * 10 + battery {
                    b2 = battery
                }
            }

            sum += b1 * 10 + b2
        }

        return sum
    }

    func part2() -> Any {
        var sum = 0

        func getsum(_ stack: [Int]) -> Int {
            stack.reduce(into: 0) { res, n in
                res = res * 10 + n
            }
        }

        for bank in entities {
            var stack: [Int] = []

            for battery in bank {
                guard stack.count >= 12 else {
                    stack.append(battery)
                    continue
                }

                let cursum = getsum(stack)

                for i in 0 ..< 12 {
                    var updated = stack
                    updated.remove(at: i)
                    updated.append(battery)

                    if getsum(updated) > cursum {
                        stack = updated
                        break
                    }
                }
            }

            sum += getsum(stack)
        }

        return sum
    }
}
