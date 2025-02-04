//
//  AddTaskVC.swift
//  ToDoApp
//
//  Created by Rubin Vadim on 04.02.2025.
//

import UIKit

class AddTaskVC: UIViewController {
    
    let titleTextField = UITextField()
    let desciptionTextView = UITextView()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureTitleTextField()
        configureDesciptionTextView()
        configureRightBarButtonItem()
    }
    
    func configureTitleTextField() {
        view.addSubview(titleTextField)
        titleTextField.translatesAutoresizingMaskIntoConstraints = false
        titleTextField.keyboardType = .default
        titleTextField.textAlignment = .left
        titleTextField.resignFirstResponder()
        titleTextField.font = UIFont.systemFont(ofSize: 36, weight: .semibold)
        titleTextField.textColor = .label
        titleTextField.clearButtonMode = .whileEditing
        titleTextField.autocorrectionType = .no
        titleTextField.placeholder = "Enter name"
        
        NSLayoutConstraint.activate([
            titleTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            titleTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            titleTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            titleTextField.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    func configureDesciptionTextView() {
        view.addSubview(desciptionTextView)
        desciptionTextView.translatesAutoresizingMaskIntoConstraints = false
        desciptionTextView.isEditable = true
        desciptionTextView.text = "Enter description"
        
        NSLayoutConstraint.activate([
            desciptionTextView.topAnchor.constraint(equalTo: titleTextField.bottomAnchor, constant: 20),
            desciptionTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            desciptionTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            desciptionTextView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    func configureRightBarButtonItem() {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "checkmark.circle"), style: .plain, target: self, action: #selector(saveUserWorkout))
    }
    
    @objc func saveUserWorkout() {
        if titleTextField.hasText {
            CoreDataManager.shared.saveTodo(name: titleTextField.text ?? "New task", description: desciptionTextView.text, date: .now, status: false) { error in
                print(error?.rawValue ?? "")
            }
            print("Задача сохранена")
            self.navigationController?.popViewController(animated: true)
        } else {
            self.presentToDoAlertOnMainThread(message: "Добавьте название задачи", buttonTitle: "Окей")
        }
        
    }

}
