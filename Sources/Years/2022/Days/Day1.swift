extension Day1: Puzzle {
	public func solution(for part: Part, given input: String) -> Int {
		let totals = input.split(separator: "\n\n").map {
			$0.split(separator: "\n").map { Int($0)! }.reduce(0, +)
		}

		return switch part {
		case .one: totals.max()!
		case .two: totals.max(count: 3).reduce(0, +)
		}
	}
}
