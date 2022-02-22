//
//  UIViewController+Util.swift
//  TableView
//
//  Created by Bee_MacPro on 22/02/2022.
//

import UIKit

extension UIViewController {
    
    func showError(_ title: String, message: String) {
        let alertViewController = UIAlertController(title: title,
                                                    message: message,
                                                    preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok",
                                     style: .default,
                                     handler: nil)
        alertViewController.addAction(okAction)
        present(alertViewController, animated: true, completion: nil)
    }
}
