//
//  ChannelsPresenter.swift
//  NewsApp
//
//  Created by Дмитрий Орлянский on 12.06.2021.
//

import Foundation

class ChannelsPresenter: ChannelsViewOutput {
    private var view: ChannelsViewInput!
    
    init(_ view: ChannelsViewInput) {
        self.view = view
    }
    
    func viewIsReady() {
        view.setupInitialState()
    }
}
