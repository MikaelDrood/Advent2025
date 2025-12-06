import Algorithms

struct Day06: AdventDay {

    enum Op: String {
        case mlp = "*"
        case sum = "+"
    }

    var data: String

    var entities: ([[Int]], [Op]) {
        var mat: [[Int]] = []
        var op: [Op] = []

        for row in data.components(separatedBy: "\n") {
            let components = row.components(separatedBy: " ").filter { !$0.isEmpty }

            if Op(rawValue: components[0]) != nil {
                op = components.map { Op(rawValue: $0)! }
            } else {
                let nums = components.map { Int($0)! }
                mat.append(nums)
            }
        }

        return (mat, op)
    }

    func part1() -> Any {
        let (mat, op) = entities
        var sum = 0

        for c in 0 ..< op.count {
            let op = op[c]
            sum += (0 ..< mat.count).reduce(into: op == .mlp ? 1 : 0) { res, i in
                if op == .mlp {
                    res *= mat[i][c]
                } else {
                    res += mat[i][c]
                }
            }
        }

        return sum
    }

    func part2() -> Any {
        let rows = data.components(separatedBy: .newlines)
        let mat = rows.map { Array($0) }

        let rOp = rows.count - 1
        var c = rows.reduce(into: 0) { $0 = max($0, $1.count) } - 1

        var sum = 0
        var nums: [Int] = []

        while c >= 0 {
            let num = (0 ..< mat.count - 1).reduce(into: 0) { res, r in
                guard c < mat[r].count,
                      let val = mat[r][c].wholeNumberValue
                else { return }

                res = res * 10 + val
            }

            nums.append(num)

            if let op = Op(rawValue: "\(mat[rOp][c])") {
                sum += op == .mlp ? nums.reduce(1, *) : nums.reduce(0, +)
                nums = []
                c -= 2
            } else {
                c -= 1
            }
        }

        return sum
    }
}
