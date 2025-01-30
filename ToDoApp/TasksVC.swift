//
//  ViewController.swift
//  ToDoApp
//
//  Created by Rubin Vadim on 29.01.2025.
//

import UIKit

class TasksVC: UIViewController {
    
    let searchTextField = UITextField()
    let bottomBlockView = UIView()
    let countTasksLabel = UILabel()
    let addTaskButton = UIButton()
    let tasksTableView = UITableView()
    var tasks: [Task] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        configureVC()
        configureSearchBox()
        configureBottomBlock()
        configureTasksTableView()
        configureFirstStart()
    }

    func configureVC() {
        view.backgroundColor = .systemBackground
        title = "Задачи"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func configureFirstStart() {
        NetworkManager.shared.getTasks { result in
            switch result {
            case .success(let todos):
                self.tasks = todos
                DispatchQueue.main.async {
                    self.countTasksLabel.text = "\(self.tasks.count) Задач"
                    self.tasksTableView.reloadData()
                }
            case .failure(_):
                print("bad things happen")
            }
        }
        
    }
    
    func configureSearchBox() {
        view.addSubview(searchTextField)
        searchTextField.delegate = self
        searchTextField.translatesAutoresizingMaskIntoConstraints = false
        searchTextField.keyboardType = .default
        searchTextField.textAlignment = .left
        searchTextField.resignFirstResponder()
        searchTextField.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        searchTextField.textColor = .white
        searchTextField.autocorrectionType = .no
        searchTextField.borderStyle = .roundedRect
        searchTextField.layer.cornerRadius = 10
        searchTextField.backgroundColor = .systemGray2
        searchTextField.tintColor = .white
        
        let loopImage = NSTextAttachment()
        loopImage.image = UIImage(systemName: "magnifyingglass")?.withTintColor(.white)
        let attribut: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor.white]
        let search = NSAttributedString(string: " Search", attributes: attribut)
        let placeholderText = NSMutableAttributedString(attachment: loopImage)
        placeholderText.append(search)
        searchTextField.attributedPlaceholder = placeholderText
        
        NSLayoutConstraint.activate([
            searchTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            searchTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            searchTextField.heightAnchor.constraint(equalToConstant: 35)
        ])
    }
    
    func configureBottomBlock() {
        view.addSubview(bottomBlockView)
        bottomBlockView.translatesAutoresizingMaskIntoConstraints = false
        bottomBlockView.backgroundColor = .systemGray2
        
        NSLayoutConstraint.activate([
            bottomBlockView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            bottomBlockView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bottomBlockView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bottomBlockView.heightAnchor.constraint(equalToConstant: 70)
        ])
        configureCountTasksLabel()
        configureAddTaskButton()
    }
    
    func configureCountTasksLabel() {
        bottomBlockView.addSubview(countTasksLabel)
        countTasksLabel.translatesAutoresizingMaskIntoConstraints = false
        countTasksLabel.textColor = .white
        countTasksLabel.textAlignment = .center
        countTasksLabel.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        
        NSLayoutConstraint.activate([
            countTasksLabel.topAnchor.constraint(equalTo: bottomBlockView.topAnchor, constant: 10),
            countTasksLabel.leadingAnchor.constraint(equalTo: bottomBlockView.leadingAnchor, constant: 70),
            countTasksLabel.trailingAnchor.constraint(equalTo: bottomBlockView.trailingAnchor, constant: -70),
            countTasksLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    func configureAddTaskButton() {
        bottomBlockView.addSubview(addTaskButton)
        addTaskButton.translatesAutoresizingMaskIntoConstraints = false
        let symbolName = "square.and.pencil"
        if let symbolImage = UIImage(systemName: symbolName) {
            var configuration = UIButton.Configuration.plain()
            configuration.image = symbolImage
            configuration.baseForegroundColor = .systemYellow
            addTaskButton.configuration = configuration
        }
        addTaskButton.addTarget(self, action: #selector(navigateToAddTaskVC), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            addTaskButton.topAnchor.constraint(equalTo: bottomBlockView.topAnchor, constant: 10),
            addTaskButton.leadingAnchor.constraint(equalTo: countTasksLabel.trailingAnchor),
            addTaskButton.trailingAnchor.constraint(equalTo: bottomBlockView.trailingAnchor),
            addTaskButton.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    @objc func navigateToAddTaskVC() {
//        let destVC = AddTaskVC()
//        navigationController?.pushViewController(destVC, animated: true)
    }
    
    func configureTasksTableView() {
        view.addSubview(tasksTableView)
        tasksTableView.translatesAutoresizingMaskIntoConstraints = false
        tasksTableView.backgroundColor = .systemBackground
        tasksTableView.rowHeight = 90
        tasksTableView.register(CustomCellForTaskTable.self, forCellReuseIdentifier: CustomCellForTaskTable.reuseID)
        tasksTableView.delegate = self
        tasksTableView.dataSource = self
        
        NSLayoutConstraint.activate([
            tasksTableView.topAnchor.constraint(equalTo: searchTextField.bottomAnchor, constant: 10),
            tasksTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tasksTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tasksTableView.bottomAnchor.constraint(equalTo: bottomBlockView.topAnchor)
        ])
    }

}

extension TasksVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CustomCellForTaskTable.reuseID) as! CustomCellForTaskTable
        cell.set(task: tasks[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let destVC = DetailedTask()
        destVC.title = tasks[indexPath.row].todo
        destVC.dateLabel.text = "Нет даты"
        destVC.descriptionTextField.text = "Нет описания"
        navigationController?.pushViewController(destVC, animated: true)
    }
    
}

extension TasksVC: UITextFieldDelegate {
    
}

