//
//  NewsTableViewCell.swift
//  NewsApp
//
//  Created by Дмитрий Орлянский on 13.06.2021.
//

import UIKit
import Kingfisher

class NewsTableViewCell: UITableViewCell {
    @IBOutlet weak var newsItemImageView: UIImageView!
    @IBOutlet weak var newsItemTitleLabel: UILabel!
    @IBOutlet weak var newsItemDescriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        newsItemImageView.layer.cornerRadius = 20
    }

    func fill(with newsItem: NewsItem) {
        newsItemTitleLabel.text = newsItem.title
        newsItemDescriptionLabel.text = newsItem.description
        guard let urlString = newsItem.imageUrlString else {
            newsItemImageView.image = UIImage(named: "newsPaper")
            return
        }
        let url = URL(string: urlString)!
        newsItemImageView.kf.setImage(with: url)
    }
}
