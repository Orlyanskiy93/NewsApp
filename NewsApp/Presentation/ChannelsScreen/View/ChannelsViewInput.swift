//
//  ChannelsViewInput.swift
//  NewsApp
//
//  Created by Дмитрий Орлянский on 12.06.2021.
//

import Foundation

protocol ChannelsViewInput: AnyObject {
    func setupInitialState()
    func startLoading()
    func stopLoading()
    func update(_ channels: [Channel])
}
