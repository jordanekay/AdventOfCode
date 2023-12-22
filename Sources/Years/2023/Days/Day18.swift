extension Day18: Puzzle {
	public func solution(for part: Part, given input: String) -> Int {
		let input = """
		R 6 (#70c710)
		D 5 (#0dc571)
		L 2 (#5713f0)
		D 2 (#d2c081)
		R 2 (#59c680)
		D 2 (#411b91)
		L 5 (#8ceee2)
		U 2 (#caa173)
		L 1 (#1b58a2)
		U 2 (#caa171)
		R 2 (#7807d2)
		U 3 (#a77fa3)
		L 2 (#015232)
		U 2 (#7a21e3)
		"""

		let directions: [Substring: [Int]] = ["R": [0, 1], "D": [1, 0], "L": [0, -1], "U": [-1, 0]]
		let lines = input.split(separator: "\n")
		let matches = lines.map { $0.firstMatch(of: /(.*) (.*) \((.*)\)/)! }
		let list = matches.map(\.output).reduce([[1, 1]]) {
			let (_, direction, number, _) = $1
			let count = Int(number)!
			let current = Array(repeating: $0.last!, count: count)
			let trench = (1...count).map { x in directions[direction]!.map { $0 * x } }
			let path = zip(current, trench).map { zip($0, $1).map(+) }
			return $0 + path
		}
		
		// var fillCount = 0
		// var filled: Set<[Int]> = [[0, 0]]
		let mins = [0, 1].map { index in list.map { $0[index] }.min()! - 1 }
		let holes = Set(list.map { zip($0, mins).map(-) })
		
		print(holes)
		return holes.count
	}
}