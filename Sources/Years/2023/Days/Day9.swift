extension Day9: Puzzle {
	public func solution(for part: Part, given input: String) -> Int {
		func nextSum(_ digits: [Int]) -> Int {
			let (sign, next) = part == .one ? (1, digits.last!) : (-1, digits.first!)
			let digits = zip(digits.dropFirst(), digits).map(-)
			return next + sign * (Set(digits) == [0] ? 0 : nextSum(digits))
		}
		
		return input.split(separator: "\n").reduce(0) {
			let digits = $1.split(separator: " ").map { Int($0)! }
			return $0 + nextSum(digits)
		}
	}
}