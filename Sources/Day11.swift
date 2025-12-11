import Algorithms
import Foundation

struct Day11: AdventDay {

    var data: String

    var entities: [String: [String]] {
        let comps = data.components(separatedBy: .newlines)

        return comps.reduce(into: [:]) { res, comp in
            let i = comp.firstIndex(of: ":")!
            let from = String(comp.prefix(upTo: i))

            let j = comp.index(i, offsetBy: 2)
            let tos = comp.suffix(from: j).components(separatedBy: .whitespaces)

            res[from] = tos
        }
    }

    func part1() -> Any {
        var count = 0

        func dfs(_ from: String) {
            if from == "out" {
                count += 1
                return
            }

            for to in entities[from, default: []] {
                dfs(to)
            }
        }

        dfs("you")

        return count
    }

    func part2() -> Any {
        struct Node: Hashable {
            let node: String
            let fft: Bool
            let dac: Bool
        }

        var cache: [Node: Int] = [:]

        func dfs(_ from: Node) -> Int {
            if from.node == "out" {
                return from.fft && from.dac ? 1 : 0
            }

            if let cached = cache[from] {
                return cached
            }

            var locCount = 0

            for to in entities[from.node, default: []] {
                let next = Node(node: to,
                                fft: from.fft || to == "fft",
                                dac: from.dac || to == "dac")

                locCount += dfs(next)
            }

            cache[from] = locCount
            return locCount
        }

        return dfs(Node(node: "svr", fft: false, dac: false))
    }
}
