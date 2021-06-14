//
//  ChannelsPresenter.swift
//  NewsApp
//
//  Created by Дмитрий Орлянский on 12.06.2021.
//

import Foundation
import PromiseKit

class ChannelsPresenter: ChannelsViewOutput {
    private weak var view: ChannelsViewInput!
    private var newsService: NewsApiService!
    private var dataService: DataService!
    
    init(_ view: ChannelsViewInput) {
        self.view = view
        newsService = NewsApiServiceImp.shared
        dataService = DataServiceImp.shared
    }
    
    func viewIsReady() {
        view.setupInitialState()
        guard dataService.state == .enable else {
            let message = "You can use app, but you favorite channels will not be saved"
            view.show(title: "Error", message: message)
            return
        }
        loadNews()
    }
        
    func loadNews() {
        view.startLoading()
        firstly {
            newsService.getAllChannels()
        } .done { [weak self] channels in
            if let self = self {
                let favorites = self.dataService.favoriteChannels
                var allChannels = [Channel]()
                channels.forEach { channel in
                    if favorites.contains(where: { $0.title == channel.title }) {
                        let channel = Channel(isFavorte: true, title: channel.title, news: channel.news)
                        allChannels.append(channel)
                    } else {
                        allChannels.append(channel)
                    }
                }
                try self.dataService.save(allChannels)
                self.view.update(allChannels)
                self.view.stopLoading()
            }
        } .catch { [weak self] error in
            self?.view.show(error) { [weak self] _ in
                if let self = self {
                    let channels = self.dataService.allChannels
                    self.view.update(channels)
                    self.view.stopLoading()
                }
            }
        }
    }
}
