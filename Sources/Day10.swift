import Algorithms

struct Day10: AdventDay {

    struct Machine {
        let diagram: [Character]
        let schemas: [[Int]]
        let joltage: [Int]
    }

    var data: String

    var entities: [Machine] {
        let rows = data.components(separatedBy: .newlines)

        return rows.map { row in
            let components = row.components(separatedBy: .whitespaces)

            let diagram = Array(components[0].dropFirst().dropLast())
            let schemas = components[1 ..< components.count - 1].map { str in
                str.dropFirst().dropLast().components(separatedBy: ",").map { Int($0)! }
            }
            let joltage = components[components.count - 1].dropFirst().dropLast().components(separatedBy: ",").map { Int($0)! }

            return Machine(diagram: diagram, schemas: schemas, joltage: joltage)
        }
    }

    func part1() -> Any {
        entities.reduce(into: 0) { res, machine in
            res += machine.turnOn()
        }
    }

    func part2() -> Any {
        1
    }
}

extension Day10.Machine {

    struct State: Comparable {
        let lights: [Character]
        let steps: Int

        static func < (lhs: State, rhs: State) -> Bool {
            lhs.steps < rhs.steps
        }
    }

    func turnOn() -> Int {
        var visited: [[Character]: Int] = [:]

        func toggle(_ lights: [Character], _ scheme: [Int]) -> [Character] {
            var lights = lights

            for i in scheme {
                lights[i] = lights[i] == "." ? "#" : "."
            }

            return lights
        }

        var queue = Heap<State>()
        queue.insert(State(lights: Array(repeating: ".", count: diagram.count), steps: 0))

        while !queue.isEmpty {
            let state = queue.popMin()!

            guard state.lights != diagram else {
                print(String(state.lights), state.steps)
                return state.steps
            }

            for scheme in schemas {
                let lights = toggle(state.lights, scheme)
                let next = State(lights: lights, steps: state.steps + 1)

                visited[next.lights] = next.steps
                queue.insert(next)
            }
        }

        return -1
    }
}
