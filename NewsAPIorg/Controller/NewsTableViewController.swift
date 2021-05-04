import UIKit
import Swift
import RealmSwift

class NewsTableViewController: UITableViewController {
    
    var api: API
    //  var articles = [Article]() // we use this for mock data
    
    var articles: Results<Article> {
        try! Realm().objects(Article.self).sorted(byKeyPath: "publishedAt", ascending: false)
    } // query the db, fetch articles and sort them
    
    required init?(coder: NSCoder) { // override init
        //        api = MockAPI() // prepare for dependency injection
        api = NewsAPI()
        super.init(coder: coder) // call super init, ONLY after property initialisation
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "News"
        //      articles = api.getArticles()
        api.getArticles {
            self.tableView.reloadData()
        }
        
        //when using prototype cell no need to register any cell
        //tableView.register(UITableViewCell.self, forCellReuseIdentifier: "articleCell")
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // return the number of rows
        return articles.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "articleCell", for: indexPath) as! ArticleCell // we added typecasting because we use our own cell class, not just UITableViewCell
        //        cell.textLabel?.text = articles[indexPath.row].title
        
        cell.configureCell(with: articles[indexPath.row])
        
        return cell
    }
    
    // pass an article object to detailVC through segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let detailVC = segue.destination as? NewsDetailViewController,
           let indexPath = tableView.indexPathForSelectedRow {
            detailVC.article = articles[indexPath.row]
        }
    }
}
