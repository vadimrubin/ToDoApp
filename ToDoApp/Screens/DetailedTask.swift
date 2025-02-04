//
//  AddTaskVC.swift
//  ToDoApp
//
//  Created by Rubin Vadim on 29.01.2025.
//

import UIKit

class DetailedTask: UIViewController {
    
    var dateLabel = UILabel()
    var descriptionTextField = UITextView()
    var amendedTask: ToDo?
    let dateFormatter = DateFormatter()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = amendedTask?.title
        view.backgroundColor = .systemBackground
        configureDateLabel()
        configureDescriptionTextField()
        configureBackBatItem()
    }
    
    func configureDateLabel() {
        view.addSubview(dateLabel)
        
        dateLabel.font = .systemFont(ofSize: 12, weight: .regular)
        dateLabel.textColor = .label
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.text = amendedTask?.date?.convertToMonthYearFormat()
        
        NSLayoutConstraint.activate([
            dateLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            dateLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            dateLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            dateLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    func configureDescriptionTextField() {
        view.addSubview(descriptionTextField)
        descriptionTextField.translatesAutoresizingMaskIntoConstraints = false
        descriptionTextField.font = .systemFont(ofSize: 14, weight: .regular)
        descriptionTextField.textColor = .label
        descriptionTextField.textAlignment = .natural
        descriptionTextField.isEditable = true
        descriptionTextField.text = amendedTask?.taskDescription
        
        NSLayoutConstraint.activate([
            descriptionTextField.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 15),
            descriptionTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            descriptionTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            descriptionTextField.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func configureBackBatItem() {
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "< Назад", style: .plain, target: self, action: #selector(backAction))
    }
    
    @objc func backAction(sender: UIBarButtonItem) {
        
        amendedTask?.taskDescription = descriptionTextField.text
        CoreDataManager.shared.saveAmendedTodo()
        
        self.navigationController?.popViewController(animated: true)
    }
    
}

