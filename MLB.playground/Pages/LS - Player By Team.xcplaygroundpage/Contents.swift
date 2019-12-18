// LS: Lookup Service,  http://lookup-service-prod.mlb.com
import Foundation

struct RosterRequestResult: Codable {
    var roster40: RosterQueryResultContainer
    
    struct RosterQueryResultContainer: Codable {
        var queryResults: RosterQueryResult
        
        struct RosterQueryResult: Codable {
            var created: String
            var totalSize: String
            var row: [RosterResult]
            
            struct RosterResult: Codable {
                var positionTxt: String
                var nameDisplayFirstLast: String
                var college: String
                var heightInches: String
                var weight: String
                var jerseyNumber: String
                var bats: String
                var primaryPosition: String
                var statusCode: String
                var teamName: String
                var teamAbbrev: String
                var playerId: String
                var teamId: String
            }
        }
    }
}

struct Player {
    var ID: Int
    var FullName: String
    var Postion: String
    var Bats: String
    var TeamName: String
    var TeamAbbrev: String
    var TeamID: Int
}


enum Errors: Error {
    case NoContentFound
    case DecodingError
}

extension RosterRequestResult {
    func toPlayers() -> [Player] {
        var players : [Player] = []
        
        self.roster40.queryResults.row.map { result in
            var p = Player(
                ID: Int(result.playerId) ?? 0,
                FullName: result.nameDisplayFirstLast,
                Postion: result.positionTxt,
                Bats: result.bats,
                TeamName: result.teamName,
                TeamAbbrev: result.teamAbbrev,
                TeamID: Int(result.teamId) ?? 0
            )
            
            players.append(p)
        }
        
        return players
    }
}

let decoder = JSONDecoder()
decoder.keyDecodingStrategy = .convertFromSnakeCase

let url = URL(string: "http://lookup-service-prod.mlb.com/json/named.roster_40.bam?team_id=109")!
let d = try? Data(contentsOf: url)
guard let data = d else {
    throw Errors.NoContentFound
}

do {
    let result = try decoder.decode(RosterRequestResult.self, from: data)
    let players = result.toPlayers()
    
    print(players)
    
} catch let decodingError {
    print("Decoding Error: \n\(decodingError)")
}

