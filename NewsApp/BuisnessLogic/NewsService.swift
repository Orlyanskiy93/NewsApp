//
//  NewsService.swift
//  NewsApp
//
//  Created by Дмитрий Орлянский on 12.06.2021.
//

import Foundation
import PromiseKit

protocol NewsService {
    var favoriteChannels: [Channel] { get }
    
    func getAllChannels() -> Promise<[Channel]>
    func addToFavorites(_ chanel: Channel)
    func removeFromFavorites(_ chanel: Channel)
}
