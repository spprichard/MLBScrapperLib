import MLBScrapper


do {
    
    let chs = try Player.CareerHittingStats.GetCareerHittingStats(gameType: GameType.R, playerID: 596105)
    print(chs)
    
//    let players = try Roster.GetPlayers(for: 110)
//    print("Was able to retrieve: \(players.count)")
//    print(players)
} catch(let error) {
    print("ERROR: \(error)")
}



//https://lookup-service-prod.mlb.com/json/named.roser_40.bam?sport_code='mlb'&team_id='110'
//http://lookup-service-prod.mlb.com/json/named.roster_40.bam?team_id=''
