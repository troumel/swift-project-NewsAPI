import UIKit
import WebKit
import SDWebImage
import SafariServices

class NewsDetailViewController: UIViewController, WKNavigationDelegate {
    
    @IBOutlet weak var imageView: UIImageView?
    @IBOutlet weak var titleLabel: UILabel?
    @IBOutlet weak var subtitleLabel: UILabel?
    @IBOutlet weak var webView: WKWebView?
    @IBOutlet weak var heightConstraint: NSLayoutConstraint? // Change constraint with code
    
    var article: Article!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        assert(article != nil, "article == nil in NewsSetailViewController!") // assert if smth is true(article != nil), if not crash the app!
        
        if let articleTitle = article.title,
           let author = article.author,
           let url = article.url,
           let content = article.content,
           let image = article.urlToImage,
           let articleDate = article.publishedAt {
            
            let formatter = ISO8601DateFormatter()
            let date = formatter.date(from: articleDate)
            
            title = articleTitle
            titleLabel?.text = articleTitle
            subtitleLabel?.text = "\(formatter.string(from: date!)) · \(author)"
            imageView?.sd_setImage(with: URL(string: image), completed: nil)
            
            webView?.loadHTMLString("""
                <html>
                    <head>
                        <style>
                            body {
                                font-family: -apple-system, Helvetica; sans-serif;
                                font-size: 17px;
                                color: #555;
                                padding: 12px;
                                margin:0;
                                }
                            a.button {
                                display: block;
                                box-sizing: border-box;
                                width: 100%;
                                padding: 10px;
                                background: #1167b1;
                                color: white;
                                text-align: center;
                                text-decoration: none;
                                border-radius:5px;
                                box-shadow: 2px 5px #03254c;
                                }
                        </style>
                        <meta name="viewport" content="width=device-width, initial-scale=1">
                    </head>
                    <body>
                        \(content)
                        <br>
                        <br>
                        <a class="button" href="\(url)">Go to article</a>
                    </body>
                </html>
            """, baseURL: nil)
        }
        
        webView?.navigationDelegate = self
    }
    
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        webView.evaluateJavaScript("document.readyState") { (result, error) in
            if result == nil || error != nil {
                return
            }
            
            webView.evaluateJavaScript("document.body.offsetHeight") { (result, error) in
                if let height = result as? CGFloat {
                    self.heightConstraint?.constant = height
                }
            }
        }
    }
    
    // open url with safari app
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        guard navigationAction.navigationType == .linkActivated else {
            decisionHandler(.allow)
            return
        }
        
        if let url = navigationAction.request.url {
            UIApplication.shared.open(url)
            decisionHandler(.cancel)
            return
        }
        
        decisionHandler(.allow)
    }
}



