//
//  ViewController+Ext.swift
//  ToDoApp
//
//  Created by Rubin Vadim on 04.02.2025.
//

import UIKit

extension UIViewController {
    
    func presentToDoAlertOnMainThread(message: String, buttonTitle: String) {
        //добавляем в main thread чтобы не вызывать это каждый раз отдельно
        DispatchQueue.main.async {
            let alertVC = ToDoAlertVC(message: message, buttonTitle: buttonTitle)
            alertVC.modalPresentationStyle = .overFullScreen
            alertVC.modalTransitionStyle = .crossDissolve
            self.present(alertVC, animated: true)
        }
    }
    
}
