//
//  NewsItem.swift
//  NewsApp
//
//  Created by Дмитрий Орлянский on 12.06.2021.
//

import Foundation
import ObjectMapper

struct NewsItem: ImmutableMappable {
    var source: String
    var title: String
    var description: String
    var imageUrlString: String
    
    init(map: Map) throws {
        source = try map.value("source.name")
        title = try map.value("title")
        description = try map.value("description")
        imageUrlString = try map.value("urlToImage")
    }
}
