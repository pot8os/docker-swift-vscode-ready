import XCTest

import class Foundation.Bundle

final class Tests: XCTestCase {
  func testExample() throws {
    // Mac Catalyst won't have `Process`, but it is supported for executables.
    #if !targetEnvironment(macCatalyst)
      let fooBinary = productsDirectory.appendingPathComponent("docker-swift-vscode-ready")
      let process = Process()
      process.executableURL = fooBinary
      let pipe = Pipe()
      process.standardOutput = pipe
      try process.run()
      process.waitUntilExit()
      let data = pipe.fileHandleForReading.readDataToEndOfFile()
      let output = String(data: data, encoding: .utf8)
      XCTAssertEqual(output, "Hello, world!\n10\n")
    #endif
  }

  /// Returns path to the built products directory.
  var productsDirectory: URL {
    #if os(macOS)
      for bundle in Bundle.allBundles where bundle.bundlePath.hasSuffix(".xctest") {
        return bundle.bundleURL.deletingLastPathComponent()
      }
      fatalError("couldn't find the products directory")
    #else
      return Bundle.main.bundleURL
    #endif
  }
}
