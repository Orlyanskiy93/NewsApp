//
//  UITableViewCell+nib+identifier.swift
//  NewsApp
//
//  Created by Дмитрий Орлянский on 13.06.2021.
//

import UIKit

extension UITableViewCell {
    static func nib() -> UINib {
        let nib = UINib(nibName: String(describing: self), bundle: nil)
        return nib
    }
    
    static func identifier() -> String {
        let identifier = String(describing: self)
        return identifier
    }
}
