//
//  UIViewController + Extenstion.swift
//  SurfInternship
//
//  Created by Fed on 07.02.2023.
//

import UIKit

extension UIViewController {
    
    func showAlert(alertText : String, alertMessage : String, completion: (() -> Void)? = nil) {
        let alert = UIAlertController(title: alertText, message: alertMessage, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Закрыть", style: .destructive, handler: { _ in
            guard let completion else {
                return
            }
            completion()
            
        }))
        self.present(alert, animated: true, completion: nil)
    }
}
