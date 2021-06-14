//
//  DataServiceImp.swift
//  NewsApp
//
//  Created by Дмитрий Орлянский on 13.06.2021.
//

import UIKit
import CoreData

class DataServiceImp: DataService {
    static let shared = DataServiceImp()
    
    private weak var appDelegate: AppDelegate!
    private var context: NSManagedObjectContext!
    
    var state: ServiceState!
    private var channelsData: [ChannelData] = []
    var allChannels: [Channel] = []
    var favoriteChannels: [Channel] {
        var favorites = [Channel]()
        allChannels.forEach { channel in
            if channel.isFavorte {
                favorites.append(channel)
            }
        }
        favorites.sort { $0.title < $1.title }
        return favorites
    }
    
    private init() {
        appDelegate = UIApplication.shared.delegate as? AppDelegate
        context = appDelegate.persistentContainer.viewContext
        do {
            try fetchData()
        } catch {
            print(error)
            state = .disable
        }
        state = .enable
    }
    
    private func fetchData() throws {
        guard let channelsData = try? context.fetch(ChannelData.fetchRequest()) as? [ChannelData] else {
            throw DataError.fetch
        }
        allChannels = map(channelsData)
        self.channelsData = channelsData
    }
    
    private func clearData() throws {
        channelsData.forEach { (channelData) in
            context.delete(channelData)
        }
        channelsData.removeAll()
        do {
            try context.save()
        } catch {
            throw error
        }
    }
    
    func save(_ channels: [Channel]) throws {
        let channelsData = channels.map { channel -> ChannelData in
            let channelData = ChannelData(context: context)
            channelData.title = channel.title
            channelData.isFavorite = channel.isFavorte
            let newsData = channel.news.compactMap { newsItem -> NewsItemData in
                let newsItemData =  NewsItemData(context: context)
                newsItemData.newsItemTitle = newsItem.title
                newsItemData.newsItemDescription = newsItem.description
                newsItemData.imageUrlString = newsItem.imageUrlString
                return newsItemData
            }
            channelData.addToNewsData(NSSet(array: newsData))
            return channelData
        }
        
        do {
            try clearData()
            self.channelsData = channelsData
            allChannels = map(channelsData)
            try context.save()
        } catch {
            throw DataError.save
        }
    }
    
    private func map(_ channelsData: [ChannelData]) -> [Channel] {
        let channels = channelsData.map { channelData -> Channel in
            guard let newsData = channelData.newsData?.allObjects as? [NewsItemData],
                  let title = channelData.title else {
                return Channel(isFavorte: true, title: "", news: [])
            }
            let news = newsData.map({ newsItemData -> NewsItem in
                let title = newsItemData.newsItemTitle ?? ""
                let description = newsItemData.newsItemDescription
                let imageUrlString = newsItemData.imageUrlString
                let newsItem = NewsItem(title: title, description: description, imageUrlString: imageUrlString)
                return newsItem
            })
            let isFavorite = channelData.isFavorite
            let channel = Channel(isFavorte: isFavorite, title: title, news: news)
            return channel
        }
        return channels
    }
    
    func addToFavorites(_ chanel: Channel) throws {
        guard let index = allChannels.firstIndex (where: { $0.title == chanel.title }) else {
            return
        }
        allChannels[index].isFavorte = true
        do {
            try save(allChannels)
        } catch {
            throw DataError.save
        }
    }
    
    func removeFromFavorites(_ chanel: Channel) throws {
        guard let index = allChannels.firstIndex (where: { $0.title == chanel.title }) else {
            return
        }
        allChannels[index].isFavorte = false
        do {
            try save(allChannels)
        } catch {
            throw DataError.save
        }
    }
}

extension DataServiceImp {
    enum ServiceState {
        case enable
        case disable
    }
}
