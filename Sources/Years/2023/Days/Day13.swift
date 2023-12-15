extension Day13: Puzzle {
	public func solution(for part: Part, given input: String) -> Int {
		input.split(separator: "\n\n").flatMap {
			let lines = $0.split(separator: "\n").map(Array.init)
			let (rows, columns) = (lines.count, lines[0].count)
			return [lines, (0..<columns).map { column in (0..<rows).map { row in lines[row][column] }}]
		}.enumerated().reduce(0) {
			let (index, lines) = $1
			let rows = lines.count
			return $0 + ((1..<rows).first { row in 
				let count = min(row, rows - row)
				let overlap = zip(lines[(row - count)..<row].reversed(), lines[row..<(row + count)])
				return overlap.reduce(0) { 
					$0 + zip($1.0, $1.1).reduce(0) { $0 + ($1.0 == $1.1 ? 0 : 1) }
				} == (part == .one ? 0 : 1)
			}.map { $0 * (index % 2 == 0 ? 100 : 1) } ?? 0)
		}
	}
}