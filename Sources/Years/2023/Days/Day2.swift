extension Day2: Puzzle {
	public func solution(for part: Part, given input: String) -> Int {
		let count = Reference<Int>()
		let color = Reference<String>()
		let regex = Regex {
			TryCapture(OneOrMore(.digit), as: count) { Int($0) }
			" "
			Capture(OneOrMore(.word), as: color, transform: String.init)
		}

		let limits = ["red": 12, "green": 13, "blue": 14]
		return input.split(separator: "\n").enumerated().reduce(0) {
			let id = $1.offset + 1
			let maxCounts = $1.element.matches(of: regex).reduce([:]) {
				$0.merging([$1[color]: $1[count]], uniquingKeysWith: max)
			}
			
			let value = switch part {
			case .one: limits == maxCounts.merging(limits, uniquingKeysWith: max) ? id : 0
			case .two: maxCounts.values.reduce(1, *)
			}
			
			return $0 + value
		}
	}
}
