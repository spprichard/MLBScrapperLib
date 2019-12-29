//
//  Utils.swift
//  MLBScrapper
//
//  Created by Steven Prichard on 11/10/19.
//

import Foundation


public struct Scrapper {
    static func BaseURLComponents(https: Bool, sportCode: SportCode = .MLB) -> URLComponents {
        var c = URLComponents()
        
        if https {
            c.scheme = "https"
        } else {
            c.scheme = "http"
        }
        
        c.host = "lookup-service-prod.mlb.com"
        c.queryItems = [
            URLQueryItem(name: "sport_code", value: "'\(sportCode.rawValue)'"),
        ]
        c.path = "/json"
        
        
        return c
    }
}

public struct Endpoint {
    let path: String
    let queryItems: [URLQueryItem]
    let URL : URL?
    
    init(secure: Bool, path: String, queryItems: [URLQueryItem]) {
        let bcs = Scrapper.BaseURLComponents(https: secure)
        
        self.path = bcs.path + path
        var qi : [URLQueryItem] = []
        if bcs.queryItems != nil {
            qi = bcs.queryItems!
        }
        
        self.queryItems = qi + queryItems
        var c = URLComponents()
        c.scheme = bcs.scheme
        c.host = bcs.host
        c.path = self.path
        c.queryItems = self.queryItems
        self.URL = c.url
    }
}

public enum GameType: String, Codable {
    case R = "R" // regular season
    case S = "S" // spring training
    case E = "E" // exhibition
    case A = "A" // allstar game
    case D = "D" // division series
    case F = "F" // first round
    case L = "L" // league championship
    case W = "W" // world series
}

public enum SportCode: String {
    case MLB = "mlb"
}
public enum AllStarTeamData: String {
    case Y = "Y"
    case N = "N"
}

public enum Errors: Error {
    case NoContentFound
    case DecodingError
    case NilQueryParams
}
