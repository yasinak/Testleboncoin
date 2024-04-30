//
//  UIViewController.swift
//  Testleboncoin
//
//  Created by Yasin Akinci on 30/04/2024.
//

import UIKit

extension UIViewController {
    
    func displayError(message: String?) {
        DispatchQueue.main.async {
            let message = message != nil ? message : "Une erreur est survenue"
            let alert = UIAlertController(title: "Attention", message: message, preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Fermer", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
}
