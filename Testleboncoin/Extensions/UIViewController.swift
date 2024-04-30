//
//  UIViewController.swift
//  Testleboncoin
//
//  Created by Yasin Akinci on 30/04/2024.
//

import UIKit

extension UIViewController {
    
    func displayAlertError(message: String?) {
        DispatchQueue.main.async {
            let message = message != nil ? message : "Une erreur est survenue"
            let alert = UIAlertController(title: "Attention", message: message, preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Fermer", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func showActionSheet(title: String,
                         message: String?,
                         actions: [(String, UIAlertAction.Style)],
                         completion: @escaping (_ index: Int) -> Void) {
        let alertViewController = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        for (index, (title, style)) in actions.enumerated() {
            let alertAction = UIAlertAction(title: title, style: style) { (_) in
                completion(index)
            }
            alertViewController.addAction(alertAction)
        }
        
        self.present(alertViewController, animated: true, completion: nil)
    }
    
}
