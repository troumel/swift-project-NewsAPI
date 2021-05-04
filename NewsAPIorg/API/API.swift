import Foundation

// We use this protocol for mock data and web request functions

protocol API {
    func getArticles() -> [Article] // Use this for mock data
    func getArticles(_ completionHandler: @escaping () -> Void) // Use this for json data
}
