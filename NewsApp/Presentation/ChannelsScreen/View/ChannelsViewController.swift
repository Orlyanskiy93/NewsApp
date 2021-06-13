//
//  ChannelsViewController.swift
//  NewsApp
//
//  Created by Дмитрий Орлянский on 12.06.2021.
//

import UIKit

class ChannelsViewController: UIViewController, ChannelsViewInput {
    @IBOutlet weak var tableView: UITableView!
    var sourceTableView: UITableView?
    
    private var output: ChannelsViewOutput!
    private var displayManager: ChannelsDisplayManager!

    override func viewDidLoad() {
        super.viewDidLoad()
        output = ChannelsPresenter(self)
        output.viewIsReady()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        displayManager.reloadData()
    }
    
    func setupInitialState() {
        displayManager = ChannelsDisplayManager(tableView)
    }
    
    func update(_ channels: [Channel]) {
        displayManager.channels = channels
    }
}
