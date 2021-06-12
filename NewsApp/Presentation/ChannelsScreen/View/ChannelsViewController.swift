//
//  ChannelsViewController.swift
//  NewsApp
//
//  Created by Дмитрий Орлянский on 12.06.2021.
//

import UIKit

class ChannelsViewController: UIViewController, ChannelsViewInput {
    private var output: ChannelsViewOutput!

    override func viewDidLoad() {
        super.viewDidLoad()
        output = ChannelsPresenter(self)
    }
    
    func setupInitialState() {
        
    }
}
