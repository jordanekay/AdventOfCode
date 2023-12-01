extension Day1: Puzzle {
	public func solution(for part: Part, given input: String) -> Int {
		input.split(separator: "\n").reduce(0) {
			let digits = regexes[part]!.map($1.digit)
			return $0 + digits[0] * 10 + digits[1]
		}
	}
}

extension Substring {
	func digit(matching regex: Regex<(Self, Self)>) -> Int {
		let match = firstMatch(of: regex)!.output.1
		return digitPlusNames.firstIndex(of: .init(match)) ?? .init(match)!
	}
}

let digit = "\\d"
let digitPlusNames = [digit, "one", "two", "three", "four", "five", "six", "seven", "eight", "nine"]
let regexes = Dictionary(
	uniqueKeysWithValues: Part.allCases.map { part in
		let string = part == .one ? digit : digitPlusNames.joined(separator: "|")
		return (part, ["(\(string))", ".*(\(string))"].map { regex in
			try! Regex<(Substring, Substring)>(regex)
		})
	}
) 