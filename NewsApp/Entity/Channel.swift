//
//  Channel.swift
//  NewsApp
//
//  Created by Дмитрий Орлянский on 12.06.2021.
//

import UIKit
import ObjectMapper

struct Channel {
    var isFavorte: Bool = false
    var title: String
    var news: [NewsItem]
}
