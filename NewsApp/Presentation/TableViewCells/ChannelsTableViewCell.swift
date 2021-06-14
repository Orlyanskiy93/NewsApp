//
//  TableViewCell.swift
//  NewsApp
//
//  Created by Дмитрий Орлянский on 12.06.2021.
//

import UIKit

class ChannelsTableViewCell: UITableViewCell, UIViewInput {
    @IBOutlet weak var favoritesImageView: UIImageView!
    
    var favoritesCellDisplayManager: FavoritesCellDisplayManager?
    private var channel: Channel!
    private var dataService: DataService!
    private var starImage: UIImage = UIImage(systemName: "star") ?? UIImage()
    private var starFillImage: UIImage = UIImage(systemName: "star.fill") ?? UIImage()
    
    @IBOutlet weak var channelTitleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
    private func setup() {
        dataService = DataServiceImp.shared
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
            favoritesImageView.image = starImage
            favoritesCellDisplayManager?.removeFromFavorites(self)
            do {
                try dataService.removeFromFavorites(channel)
            } catch {
                show(error)
            }
        } else {
            channel.isFavorte = true
            favoritesImageView.image = starFillImage
            do {
                try dataService.addToFavorites(channel)
            } catch {
                show(error)
            }
        }
    }
}
