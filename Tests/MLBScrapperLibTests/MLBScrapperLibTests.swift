import XCTest
import class Foundation.Bundle
@testable import MLBScrapperLib

final class MLBScrapperTests: XCTestCase {    
    func testBuildBaseURL() throws {
        let expected = URL(string: "https://lookup-service-prod.mlb.com/json?sport_code='mlb'")
        let actual = Scrapper.BaseURLComponents(https: true)
        XCTAssertEqual(expected, actual.url)
    }
    
    func testTeamEndpontURLGeneration() throws {
        let expected = URL(string: "https://lookup-service-prod.mlb.com/json/named.team_all_season.bam?sport_code='mlb'&season=2019&all_star_sw='N'")
        let actual = Team.GetEndpoint(allStar: .N, season: 2019)
        XCTAssertEqual(expected, actual.URL)
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

    static var allTests = [
        ("testBuildBaseURL", testBuildBaseURL),
    ]
}
