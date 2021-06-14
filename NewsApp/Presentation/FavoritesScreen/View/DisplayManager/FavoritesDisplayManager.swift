//
//  FavoritesDisplayManager.swift
//  NewsApp
//
//  Created by Дмитрий Орлянский on 13.06.2021.
//

import UIKit

class FavoritesDisplayManager: NSObject, FavoritesCellDisplayManager {
    var tableView: UITableView!
    var favoriteChannels: [Channel] = []
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
        tableView.register(ChannelsTableViewCell.nib(), forCellReuseIdentifier: ChannelsTableViewCell.identifier())
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
    }
    
    func removeFromFavorites(_ cell: UITableViewCell) {
        guard let indexPath = tableView.indexPath(for: cell) else {
            return
        }
        tableView.beginUpdates()
        favoriteChannels.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .middle)
        tableView.endUpdates()
    }
    
}

extension FavoritesDisplayManager: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoriteChannels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ChannelsTableViewCell.identifier()) as! ChannelsTableViewCell
        cell.favoritesCellDisplayManager = self
        let channel = favoriteChannels[indexPath.row]
        cell.fill(with: channel)
        return cell
    }
}

