extension Day15: Puzzle {
	public func solution(for part: Part, given input: String) -> Int {
		let entries = input.dropLast().split(separator: ",")
		let hash: (Substring) -> Int = { $0.reduce(0) { ($0 + Int($1.asciiValue!)) * 17 % 256 } }
		
		return switch part {
		case .one: entries.reduce(0) { $0 + hash($1) }
		case .two: entries.reduce([:]) { boxes, entry -> [Int: [(String, Int)]] in
				let label = entry.filter(\.isLetter)
				let box = hash(.init(label))
				let lenses = boxes[box] ?? []
				let index = lenses.firstIndex { $0.0 == label }
				let removed = entry.hasSuffix("-") ? lenses.filter { $0.0 != label } : nil
				let lens = entry.last.map(String.init).flatMap(Int.init).map { [(label, $0)] } ?? []
				let added = index.map { lenses[..<$0] + lens + lenses[($0 + 1)...] } ?? lenses + lens
				return boxes.merging([box: removed ?? added]) { $1 }
			}.reduce(0) {
				$0 + ($1.key + 1) * $1.value.enumerated().reduce(0) { $0 + ($1.0 + 1) * $1.1.1 }
			}
		}
	}
}