extension Day16: Puzzle {
	public func solution(for part: Part, given input: String) -> Int {
		let lines = input.split(separator: "\n").map(Array.init)
		let horizontal = (0..<lines.count).flatMap { [(($0, -1), (0, 1)), (($0, lines[$0].count), (0, -1))]}
		let vertical = (0..<lines[0].count).flatMap { [((-1, $0), (1, 0)), ((lines.count, $0), (-1, 0))]}
		let entrances = part == .one ? [horizontal[0]] : horizontal + vertical
		
		return entrances.map {
			var data = [$0]
			var seen: Set<[Int]> = []
			var energized = seen
		
			while !data.isEmpty {
				data = data.flatMap { pair -> [((Int, Int), (Int, Int))] in
					let (beam, direction) = pair
					let next = (beam.0 + direction.0, beam.1 + direction.1)
					let record = [next.0, next.1, direction.0, direction.1]
					let valid = next.0 >= 0 && next.0 < lines.count && next.1 >= 0 && next.1 < lines[0].count
					if seen.contains(record) || !valid { return [] }
		
					seen.insert(record)
					energized.insert([next.0, next.1])
				
					let nextDirection: [(Int, Int)] = switch (lines[next.0][next.1], direction) {
					case ("|", (0, _)): [(1, 0), (-1, 0)]
					case ("-", (_, 0)): [(0, 1), (0, -1)]
					case ("/", (_, 0)): [(0, -direction.0)]
					case ("/", (0, _)): [(-direction.1, 0)]
					case ("\\", (_, 0)): [(0, direction.0)]
					case ("\\", (0, _)): [(direction.1, 0)]
					default: [direction]
					}
				
					return nextDirection.map { (next, $0) }
				}
			}
		
			return energized.count			
		}.max()!
	}
}