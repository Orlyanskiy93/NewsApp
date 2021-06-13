//
//  NewsViewController.swift
//  NewsApp
//
//  Created by Дмитрий Орлянский on 13.06.2021.
//

import UIKit

class NewsViewController: UIViewController, NewsViewInput {
    @IBOutlet weak var tableView: UITableView!
    private var output: NewsViewOutput!
    private var displayManager: NewsDisplayManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        output = NewsPresenter(self)
        displayManager = NewsDisplayManager(tableView)
        output.viewIsReady()
    }
    
    func setupInitialState() {
        
    }
    
    func update(_ news: [NewsItem]) {
        displayManager.news = news
    }
}
