//
//  FavoritesViewInput.swift
//  NewsApp
//
//  Created by Дмитрий Орлянский on 12.06.2021.
//

import Foundation

protocol FavoritesViewInput {
    func setupInitialState()
    func update(_ channels: [Channel])
}
