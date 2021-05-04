import Foundation
import RealmSwift

// the json of an article

class Article: Object, Codable {
    @objc dynamic var author: String?
    @objc dynamic var url: String?
    @objc dynamic var title: String?
    @objc dynamic var content: String? //text
    @objc dynamic var urlToImage: String?
    @objc dynamic var publishedAt: String?
    
    override static func primaryKey() -> String? {
        "url"
    }
}
