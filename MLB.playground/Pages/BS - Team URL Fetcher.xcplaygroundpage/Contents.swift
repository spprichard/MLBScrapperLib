// BS: Baseball Savant - https://baseballsavant.mlb.com
import Foundation
import PlaygroundSupport

enum Status: String, Codable {
    case good
    case bad
}

struct Result: Codable {
    var staus: Status
    var url: String
    var data: Data?
}

func generateURL(start: Int, stop: Int) -> [URL] {
    var urls : [URL] = []
    
    for i in start...stop {
        urls.append(URL(string: "https://baseballsavant.mlb.com/team/\(i)")!) // should not scrape from this URL
    }
    
    return urls
}

func process(urls: [URL]) -> [Result] {
    return urls.map { url in
        
        let d = try? Data(contentsOf: url)
        guard let data = d else {
            return Result(staus: .bad, url: url.absoluteString, data: nil)
        }
        
        return Result(staus: .good, url: url.absoluteString, data: data)
    }
}

func counts(results: [Result]) -> (goodCount: Int, badCount: Int) {
    var good = 0
    var bad = 0
    
    results.map{ result in
        switch result.staus {
        case .good:
            good += 1
        case .bad:
            bad += 1
        }
    }
    
    return (goodCount: good, badCount: bad)
}

func write(data: Data, to filename: String) throws {
    let fileURL = playgroundSharedDataDirectory.appendingPathComponent(filename)
    
    do {
        try data.write(to: fileURL)
    } catch(let error) {
        throw error
    }
    
}



func run() {
    print("starting...")
    let encoder = JSONEncoder()
    
    print("gathering data...")
    let urls = generateURL(start: 0, stop: 200)
    let results = process(urls: urls)
    let summary = counts(results: results)
    print(summary)
    
    print("witing to file...")
    do {
        let d = try encoder.encode(results)
        try write(data: d, to: "teams_data.json")
    } catch(let error) {
        print("Error occured writing to file: \(error.localizedDescription)")
    }
    
    
    print("Done!")
}
run()
