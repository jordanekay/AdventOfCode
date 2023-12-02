extension Day1: Puzzle {
	public func solution(for part: Part, given input: String) -> Int {
		input.split(separator: "\n").reduce(0) {
			let digits = regexes[part]!.compactMap($1.firstMatch).map(\.output.1)
			return $0 + digits[0] * 10 + digits[1]
		}
	}
}

private let digit = ChoiceOf { CharacterClass(.digit) }
private let digitNames = ["one", "two", "three", "four", "five", "six", "seven", "eight", "nine"]
private let digits = Dictionary(uniqueKeysWithValues: digitNames.enumerated().map { ($1, $0 + 1)})
private let regexes = Dictionary(
	uniqueKeysWithValues: Part.allCases.map { part in
		let regex = switch part {
		case .one: digit
		case .two: ChoiceOf { digit; try! Regex(digits.keys.joined(separator: "|")) }
		}

		let capture = TryCapture(regex) { digits[.init($0)] ?? .init($0) }
		return (part, [Regex { capture }, Regex { ZeroOrMore(.any); capture }])
	}
)
