extension Day7: Puzzle {
	public func solution(for part: Part, given input: String) -> Int {
		let (numbers, faces) = (2...10, ["T", "J", "Q", "K", "A"])
		let total = numbers.count + faces.count
		let kinds = [[1: 5], [2: 2], [2: 4], [3: 3], [3: 3, 2: 2], [4: 4], [5: 5]]
		let count = { (strength: Int, strengths: [Int]) in strengths.filter { $0 == strength }.count }
		let faceValue: (String, Part) -> Int = {
			$0 == "J" && $1 == .two ? 1 : numbers.upperBound + faces.firstIndex(of: $0)!
		}

		return input.split(separator: "\n").map { line in
			let components = line.split(separator: " ")
			let strengths = components[0].map(String.init).map { .init($0) ?? faceValue($0, part) }
			let counts = strengths.map { $0 == 1 ? 0 : count($0, strengths) }
			let mostCommonStrength = strengths[counts.firstIndex { $0 == counts.max()! }!]
			let adjustedStrengths = strengths.map { $0 == 1 ? mostCommonStrength : $0 }
			let adjustedCounts = part == .one ? counts : adjustedStrengths.map { count($0, adjustedStrengths) }

			return (
				bid: Int(components[1])!,
				kind: kinds.lastIndex {
					$0.allSatisfy { key, value in adjustedCounts.filter { key == $0 }.count == value }
				}!,
				value: strengths.reversed().enumerated().reduce(0) {
					let (place, strength) = $1
					return $0 + Int(pow(Double(total), Double(place))) * strength
				}
			)
		}.sorted { ($0.1, $0.2) < ($1.1, $1.2) }.map(\.0).enumerated().reduce(0) {
			let (rank, bid) = $1
			return $0 + (rank + 1) * bid
		}
	}
}
