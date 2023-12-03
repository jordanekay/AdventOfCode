public protocol Puzzle {
	associatedtype Solution: CustomStringConvertible

	init()

	func solution(for part: Part, given input: String) -> Solution
}
