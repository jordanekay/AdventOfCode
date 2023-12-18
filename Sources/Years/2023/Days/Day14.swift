extension Day14: Puzzle {
	public func solution(for part: Part, given input: String) -> Int {
		var loads: [Int: [Int]] = [:]
		var lines = input.split(separator: "\n").map(Array.init)
		
		let rotationsPerCycle = 4
		let (minCycleLength, maxCycles) = (7, 1000000000)
		let (rotations, cycles) = part == .one ? (1, 1) : (4, 100)
		
		let rotated: ([[Character]]) -> [[Character]] = { lines in
			let (rows, columns) = (lines.count, lines[0].count)
			return (0..<columns).map { column in 
				(0..<rows).reversed().map { row in lines[row][column] }
			}
		}
		
		let load: ([[Character]]) -> Int = { lines in
			lines.reduce(0) { sum, line in
				sum + line.enumerated().reduce(0) { $0 + ($1.1 == "O" ? $1.0 + 1 : 0) } 
			}
		}
		
		let reachedMaxCycle: (Int, [Int]) -> Bool = { 
			guard Set(zip($1, $1.dropFirst()).map(-)).count == 1 else { return false }
			
			let cycleLength = $1[1] - $1[0]
			return cycleLength >= minCycleLength && $1[0] + ((maxCycles - $1[0]) % cycleLength) == $1[0] 
		}
		
		(1...rotations * cycles).forEach { rotation in
			lines = rotated(lines).map {
				var line = String($0)
				while true {
					let shiftedLine = line.replacing(/O(\.+)/) { $0.1 + "O" }
					if line == shiftedLine { break } else { line = shiftedLine }
				}
				return Array(line)
			}
			
			if part == .two && rotation % rotationsPerCycle == 0 {
				let(cycle, load) = (rotation / rotationsPerCycle, load(rotated(lines)))
				loads[load, default: []].append(cycle)
			}
		}
		
		return part == .one ? load(lines) :loads.first(where: reachedMaxCycle)!.key
	}
}