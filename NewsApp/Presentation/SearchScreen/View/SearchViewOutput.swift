//
//  SearchViewOutput.swift
//  NewsApp
//
//  Created by Дмитрий Орлянский on 13.06.2021.
//

import Foundation

protocol SearchViewOutput {
    func viewIsReady()
    func filterNews(by searchText: String)
}
