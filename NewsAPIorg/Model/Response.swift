import Foundation

// The JSON object from newsapi.org

struct Response: Codable {
 
    var status: String = ""
    var totalResults: Int = 0
    var articles: [Article]
    
}
