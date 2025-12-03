import XCTest

@testable import AdventOfCode

// Make a copy of this file for every day to ensure the provided smoke tests
// pass.
final class Day03Tests: XCTestCase {
  // Smoke test data provided in the challenge question
  let testData = Day03.testData()

  func testPart1() throws {
    let challenge = Day03(data: testData)
    XCTAssertEqual(String(describing: challenge.part1()), "357") // 17193
  }

  func testPart2() throws {
    let challenge = Day03(data: testData)
    XCTAssertEqual(String(describing: challenge.part2()), "3121910778619") // 171297349921310
  }
}
