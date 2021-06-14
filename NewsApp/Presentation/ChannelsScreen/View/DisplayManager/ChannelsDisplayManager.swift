//
//  ChannelsDisplayManager.swift
//  NewsApp
//
//  Created by Дмитрий Орлянский on 12.06.2021.
//

import UIKit

class ChannelsDisplayManager: NSObject, UITableViewDelegate {
    var tableView: UITableView!
    var channels: [Channel] = []
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
}

extension ChannelsDisplayManager: UITextViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return channels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ChannelsTableViewCell.identifier()) as! ChannelsTableViewCell
        let channel = channels[indexPath.row]
        cell.fill(with: channel)
        return cell
    }
}
