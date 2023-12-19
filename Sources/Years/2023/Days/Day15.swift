extension Day15: Puzzle {
	public func solution(for part: Part, given input: String) -> Int {
		let entries = input.dropLast().split(separator: ",")
		let hash: (Substring) -> Int = { $0.reduce(0) { ($0 + Int($1.asciiValue!)) * 17 % 256 } }
		
		switch part {
		case .one: 
			return entries.reduce(0) { $0 + hash($1) }
		case .two: 
			var boxes: [Int: [(String, Int)]] = [:]
			entries.forEach { entry in
				let label = entry.filter(\.isLetter)
				let box = hash(.init(label))
				var lenses = boxes[box] ?? []
				
				let index = lenses.firstIndex { $0.0 == label }
				if entry.hasSuffix("-") {
					_ = index.map { lenses.remove(at: $0) }
				} else {
					let lens = (label, Int(.init(entry.last!))!)
					index.map { lenses[$0] = lens } ?? lenses.append(lens)
				}
				boxes[box] = lenses
			}

			return boxes.reduce(0) {
				$0 + ($1.key + 1) * $1.value.enumerated().reduce(0) { 
					$0 + ($1.0 + 1) * $1.1.1 
				}
			}
		}
	}
}