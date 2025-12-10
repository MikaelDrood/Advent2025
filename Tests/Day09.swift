import XCTest

@testable import AdventOfCode

// Make a copy of this file for every day to ensure the provided smoke tests
// pass.
final class Day09Tests: XCTestCase {
  // Smoke test data provided in the challenge question
  let testData = Day09.testData()

  func testPart1() throws {
    let challenge = Day09(data: testData)
    XCTAssertEqual(String(describing: challenge.part1()), "50") // 4745816424
  }

  func testPart2() throws {
    let challenge = Day09(data: testData)
    XCTAssertEqual(String(describing: challenge.part2()), "")
  }
}
