import XCTest

@testable import AdventOfCode

// Make a copy of this file for every day to ensure the provided smoke tests
// pass.
final class Day06Tests: XCTestCase {
  // Smoke test data provided in the challenge question
  let testData = Day06.testData()

  func testPart1() throws {
    let challenge = Day06(data: testData)
    XCTAssertEqual(String(describing: challenge.part1()), "4277556") // 6169101504608
  }

  func testPart2() throws {
    let challenge = Day06(data: testData)
    XCTAssertEqual(String(describing: challenge.part2()), "3263827") // 10442199710797
  }
}
