//
//  SearchViewController.swift
//  NewsApp
//
//  Created by Дмитрий Орлянский on 13.06.2021.
//

import UIKit

class SearchViewController: UIViewController, SearchViewInput {
    @IBOutlet weak var tableView: UITableView!
    private var output: SearchViewOutput!
    private var displayManager: NewsDisplayManager!
    private let searchController: UISearchController =  UISearchController(searchResultsController: nil)

    override func viewDidLoad() {
        super.viewDidLoad()
        output = SearchPresenter(self)
        displayManager = NewsDisplayManager(tableView)
        output.viewIsReady()
    }
    
    func setupInitialState() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Find news"
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    func update(_ news: [NewsItem]) {
        displayManager.news = news
    }

}

extension SearchViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text else {
            return
        }
        output.filterNews(by: searchText)
    }
}

