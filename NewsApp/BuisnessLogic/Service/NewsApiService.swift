//
//  NewsService.swift
//  NewsApp
//
//  Created by Дмитрий Орлянский on 12.06.2021.
//

import Foundation
import PromiseKit

protocol NewsApiService {
    func getAllChannels() -> Promise<[Channel]>
}
