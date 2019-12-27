//
//  TeamService.swift
//  MLBScrapper
//
//  Created by Steven Prichard on 11/10/19.
//
import Foundation

final public class Team: Codable {
    public var id: Int?
    public var VenueID: Int
    public var VenueName: String
    public var Name: String
    public var DivisionID: Int
    
    enum CodingKeys: String, CodingKey {
        case id = "mlb_org_id"
        case Name = "name"
        case VenueID = "venue_id"
        case VenueName = "venue_name"
        case DivisionID = "division_id"
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        let tmpID = try values.decode(String.self, forKey: .id)
        id = Int(tmpID) ?? -1
        
        let vID = try values.decode(String.self, forKey: .VenueID)
        VenueID = Int(vID) ?? -1
        
        VenueName = try values.decode(String.self, forKey: .VenueName)
        Name = try values.decode(String.self, forKey: .Name)
        
        let dID = try values.decode(String.self, forKey: .DivisionID)
        DivisionID = Int(dID) ?? -1
    }
}

extension Team {
    static func GetEndpoint(allStar: AllStarTeamData, season: Int) -> Endpoint {
        return Endpoint(
            secure: true,
            path: "/named.team_all_season.bam",
            queryItems: [
                URLQueryItem(name: "season", value: String(season)),
                URLQueryItem(name: "all_star_sw", value: "'\(allStar.rawValue)'"),
        ])
    }
    
    public static func GetTeams(season: Int) throws -> [Team] {
        guard let url = Team.GetEndpoint(allStar: .N, season: season).URL else {
            throw Errors.NoContentFound
        }
        
        let decoder = JSONDecoder()
        let d = try? Data(contentsOf: url)
        
        guard let data = d else {
            throw Errors.NoContentFound
        }
        
        let result = try decoder.decode(TeamListRequestResult.self, from: data)
        return result.team_all_season.queryResults.row
    }
}
