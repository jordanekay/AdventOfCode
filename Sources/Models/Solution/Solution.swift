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
		case (2023, 2): Year2023.Day2()
		case (2023, 3): Year2023.Day3()
		case (2023, 4): Year2023.Day4()
		case (2023, 6): Year2023.Day6()
		case (2023, 7): Year2023.Day7()
		case (2023, 8): Year2023.Day8()
		case (2023, 9): Year2023.Day9()
		case (2023, 10): Year2023.Day10()
		case (2023, 11): Year2023.Day11()
		case (2023, 13): Year2023.Day13()
		case (2023, 14): Year2023.Day14()
		case (2023, 15): Year2023.Day15()
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
