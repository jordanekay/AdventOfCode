extension Day4: Puzzle {
	public func solution(for part: Part, given input: String) -> Int {
		var cache: [Int: Int] = [:]
		let matchCounts = input.split(separator: "\n").map { line in
			let sets = line.split(separator: " | ").map { Set($0.split(separator: " ")) }
			return sets[0].intersection(sets[1]).count
		}
	
		func cardCount(fromGameAt index: Int) -> Int {
			cache[index] ?? {
				let won = (0..<matchCounts[index]).map { index + $0 + 1 }
				let value = won.map(cardCount).reduce(1, +)
				cache[index] = value			
				return value
			}()
		}
		
		return switch part {
		case .one: matchCounts.reduce(0) { $0 + 2 << ($1 - 2) }
		case .two: (0..<matchCounts.count).map(cardCount).reduce(0, +)
		}
	}
}
