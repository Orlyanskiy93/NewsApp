//
//  NewsService.swift
//  NewsApp
//
//  Created by Дмитрий Орлянский on 12.06.2021.
//

import Foundation
import PromiseKit

protocol NewsService {
    func getChannels() -> Promise<[Channel]>
    func addToFavorites(_ chanel: Channel)
    func removeFromFavorites(_ chanel: Channel)
}
