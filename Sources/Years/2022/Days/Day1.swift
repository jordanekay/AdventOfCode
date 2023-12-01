import Algorithms
import Division

extension Day1: Puzzle {
    public func solution(for part: Part, given input: String) -> Int {
        let totals = input
            .split(separator: "\n\n")
            .map(\.total)

        return switch part {
        case .one: totals
            .max()!
        case .two: totals
            .max(count: 3)
            .reduce(0, +)
        }
    }
}

private extension String.SubSequence {
    var total: Int {
        split(separator: "\n")
            .compactMap { Int($0) }
            .reduce(0, +)
    }
}
