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
    private var newsService: NewsService!
    
    init(_ view: ChannelsViewInput) {
        self.view = view
        newsService = NewsServiceImp.shared
    }
    
    func viewIsReady() {
        view.setupInitialState()
        loadNews()
    }
    
    func loadNews() {
        firstly {
            newsService.getAllChannels()
        } .done { [weak self] channels in
            self?.view.update(channels)
        } .catch { error in
            print(error)
        }
    }
    
    
}
