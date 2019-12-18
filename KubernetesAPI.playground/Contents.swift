import Foundation

let url = URL(string: "https://127.0.0.1:6443/api/v1/namespaces")!
var request = URLRequest(url: url)
request.httpMethod = "POST"

let decoder = JSONDecoder()

let session = URLSession.shared


enum Errors: Error {
    case EmptyResponseData
}


do {
    let s = try String(contentsOf: url)
    print(s)
    
    
    
} catch(let error){
    print(error)
    
}


