//
//  FavoritesPresenter.swift
//  NewsApp
//
//  Created by Дмитрий Орлянский on 12.06.2021.
//

import Foundation

class FavoritesPresenter: FavoritesViewOutput {
    private weak var view: FavoritesViewInput!
    private var dataService: DataService!
    
    init(_ view: FavoritesViewInput) {
        self.view = view
        dataService = DataServiceImp.shared
    }
    
    func viewIsReady() {
        view.setupInitialState()
    }
    
    func updateView() {
        let favorites = dataService.favoriteChannels
        view.update(favorites)
    }
}
