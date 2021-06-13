//
//  NewsDisplayManager.swift
//  NewsApp
//
//  Created by Дмитрий Орлянский on 13.06.2021.
//

import UIKit

class NewsDisplayManager: NSObject, UITableViewDelegate {
    var tableView: UITableView!
    var news: [NewsItem] = []
    {
        didSet {
            tableView.reloadData()
        }
    }
    
    init(_ tableView: UITableView) {
        self.tableView = tableView
        super.init()
        setupTableView()
    }
    
    func setupTableView() {
        tableView.register(NewsTableViewCell.nib(), forCellReuseIdentifier: NewsTableViewCell.identifier())
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 300
        tableView.separatorStyle = .none
    }
}

extension NewsDisplayManager: UITextViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return news.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NewsTableViewCell.identifier()) as! NewsTableViewCell
        let newsItem = news[indexPath.row]
        cell.fill(with: newsItem)
        return cell
    }
}

