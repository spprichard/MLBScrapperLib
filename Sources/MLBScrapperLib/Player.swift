//
//  PlayerService.swift
//  MLBScrapper
//
//  Created by Steven Prichard on 11/10/19.
//

import Foundation

public struct Player: Codable {
    var ID: Int
    var FullName: String
    var Postion: String
    var Bats: String
    var TeamName: String
    var TeamID: Int
    
    public struct CareerHittingStats: Codable {
        var Homeruns: Int
        var GroundedIntoDoublePlay: Int
        var NumberOfPitches: Int
        var TotalBases: Int
        var BattingAverage: Float
        var OnBasePlusSlugging: Float
        var SluggingAverage: Float
        var AtBats: Int
        var Hits: Int
        var Runs: Int
        var OnBasePercentage: Float
        var HitByPitch: Int
        var Games: Int
        var RunsBattedIn: Float
        var BattingAverageOnBallsInPlay: Float
        var BaseOnBalls: Int
        
        enum CodingKeys: String, CodingKey {
            case Homeruns = "hr"
            case GroundedIntoDoublePlay = "gidp"
            case NumberOfPitches = "np" //  Pitches thrown
            case TotalBases = "tb" // [H + 2B + (2 × 3B) + (3 × HR)] or [1B + (2 × 2B) + (3 × 3B) + (4 × HR)]
            case BattingAverage = "avg" // Hits / At-Bats
            case OnBasePlusSlugging = "ops" // On-Base Percentage + Slugging Average
            case SluggingAverage = "slg" // Total Bases / At-Bats
            case AtBats = "ab" // At-Bats
            case Hits = "h"
            case Runs = "r"
            case OnBasePercentage = "obp" // OnBase Percentage =  times reached base (H + BB + HBP) / AtBats plus walks plus hit by pitch plus sacrifice flies (AB + BB + HBP + SF)
            case HitByPitch = "hbp"
            case Games = "g"
            case RunsBattedIn = "rbi"
            case BattingAverageOnBallsInPlay = "babip" // frequency at which a batter reaches a base after putting the ball in the field of play
            case BaseOnBalls = "bb"
        }
        
        public init(from decoder: Decoder) throws {
            let values = try decoder.container(keyedBy: CodingKeys.self)
            let hr = try values.decode(String.self, forKey: .Homeruns)
            Homeruns = Int(hr) ?? -1
            let gidp = try values.decode(String.self, forKey: .GroundedIntoDoublePlay)
            GroundedIntoDoublePlay = Int(gidp) ?? -1
            let np = try values.decode(String.self, forKey: .NumberOfPitches)
            NumberOfPitches = Int(np) ?? -1
            let tp = try values.decode(String.self, forKey: .TotalBases)
            TotalBases = Int(tp) ?? -1
            let ba = try values.decode(String.self, forKey: .BattingAverage)
            BattingAverage = Float(ba) ?? -1.0
            let ops = try values.decode(String.self, forKey: .OnBasePlusSlugging)
            OnBasePlusSlugging = Float(ops) ?? -1.0
            let slg = try values.decode(String.self, forKey: .SluggingAverage)
            SluggingAverage = Float(slg) ?? -1.0
            let ab = try values.decode(String.self, forKey: .AtBats)
            AtBats = Int(ab) ?? -1
            let h = try values.decode(String.self, forKey: .Hits)
            Hits = Int(h) ?? -1
            let r = try values.decode(String.self, forKey: .Runs)
            Runs = Int(r) ?? -1
            let obp = try values.decode(String.self, forKey: .OnBasePercentage)
            OnBasePercentage = Float(obp) ?? -1.0
            let hbp = try values.decode(String.self, forKey: .HitByPitch)
            HitByPitch = Int(hbp) ?? -1
            let g = try values.decode(String.self, forKey: .Games)
            Games = Int(g) ?? -1
            let rbi = try values.decode(String.self, forKey: .RunsBattedIn)
            RunsBattedIn = Float(rbi) ?? -1.0
            let babip = try values.decode(String.self, forKey: .BattingAverageOnBallsInPlay)
            BattingAverageOnBallsInPlay = Float(babip) ?? -1.0
            let bb = try values.decode(String.self, forKey: .BaseOnBalls)
            BaseOnBalls = Int(bb) ?? -1
        }
        
        private static func GetEndpoint(gameType: GameType, playerID: Int) -> Endpoint {
            return Endpoint(
                secure: true,
                path: "/named.sport_career_hitting.bam",
                queryItems: [
                    URLQueryItem(name: "game_type", value: "'\(gameType.rawValue)'"),
                    URLQueryItem(name: "player_id", value: "'\(playerID)'")
            ])
        }
        
        static public func GetCareerHittingStats(gameType: GameType, playerID: Int) throws -> CareerHittingStats {
            guard let url = Player.CareerHittingStats.GetEndpoint(gameType: gameType, playerID: playerID).URL else {
                throw Errors.NoContentFound
            }
            
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            
            let result = try decoder.decode(CareerHittingStatsResult.self, from: data)
            return result.sport_career_hitting.queryResults.row
        }
    }
    
    enum CodingKeys: String, CodingKey {
        case ID = "player_id"
        case FullName = "name_display_first_last"
        case Postion = "position_txt"
        case Bats = "bats"
        case TeamName = "team_name"
        case TeamID = "team_id"
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        let id = try values.decode(String.self, forKey: .ID)
        ID = Int(id) ?? -1
        
        FullName = try values.decode(String.self, forKey: .FullName)
        Postion = try values.decode(String.self, forKey: .Postion)
        Bats = try values.decode(String.self, forKey: .Bats)
        TeamName = try values.decode(String.self, forKey: .TeamName)
        let tID = try values.decode(String.self, forKey: .TeamID)
        TeamID = Int(tID) ?? -1
    }
}
