import XCTest

@testable import AdventOfCode

// Make a copy of this file for every day to ensure the provided smoke tests
// pass.
final class Day05Tests: XCTestCase {
  // Smoke test data provided in the challenge question
  let testData = Day05.testData()

  func testPart1() throws {
    let challenge = Day05(data: testData)
    XCTAssertEqual(String(describing: challenge.part1()), "3") // 735
  }

  func testPart2() throws {
    let challenge = Day05(data: testData)
    XCTAssertEqual(String(describing: challenge.part2()), "14") // 344306344403172
  }
}
