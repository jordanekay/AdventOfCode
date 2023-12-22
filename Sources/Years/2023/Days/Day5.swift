extension Day5: Puzzle {
	public func solution(for part: Part, given input: String) -> Int {
		let input = """
		seeds: 79 14 55 13
		
		seed-to-soil map:
		50 98 2
		52 50 48
		
		soil-to-fertilizer map:
		0 15 37
		37 52 2
		39 0 15
		
		fertilizer-to-water map:
		49 53 8
		0 11 42
		42 0 7
		57 7 4
		
		water-to-light map:
		88 18 7
		18 25 70
		
		light-to-temperature map:
		45 77 23
		81 45 19
		68 64 13
		
		temperature-to-humidity map:
		0 69 1
		1 0 69
		
		humidity-to-location map:
		60 56 37
		56 93 4
		"""
		
		let sections = input.split(separator: "\n\n")
		let seedItems = sections[0].split(separator: " ")
		let seedInfo = seedItems.dropFirst().map { Int($0)! }.enumerated()
		// let counts = [0, 1].map { r in seedInfo.compactMap { $0 % 2 == r ? $1 : nil } }
		let data = sections.dropFirst().map { section in
			section.split(separator: "\n").dropFirst().map { line in
				let digits = line.split(separator: " ").map { Int($0)! }
				return (digits[1], digits[0] - digits[1], digits[2])
			}
		}
		
		print(data)
		return 0
	}
}
