extension Day1: Puzzle {
	public func solution(for part: Part, given input: String) -> Int {
		let digit = ChoiceOf { CharacterClass(.digit) }
		let digits = ["one": 1, "two": 2, "three": 3, "four": 4, "five": 5, "six": 6, "seven": 7, "eight": 8, "nine": 9]
		let regexes = Dictionary(
			uniqueKeysWithValues: Part.allCases.map { part in
				let regex = switch part {
				case .one: digit
				case .two: ChoiceOf { digit; try! Regex(digits.keys.joined(separator: "|")) }
				}

				let capture = TryCapture(regex) { digits[.init($0)] ?? .init($0) }
				return (part, [Regex { capture }, Regex { ZeroOrMore(.any); capture }])
			}
		) 
		
		return input.split(separator: "\n").reduce(0) {
			let digits = regexes[part]!.compactMap($1.firstMatch).map(\.output.1)
			return $0 + digits[0] * 10 + digits[1]
		}
	}
}