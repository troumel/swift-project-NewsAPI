import Foundation

// we use mock data, for testing and by replacing the getArticles function in future, we switch to real web request data

class MockAPI: API {
    func getArticles() -> [Article] {
        let article = Article()
        article.title = "Some title"
        article.content = "Some text text text text text"
        article.url = "https://www.apple.com/mac/"
        article.urlToImage = "https://placeimg.com/1000/800/nature"
        article.author = "Theo Roum"
        
        return Array(repeating: article, count: 10)
    }
    
    func getArticles(_ completionHandler: @escaping () -> Void) { //
        completionHandler() // returns just an empty closure. we don't need this function for mock data
    }
}
