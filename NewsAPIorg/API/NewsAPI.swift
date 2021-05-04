import Foundation
import RealmSwift

// we switch to this function, after done with mock data. Here we are making the networking. 

class NewsAPI: API {
    func getArticles() -> [Article] {
        return [Article]()
    }
    
    func getArticles(_ completionHandler: @escaping () -> Void) {
        let apiKey = URLQueryItem(name: "apiKey", value: "f68390243b65458a9bfeef9adebdff45")
        let sources = URLQueryItem(name: "sources", value: "techcrunch")
        var urlComponents = URLComponents(string: "https://newsapi.org/v2/top-headlines")!
        urlComponents.queryItems = [apiKey, sources]
        
        let task = URLSession.shared.dataTask(with: urlComponents.url!) { (data, response, error) in
            if error != nil {
                print("*** ERROR *** \(error!.localizedDescription)")
                return
            }
            if data == nil || response == nil {
                print("Something went wrong!")
                return
            }
            let realm = try! Realm()
            realm.beginWrite()
            
            do {
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601
                let response = try decoder.decode(Response.self, from: data!)
                for article in response.articles {
                    realm.add(article, update: .modified)
                }
            } catch {
                print("JSON ERROR \(error.localizedDescription)")
                return
            }
            
            do {
                try realm.commitWrite()
            } catch (let error) {
                print("ERROR \(error)")
            }
            
            DispatchQueue.main.async {
                completionHandler()
            }
        }
        task.resume()
    }
}
