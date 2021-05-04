import UIKit

class ArticleCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel?
    @IBOutlet weak var subtitleLabel: UILabel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        commonInit()
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        commonInit()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func commonInit() {  // empty the cell when it is first created(awakeFromNib) and when is reused(prepareForReuse)
        titleLabel?.text = ""
        subtitleLabel?.text = ""
    }
    
    func configureCell(with article: Article) {
     
     if let title = article.title,
        let author = article.author,
        let articleDate = article.publishedAt {
            
            let formatter = ISO8601DateFormatter()
            let date = formatter.date(from: articleDate)
            titleLabel?.text = title
            subtitleLabel?.text = "\(formatter.string(from: date!)) · \(author)" // interpunct symbol: shift+option+9
        }
    }
}
