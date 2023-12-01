import ArgumentParser
import Division
import Foundation
import Solution

struct Solve {
    @Option(name: .short) var year: Int?
    @Option(name: .short) var day: Int?
    @Option(name: .short) var part: Int?
}

extension Solve: AsyncParsableCommand {
    func run() async throws {
        let date = Date()
        let year = year ?? Calendar.current.dateComponents([.year], from: date).year!
        let day = day ?? Calendar.current.dateComponents([.day], from: date).day!
        let part = part.flatMap(Part.init) ?? .one
        let url = URL(string: "https://adventofcode.com/\(year)/day/\(day)/input")!
        let cookie = ProcessInfo.processInfo.environment["AOC_COOKIE"]!

        var request = URLRequest(url: url)
        request.addValue("session=\(cookie)", forHTTPHeaderField: "Cookie")

        let (data, _) = try await URLSession.shared.data(for: request)
        let input = String(decoding: data, as: UTF8.self)
        let solution = try Solution(
            year: year,
            day: day,
            part: part,
            input: input
        )

        print(solution)
    }
}
