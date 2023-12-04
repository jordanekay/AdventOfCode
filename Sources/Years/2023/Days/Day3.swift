extension Day3: Puzzle {
	public func solution(for part: Part, given input: String) -> Int {
		let lines = input.split(separator: "\n").map { ".\($0)." }
		let emptyLine = String(Array(repeating: ".", count: lines[0].count))
		let paddedLines = [emptyLine] + lines + [emptyLine]
		let (value, symbol, gear) = (/\d+/, /[^\.\d]/, "*")

		return lines.enumerated().reduce(0) {
			let (index, line) = $1
			let window = (index..<index + 3).map { paddedLines[$0] }
			switch part {
			case .one:
				return $0 + line.matches(of: value) { output, range in 
					window.contains { $0[range].contains(symbol) } ? Int(output)! : 0 
				}
			case .two:
				let allValues = window.flatMap { $0.matches(of: value) }
				return $0 + line.matches(of: gear) { output, range in
					let values = allValues.filter { $0.range.overlaps(range) }
					return values.count == 2 ? values.map { Int($0.output)! }.reduce(1, *) : 0
				}
			}
		}
	}
}

private extension String {
	func matches<T: RegexComponent>(of component: T, result: (T.RegexOutput, Range<String.Index>) -> Int) -> Int {
		matches(of: component).reduce(0) {
			let range = index(before: $1.range.lowerBound)..<index(after: $1.range.upperBound)
			return $0 + result($1.output, range)
		}	
	}
}
