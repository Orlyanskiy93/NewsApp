//
//  NewsViewInput.swift
//  NewsApp
//
//  Created by Дмитрий Орлянский on 13.06.2021.
//

import Foundation

protocol NewsViewInput: AnyObject {
    func setupInitialState()
    func update(_ news: [NewsItem])
}
