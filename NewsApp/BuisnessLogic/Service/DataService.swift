//
//  DataService.swift
//  NewsApp
//
//  Created by Дмитрий Орлянский on 13.06.2021.
//

import Foundation

protocol DataService {
    var state: DataServiceImp.ServiceState! { get }
    var allChannels: [Channel] { get }
    var favoriteChannels: [Channel] { get }
    
    func addToFavorites(_ chanel: Channel) throws
    func removeFromFavorites(_ chanel: Channel) throws
    func save(_ channels: [Channel]) throws
}
