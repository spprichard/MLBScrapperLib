//
//  RosterService.swift
//  MLBScrapper
//
//  Created by Steven Prichard on 12/15/19.
//

import Foundation


public struct Roster: Codable {
    var TeamID : Int
    var Players : [Player]
}

extension Roster {
    static func GetEndpoint(teamID: Int) -> Endpoint {
        return Endpoint(
            secure: true,
            path: "/named.roster_40.bam",
            queryItems: [
                URLQueryItem(name: "team_id", value: "\(teamID)")
        ])
    }
    
    public static func GetPlayers(for team: Int) throws -> [Player] {
        guard let url = Roster.GetEndpoint(teamID: team).URL else {
            throw Errors.NoContentFound
        }
        
        let decoder = JSONDecoder()
        let data = try Data(contentsOf: url)
        
        let result = try decoder.decode(RosterRequestResult.self, from: data)
        let mlbLookupPlayers = result.roster_40.queryResults.row
        
        return mlbLookupPlayers.map { mlbPlayer in
            return mlbPlayer.toPlayer()
        }
    }
}
