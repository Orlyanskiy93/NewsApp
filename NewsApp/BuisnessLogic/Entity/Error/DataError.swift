//
//  DataError.swift
//  NewsApp
//
//  Created by Дмитрий Орлянский on 14.06.2021.
//

import Foundation

enum DataError: LocalizedError {
    case fetch
    case save
    
    var errorDescription: String? {
        switch self {
        case .fetch:
            return "Unable to load data"
        case .save:
            return "Unable to save data"
        }
    }
}
