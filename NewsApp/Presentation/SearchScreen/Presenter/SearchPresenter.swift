//
//  SearchPresenter.swift
//  NewsApp
//
//  Created by Дмитрий Орлянский on 13.06.2021.
//

import Foundation

class SearchPresenter: SearchViewOutput {
    private weak var view: SearchViewInput!
    private var newsService: NewsService!
    private var news: [NewsItem] = []
    private var filteredNews: [NewsItem] = []
    
    init(_ view: SearchViewInput) {
        self.view = view
        newsService = NewsServiceImp.shared
    }
    
    func viewIsReady() {
        view.setupInitialState()
        news = loadNews()
    }
    
    func loadNews() -> [NewsItem] {
        let allChannels = newsService.allChannels
        var news = [NewsItem]()
        
        allChannels.forEach { channel in
            news.append(contentsOf: channel.news)
        }
        
        return news
    }
    
    func filterNews(by searchText: String) {
        filteredNews = news.filter({ newsItem in
            let titleText = newsItem.title.lowercased()
            let descriptionText = newsItem.description?.lowercased() ?? ""
            let isContainsTextInTitle = titleText.contains(searchText.lowercased())
            let isContainsTextInDescription = descriptionText.contains(searchText.lowercased())
            return isContainsTextInTitle || isContainsTextInDescription
        })
        view.update(filteredNews)
    }
}
