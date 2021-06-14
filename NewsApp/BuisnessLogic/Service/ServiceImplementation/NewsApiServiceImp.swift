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

class NewsApiServiceImp: NewsApiService {
    static let shared = NewsApiServiceImp()
    
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
                        // Mapping response data
                        var newsData = try Mapper<NewsApiResponseItem>().mapArray(JSONObject: array)
                        
                        // Creating channels
                        newsData.sort { $0.source < $1.source }
                        var channels = [Channel]()
                        newsData.forEach { newsDataItem in
                            let newsItem = NewsItem(title: newsDataItem.title, description: newsDataItem.description, imageUrlString: newsDataItem.imageUrlString)
                            
                            if let index = channels.firstIndex(where: { channel in
                                return channel.title == newsDataItem.source
                            }) {
                                channels[index].news.append(newsItem)
                            } else {
                                let channel = Channel(isFavorte: false, title: newsDataItem.source, news: [newsItem])
                                channels.append(channel)
                            }
                        }
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
}
