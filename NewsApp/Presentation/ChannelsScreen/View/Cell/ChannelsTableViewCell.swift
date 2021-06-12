//
//  TableViewCell.swift
//  NewsApp
//
//  Created by Дмитрий Орлянский on 12.06.2021.
//

import UIKit

class ChannelsTableViewCell: UITableViewCell {
    static let identifier: String = "ChannelsTableViewCell"
    @IBOutlet weak var favoritesImageView: UIImageView!
    private var channel: Channel!
    private var newsService: NewsService!
    private var starImage: UIImage = UIImage(systemName: "star") ?? UIImage()
    private var starFillImage: UIImage = UIImage(systemName: "star.fill") ?? UIImage()

    
    
    @IBOutlet weak var channelTitleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
    private func setup() {
        newsService = NewsServiceImp.shared
        self.selectionStyle = .none
        let gestureRecognizer = UITapGestureRecognizer()
        gestureRecognizer.addTarget(self, action: #selector(favoritesSetup))
        addGestureRecognizer(gestureRecognizer)
        favoritesImageView.addGestureRecognizer(gestureRecognizer)
        favoritesImageView.isUserInteractionEnabled = true
    }
    
    func fill(with channel: Channel) {
        self.channel = channel
        favoritesImageView.image = channel.isFavorte ? starFillImage : starImage
        channelTitleLabel.text = channel.title
    }
    
    @objc func favoritesSetup() {
        if channel.isFavorte {
            channel.isFavorte = false
            newsService.removeFromFavorites(channel)
            favoritesImageView.image = starImage
        } else {
            channel.isFavorte = true
            newsService.addToFavorites(channel)
            favoritesImageView.image = starFillImage
        }
    }
}
