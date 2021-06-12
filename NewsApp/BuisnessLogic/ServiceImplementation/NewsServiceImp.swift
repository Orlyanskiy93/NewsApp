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
    var news = [NewsItem]()
    
    private init() {}
    
    func getNews() -> Promise<[NewsItem]> {
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
                        let news = try Mapper<NewsItem>().mapArray(JSONObject: array)
                        seal.fulfill(news)
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
