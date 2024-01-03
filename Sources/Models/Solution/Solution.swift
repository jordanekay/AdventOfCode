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
		case (2023, 5): Year2023.Day5()
		case (2023, 6): Year2023.Day6()
		case (2023, 7): Year2023.Day7()
		case (2023, 8): Year2023.Day8()
		case (2023, 9): Year2023.Day9()
		case (2023, 10): Year2023.Day10()
		case (2023, 11): Year2023.Day11()
		case (2023, 12): Year2023.Day12()
		case (2023, 13): Year2023.Day13()
		case (2023, 14): Year2023.Day14()
		case (2023, 15): Year2023.Day15()
		case (2023, 16): Year2023.Day16()
		case (2023, 17): Year2023.Day17()
		case (2023, 18): Year2023.Day18()
		case (2023, 19): Year2023.Day19()
		case (2023, 20): Year2023.Day20()
		case (2023, 21): Year2023.Day21()
		case (2023, 22): Year2023.Day22()
		case (2023, 23): Year2023.Day23()
		case (2023, 24): Year2023.Day24()
		case (2023, 25): Year2023.Day25()
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
