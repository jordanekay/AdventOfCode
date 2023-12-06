extension Day6: Puzzle {
	public func solution(for part: Part, given input: String) -> Int {
		let data: [[Double]] = input.split(separator: "\n").map {
			switch part {
			case .one: $0.split(separator: " ").compactMap { .init($0) }
			case .two: [.init(.init($0.filter(\.isNumber)))!]
			}
		}
		
		return zip(data[0], data[1]).map { time, record in
			let root = (pow(time, 2) - 4 * record).squareRoot()
			let bounds = [-1, 1].map { ($0 * root - time) / 2 }	
			return .init(ceil(bounds[1] - 1) - floor(bounds[0] + 1)) + 1
		}.reduce(1, *)
	}
}