//
//  UITableView+deleteCell.swift
//  NewsApp
//
//  Created by Дмитрий Орлянский on 13.06.2021.
//

import UIKit

extension UITableView {
    func delete(_ cell: UITableViewCell) {
        guard let indexPath = self.indexPath(for: cell) else {
            return
        }
        self.deleteRows(at: [indexPath], with: .left)
    }
}
