//
//  UIViewInput.swift
//  NewsApp
//
//  Created by Дмитрий Орлянский on 14.06.2021.
//

import Foundation
import UIKit

protocol UIViewInput {
    func show(_ error: Error, _ handler: ((UIAlertAction) -> Void)?)
    func show(title: String?, message: String, _ handler: ((UIAlertAction) -> Void)?)
}

extension UIViewInput {
    
    func show(_ error: Error, _ handler: ((UIAlertAction) -> Void)? = nil) {
        show(title: "Error" , message: error.localizedDescription, handler)
    }
    
    func show(title: String? = nil, message: String, _ handler: ((UIAlertAction) -> Void)? = nil) {
        guard let vc = self as? UIViewController else { return }
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default, handler: handler)
        alert.addAction(action)
        vc.present(alert, animated: true, completion: nil)
    }
}
