//
//  FavoritesPresenter.swift
//  NewsApp
//
//  Created by Дмитрий Орлянский on 12.06.2021.
//

import Foundation

class FavoritesPresenter: FavoritesViewOutput {
    private var view: FavoritesViewInput!
    private var newsService: NewsService!
    
    init(_ view: FavoritesViewInput) {
        self.view = view
        newsService = NewsServiceImp.shared
    }
    
    func viewIsReady() {
        view.setupInitialState()
    }
    
    func updateView() {
        view.update(newsService.favoriteChannels)
    }
}
