extension Day8: Puzzle {
	public func solution(for part: Part, given input: String) -> Int {
		let components = input.split(separator: "\n\n")
		let (directions, lines) = (components[0].map(String.init), components[1].split(separator: "\n"))
		let nodes = lines.map { $0.matches(of: /[A-Z]{3}/).map(\.output) }
		let network = Dictionary(uniqueKeysWithValues: nodes.map { ($0[0], [$0[1], $0[2]]) })
		
		func lcm(_ a: Int, _ b: Int) -> Int { a * b / gcd(a, b) }
		func gcd(_ a: Int, _ b: Int) -> Int { b == 0 ? a : gcd(b, a % b) }		
		let index: (Int) -> Int = { ["L", "R"].firstIndex(of: directions[$0 % directions.count])! }
		
		let tests: [(Substring) -> Bool] = switch part {
		case .one: ["AAA", "ZZZ"].map { string in { $0 == string } }
		case .two: ["A", "Z"].map { string in { $0.last == string} }
		}
		
		return network.keys.filter(tests[0]).map {
			var (step, node) = (0, $0)
			while !tests[1](node) { node = network[node]![index(step)]; step += 1 }
			return step
		}.reduce(1, lcm)
	}
}