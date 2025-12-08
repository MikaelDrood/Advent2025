import Algorithms
import Foundation

struct Day08: AdventDay {

    struct P: Hashable {
        let x: Int
        let y: Int
        let z: Int
    }

    struct Edge: Comparable {
        let p1: P
        let p2: P
        let d: Double

        static func < (lhs: Edge, rhs: Edge) -> Bool {
            lhs.d < rhs.d
        }
    }

    var data: String

    var entities: [P] {
        let rows = data.components(separatedBy: .newlines)
        return rows.map {
            let p = $0.components(separatedBy: ",") .map { Int($0)! }
            return P(x: p[0], y: p[1], z: p[2])
        }
    }

    func part1() -> Any {
        var heap = Heap<Edge>()

        for i in 0 ..< entities.count {
            let p1 = entities[i]

            for j in i + 1 ..< entities.count {
                let p2 = entities[j]

                heap.insert(Edge(p1: p1, p2: p2, d: d(p1, p2)))
            }
        }

        var circles: [Set<P>] = []
        var connections = 0

        while connections < 1000 {
            let edge = heap.popMin()!

            let ii = circles.firstIndex { $0.contains(edge.p1) }
            let jj = circles.firstIndex { $0.contains(edge.p2) }

            connections += 1

            if ii != nil, ii == jj {
                continue
            }
            
            if let i = ii, let j = jj {
                circles[i] = circles[i].union(circles[j])
                circles.remove(at: j)
            } else if let i = (ii ?? jj) {
                circles[i].insert(edge.p1)
                circles[i].insert(edge.p2)
            } else {
                circles.append([edge.p1, edge.p2])
            }
        }

        let len = circles.map { $0.count }.sorted(by: >)
        return len[0] * len[1] * len[2]
    }

    func d(_ p1: P, _ p2: P) -> Double {
        return (pow(Double(p1.x - p2.x), Double(2)) +
                pow(Double(p1.y - p2.y), Double(2)) +
                pow(Double(p1.z - p2.z), Double(2))).squareRoot()
    }

    func part2() -> Any {
        var heap = Heap<Edge>()

        for i in 0 ..< entities.count {
            let p1 = entities[i]

            for j in i + 1 ..< entities.count {
                let p2 = entities[j]

                heap.insert(Edge(p1: p1, p2: p2, d: d(p1, p2)))
            }
        }

        var circles: [Set<P>] = []
        var ans = 0

        while !heap.isEmpty {
            let edge = heap.popMin()!

            let ii = circles.firstIndex { $0.contains(edge.p1) }
            let jj = circles.firstIndex { $0.contains(edge.p2) }

            if ii != nil, ii == jj {
                continue
            }

            ans = edge.p1.x * edge.p2.x

            if let i = ii, let j = jj {
                circles[i] = circles[i].union(circles[j])
                circles.remove(at: j)
            } else if let i = (ii ?? jj) {
                circles[i].insert(edge.p1)
                circles[i].insert(edge.p2)
            } else {
                circles.append([edge.p1, edge.p2])
            }
        }

        return ans
    }
}
