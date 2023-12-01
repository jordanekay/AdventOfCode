public protocol Puzzle {
    associatedtype Solution: CustomStringConvertible

    init()

    func solution(for part: Part, given input: String) -> Solution
}

public extension Puzzle {
    func solution(for _: Part, given _: String) -> String {
        "Undefined"
    }
}
