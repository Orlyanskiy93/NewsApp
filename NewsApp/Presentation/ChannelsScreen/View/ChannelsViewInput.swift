//
//  ChannelsViewInput.swift
//  NewsApp
//
//  Created by Дмитрий Орлянский on 12.06.2021.
//

import Foundation

protocol ChannelsViewInput: AnyObject, UIViewInput {
    func setupInitialState()
    func startLoading()
    func stopLoading()
    func updateView()
    func update(_ channels: [Channel])
}
