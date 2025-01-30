//
//  AddTaskVC.swift
//  ToDoApp
//
//  Created by Rubin Vadim on 29.01.2025.
//

import UIKit

class DetailedTask: UIViewController {
    
    var dateLabel = TDDateLabel()
    var descriptionTextField = UITextField()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureDateLabel()
        configureDescriptionLabel()
        configureBackBatItem()
    }
    
    func configureDateLabel() {
        view.addSubview(dateLabel)
        
        NSLayoutConstraint.activate([
            dateLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            dateLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            dateLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            dateLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    func configureDescriptionLabel() {
        view.addSubview(descriptionTextField)
        descriptionTextField.translatesAutoresizingMaskIntoConstraints = false
        descriptionTextField.font = .systemFont(ofSize: 14, weight: .regular)
        descriptionTextField.textColor = .label
        descriptionTextField.contentVerticalAlignment = .top
        descriptionTextField.textAlignment = .natural
        
        NSLayoutConstraint.activate([
            descriptionTextField.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 15),
            descriptionTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            descriptionTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            descriptionTextField.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func configureBackBatItem() {
        let backButton = UIBarButtonItem()
        backButton.title = "Назад"
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
    }

}
