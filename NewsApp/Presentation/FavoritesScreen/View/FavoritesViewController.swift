//
//  FavoritesViewController.swift
//  NewsApp
//
//  Created by Дмитрий Орлянский on 12.06.2021.
//

import UIKit

class FavoritesViewController: UIViewController, FavoritesViewInput {
    @IBOutlet weak var tableView: UITableView!
    private var output: FavoritesViewOutput!
    private var displayManager: FavoritesDisplayManager!

    override func viewDidLoad() {
        super.viewDidLoad()
        output = FavoritesPresenter(self)
        output.viewIsReady()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        output.updateView()
    }
    
    func setupInitialState() {
        displayManager = FavoritesDisplayManager(tableView)
    }
    
    func update(_ channels: [Channel]) {
        displayManager.favoriteChannels = channels
    }
}
