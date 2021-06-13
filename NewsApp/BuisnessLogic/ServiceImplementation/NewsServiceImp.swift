//
//  NewsServiceImp.swift
//  NewsApp
//
//  Created by Дмитрий Орлянский on 12.06.2021.
//

import Foundation
import Alamofire
import ObjectMapper
import PromiseKit

class NewsServiceImp: NewsService {
    static let shared = NewsServiceImp()
    var allChannels: [Channel] = []
    var favoriteChannels: [Channel] = []
    
    private init() {}
    
    func getAllChannels() -> Promise<[Channel]> {
        let url = URL(string: "https://newsapi.org/v2/top-headlines")!
        let parametrs: Parameters = ["country": "gb", "apiKey": "33acadaeee364278bd34dfdf5009711b"]
        
        return Promise { seal in
            AF.request(url, parameters: parametrs).validate().responseJSON { response in
                switch response.result {
                case .success(let data):
                    guard let dict = data as? [String: Any],
                          let array = dict["articles"] as? [Any]  else {
                        return
                    }
                    do {
                        var newsData = try Mapper<NewsDataItem>().mapArray(JSONObject: array)
                        var channels = [Channel]()
                        var news = [NewsItem]()

                        newsData.sort { $0.source < $1.source }
                        var channelTitle = newsData.first!.source
                        newsData.forEach { item in
                            if item.source == channelTitle {
                                news.append(NewsItem(title: item.title, description: item.description, imageUrlString: item.imageUrlString))
                            } else {
                                let channel = Channel(title: channelTitle, news: news)
                                channels.append(channel)
                                news = []
                                channelTitle = item.source
                            }
                        }
                        self.allChannels = channels
                        seal.fulfill(channels)
                    } catch {
                        seal.reject(error)
                    }
                case .failure(let error):
                    seal.reject(error)
                }
            }
        }
    }
    func addToFavorites(_ chanel: Channel) {
        guard favoriteChannels.contains(where: { $0.title == chanel.title }) else {
            favoriteChannels.append(chanel)
            return
        }
    }
    
    func removeFromFavorites(_ chanel: Channel) {
        guard let index = favoriteChannels.firstIndex(where: { $0.title == chanel.title }) else {
            return
        }
        favoriteChannels.remove(at: index)
    }
}
