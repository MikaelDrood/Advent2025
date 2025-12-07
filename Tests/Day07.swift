import XCTest

@testable import AdventOfCode

// Make a copy of this file for every day to ensure the provided smoke tests
// pass.
final class Day07Tests: XCTestCase {
  // Smoke test data provided in the challenge question
  let testData = Day07.testData()

  func testPart1() throws {
    let challenge = Day07(data: testData)
    XCTAssertEqual(String(describing: challenge.part1()), "21") // 1698
  }

  func testPart2() throws {
    let challenge = Day07(data: testData)
    XCTAssertEqual(String(describing: challenge.part2()), "40") // 95408386769474
  }
}
