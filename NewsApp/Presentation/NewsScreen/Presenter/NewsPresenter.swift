//
//  NewsPresenter.swift
//  NewsApp
//
//  Created by Дмитрий Орлянский on 13.06.2021.
//

import Foundation

class NewsPresenter: NewsViewOutput {
    private weak var view: NewsViewInput!
    private var newsService: NewsService!
    
    init(_ view: NewsViewInput) {
        self.view = view
        newsService = NewsServiceImp.shared
    }
    
    func viewIsReady() {
        view.setupInitialState()
        let news = loadNews()
        view.update(news)
    }
    
    func loadNews() -> [NewsItem] {
        let favoriteChannels = newsService.favoriteChannels
        var news = [NewsItem]()
        
        favoriteChannels.forEach { channel in
            news.append(contentsOf: channel.news)
        }
        
        return news
    }
}
