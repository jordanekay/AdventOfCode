extension Day2: Puzzle {
	public func solution(for part: Part, given input: String) -> Int {
		let (color, count) = (Reference<String>(), Reference<Int>())
		let limits = ["red": 12, "green": 13, "blue": 14]
		let regex = Regex {
			TryCapture(OneOrMore(.digit), as: count) { .init($0) }; " "
			Capture(OneOrMore(.word), as: color) { .init($0) }
		}
		
		return input.split(separator: "\n").enumerated().reduce(0) {
			let id = $1.offset + 1
			let maxCounts = $1.element.matches(of: regex).reduce([:]) {
				$0.merging([$1[color]: $1[count]], uniquingKeysWith: max)
			}
		
			return switch part {
			case .one: $0 + (maxCounts.contains { $0.value > limits[$0.key]! } ? 0 : id)
			case .two: $0 + maxCounts.values.reduce(1, *)
			}
		}
	}
}
