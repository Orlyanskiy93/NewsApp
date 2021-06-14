//
//  NewsPresenter.swift
//  NewsApp
//
//  Created by Дмитрий Орлянский on 13.06.2021.
//

import Foundation

class NewsPresenter: NewsViewOutput {
    private weak var view: NewsViewInput!
    private var dataService: DataService!
    
    init(_ view: NewsViewInput) {
        self.view = view
        dataService = DataServiceImp.shared
    }
    
    func viewIsReady() {
        view.setupInitialState()
        loadNews()
    }
    
    func loadNews() {
        let favoriteChannels = dataService.favoriteChannels
        var news = [NewsItem]()
        
        favoriteChannels.forEach { channel in
            news.append(contentsOf: channel.news)
        }
        
        view.update(news)
    }
}
