extension Day8: Puzzle {
	public func solution(for part: Part, given input: String) -> Int {
		let components = input.split(separator: "\n\n")
		let directions = components[0].map(String.init)
		let transitions = components[1].split(separator: "\n").map { $0.split(separator: " = ") }
		let pair = { (line: [Substring]) in (line[0], line[1].matches(of: /[A-Z]{3}/).map(\.output)) }
		let network = Dictionary(uniqueKeysWithValues: transitions.map(pair))
		
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