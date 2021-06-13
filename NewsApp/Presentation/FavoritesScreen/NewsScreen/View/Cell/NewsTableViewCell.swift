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
    @IBOutlet weak var container: UIView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        newsItemImageView.layer.cornerRadius = 30
        container.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        container.layer.cornerRadius = 30
        activityIndicator.hidesWhenStopped = true
        startLoading()
    }
    
    func startLoading() {
        newsItemImageView.isHidden = true
        activityIndicator.startAnimating()
    }
    
    func stopLoading() {
        newsItemImageView.isHidden = false
        activityIndicator.stopAnimating()
    }

    func fill(with newsItem: NewsItem) {
        newsItemTitleLabel.text = newsItem.title
        newsItemDescriptionLabel.text = newsItem.description
        guard let urlString = newsItem.imageUrlString else {
            newsItemImageView.image = UIImage(named: "newsPaper")
            stopLoading()
            return
        }
        
        let url = URL(string: urlString)!
        newsItemImageView.kf.setImage(with: url) { [weak self] result in
            switch result {
            case .success(_):
                self?.stopLoading()
            case .failure(_):
                self?.newsItemImageView.image = UIImage(named: "newsPaper")
                self?.stopLoading()
            }
        }
    }
}
