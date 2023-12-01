import Divisions
import Year2022
import Year2023

public struct Solution: CustomStringConvertible {
	public let description: String

	public init(
		year: Int,
		day: Int,
		part: Part,
		input: String
	) throws {
		let puzzle: any Puzzle = switch (year, day) {
		case (2022, 1): Year2022.Day1()
		case (2023, 1): Year2023.Day1()
		default: throw Error.invalidDay
		}

		description = puzzle.solution(for: part, given: input).description
	}
}

public extension Solution {
	enum Error: String, Swift.Error {
		case invalidDay = "Invalid day"
		case invalidYear = "Invalid year"
	}
}
