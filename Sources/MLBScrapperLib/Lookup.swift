//
//  LookupService.swift
//  MLBScrapper
//
//  Created by Steven Prichard on 11/10/19.
//

import Foundation

struct RosterRequestResult: Codable {
    var roster_40: RosterQueryResultContainer
    
    struct RosterQueryResultContainer: Codable {
        var queryResults: RosterQueryResult
        
        struct RosterQueryResult: Codable {
            var created: String
            var totalSize: String
            var row: [MLBLookupPlayer]
        }
    }
}

struct TeamListRequestResult: Codable {
    var team_all_season: TeamQueryResultContainer
    
    struct TeamQueryResultContainer: Codable{
        var queryResults: TeamQueryResult
        
        struct TeamQueryResult: Codable {
            var created: String
            var totalSize: String
            var row: [MLBLookupTeam]
        }
    }
}

struct CareerHittingStatsResult: Codable {
    var sport_career_hitting : CHSQueryResultContainer
    
    struct CHSQueryResultContainer: Codable {
        var queryResults: CHSQueryResult
        
        struct CHSQueryResult: Codable {
            var row: MLBLookupPlayer.CareerHittingStats
        }
    }
}
