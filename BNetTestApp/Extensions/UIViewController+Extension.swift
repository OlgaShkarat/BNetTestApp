//
//  UIViewController+Extension.swift
//  BNetTestApp
//
//  Created by Ольга on 13.08.2020.
//  Copyright © 2020 Ольга. All rights reserved.
//

import UIKit
extension UIViewController {
    
    func showAlert(title: String, message: String, titleButton: String, action: ((UIAlertAction) -> ())? = nil) {

        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let buttonAction = UIAlertAction(title: titleButton, style: .default, handler: action)
        alertController.addAction(buttonAction)
        present(alertController, animated: true)
    }
}
