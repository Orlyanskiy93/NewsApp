//
//  SearchPresenter.swift
//  NewsApp
//
//  Created by Дмитрий Орлянский on 13.06.2021.
//

import Foundation

class SearchPresenter: SearchViewOutput {
    private weak var view: SearchViewInput!
    private var dataService: DataService!
    private var news: [NewsItem] = []
    private var filteredNews: [NewsItem] = []
    
    init(_ view: SearchViewInput) {
        self.view = view
        dataService = DataServiceImp.shared
    }
    
    func viewIsReady() {
        view.setupInitialState()
        news = loadNews()
    }
    
    func loadNews() -> [NewsItem] {
        var news = [NewsItem]()
        let allChannels = dataService.allChannels
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
