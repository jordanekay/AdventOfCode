extension Day11: Puzzle {
	public func solution(for part: Part, given input: String) -> Int {
		let lines = input.split(separator: "\n")
		let range = 0..<lines.count
		let magnitude = part == .one ? 2 : 1000000
		let character: (Substring, Int) -> Character = { $0[$0.index($0.startIndex, offsetBy: $1)] }
		let expandedOffsets: (Bool) -> [Int] = { isRow in
			range.filter { row in
				let characters = range.map { character(lines[isRow ? row : $0], isRow ? $0 : row) }
				return Set(characters) == ["."]
			}
		}

		let (rowOffsets, columnOffsets) = (expandedOffsets(true), expandedOffsets(false))
		let galaxies = lines.enumerated().flatMap { index, line in
			line.indices.filter { line[$0] == "#" }.map { (index, $0.utf16Offset(in: line)) }
		}
		
		let galaxyRange = 0..<galaxies.count
		return galaxyRange.flatMap { a in galaxyRange.map { b in [a, b] } }.reduce(0) {
			let (to, from) = (galaxies[$1[0]], galaxies[$1[1]])
			let rowOffset = columnOffsets.filter { $0 > min(to.1, from.1) && $0 < max(to.1, from.1) }.count
			let columnOffset = rowOffsets.filter { $0 > min(to.0, from.0) && $0 < max(to.0, from.0) }.count
			return $0 + abs(to.0 - from.0) + abs(to.1 - from.1) + (rowOffset + columnOffset) * (magnitude - 1)
		} / 2
	}
}