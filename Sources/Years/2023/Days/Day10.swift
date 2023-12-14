extension Day10: Puzzle {
	public func solution(for part: Part, given input: String) -> Int {
		let (start, empty): (Character, Character) = ("S", ".")
		var lines = input.split(separator: "\n").map { "\(empty)\($0)\(empty)" }
		let emptyLine = String(Array(repeating: empty, count: lines[0].count * 2))
		let character: ([String], [Int]) -> Character = {
			let line = $0[$1[0]]
			return line[line.index(line.startIndex, offsetBy: $1[1])] 
		}
		
		let directions: [[Int]: [Character: [Int]]] = [
			[0, 1]: ["J": [-1, 0], "7": [1, 0], "-": [0, 1]],
			[1, 0]: ["J": [0, -1], "L": [0, 1], "|": [1, 0]], 
			[0, -1]: ["F": [1, 0], "L": [-1, 0], "-": [0, -1]],
			[-1, 0]: ["F": [0, 1], "7": [0, -1], "|": [-1, 0]]
		]
		
		if part == .two {
			lines = [emptyLine] + zip(
				lines.map { String(zip($0, emptyLine).flatMap { [$0, $1] }) },
				Array(repeating: emptyLine, count: lines.count)
			).flatMap { [$0, $1] } + [emptyLine]		
			
			lines = (0..<lines.count - 2).map { row in
				String((0..<lines[0].count - 1).map { column in
					let current = character(lines, [row, column])
					if row == 0 || column == 0 { return current }
					
					let right = character(lines, [row, column + 1])
					let down = character(lines, [row + 1, column])
					let left = character(lines, [row, column - 1])
					let up = character(lines, [row - 1, column])
					
					if (["S", "-", "F", "L"].flatMap { left in
						["-", "7", "J"].map { right in "\(left)\(empty)\(right)" }
					}.contains("\(left)\(current)\(right)")) { return "-" }
					
					if (["S", "|", "F", "7"].flatMap { up in
						["|", "L", "J"].map { down in "\(up)\(empty)\(down)" }
					}.contains("\(up)\(current)\(down)")) { return "|" }
					
					return current
				})
			}
		}
		
		let (row, line) = lines.enumerated().first { $0.1.contains(start) }!
		let column = line.indices.first { line[$0] == start }!.utf16Offset(in: line)
		var (steps, offset, position, pipes) = (1, nil as [Int]?, [row, column], [] as Set<[Int]>)
		let valid: ([Int]) -> Bool = { 
			directions[$0]!.keys.contains(character(lines, zip(position, $0).map(+)))
		}
		
		while true {
			pipes.insert(position)
			let currentOffset = offset ?? directions.keys.first(where: valid)!
			let nextPosition = zip(position, currentOffset).map(+)
			let next = character(lines, nextPosition); if next == start { break }
			(steps, offset, position) = (steps + 1, directions[currentOffset]![next], nextPosition)
		}
		
		if part == .one { return steps / 2 }
		
		var (filled, fillCount): (Set<[Int]>, Int) = ([], 0)
		let (columnRange, rowRange) = (0...lines.count, 0...lines[0].count)
		while true {
			columnRange.forEach { row in
				rowRange.forEach { column in
					if !pipes.contains([row, column]) && (row == 0 || column == 0 || 
						filled.contains([row - 1, column]) || filled.contains([row, column - 1]) ||
						filled.contains([row + 1, column]) || filled.contains([row, column + 1])) {
						filled.insert([row, column]) 
					}
				}
			}
			
			if filled.count == fillCount { break }; fillCount = filled.count
		}
			
		return columnRange.reduce(0) { sum, row in
			sum + rowRange.reduce(0) { sum, column in
				let isIncluded = row % 2 == 1 && column % 2 == 0
				let isInside = !filled.contains([row, column]) && !pipes.contains([row, column])
				return sum + (isIncluded && isInside ? 1 : 0)
			}
		}
	}
}