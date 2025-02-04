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
    var todos: [ToDo] = []
    var filteredTodos: [ToDo] = []
    let hasLaunchedKey = "HasLaunched"
    let defaults = UserDefaults.standard
    var isSearching = false
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getCoreData()
        if isSearching {
            updateUI(todos: filteredTodos)
        } else {
            updateUI(todos: todos)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
       
        configureVC()
        configureBottomBlock()
        configureTasksTableView()
        configureSearchController()
        configureFirstStart()
    }

    func configureVC() {
        view.backgroundColor = .systemBackground
        title = "Задачи"
        navigationController?.navigationBar.prefersLargeTitles = true
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
        let destVC = AddTaskVC()
        navigationController?.pushViewController(destVC, animated: true)
    }
    
    func configureTasksTableView() {
        view.addSubview(tasksTableView)
        tasksTableView.translatesAutoresizingMaskIntoConstraints = false
        tasksTableView.backgroundColor = .systemBackground
        tasksTableView.rowHeight = 90
        tasksTableView.register(CustomCellForTaskTable.self, forCellReuseIdentifier: CustomCellForTaskTable.reuseID)
        tasksTableView.delegate = self
        tasksTableView.dataSource = self
        tasksTableView.separatorColor = .label
        tasksTableView.separatorInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
        
        NSLayoutConstraint.activate([
            tasksTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tasksTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tasksTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tasksTableView.bottomAnchor.constraint(equalTo: bottomBlockView.topAnchor)
        ])
    }
    
    func configureSearchController() {
        let searchController = UISearchController()
        searchController.searchBar.delegate = self
        searchController.searchBar.placeholder = "Search"
        searchController.obscuresBackgroundDuringPresentation = false
        navigationItem.searchController = searchController
    }
    
    func configureFirstStart() {
        
        let hasLaunched = defaults.bool(forKey: hasLaunchedKey)
        if hasLaunched == false {
            NetworkManager.shared.getTasks { result in
                switch result {
                case .success(let todos):
                        for item in todos {
                            CoreDataManager.shared.saveTodo(name: item.todo, description: "", date: .now, status: item.completed) { error in
                                print("\(String(describing: error?.rawValue))")
                            }
                            print("core data saved")
                        }
                    self.getCoreData()
                case .failure(_):
                    print("bad things happen")
                }
            }
            defaults.set(true, forKey: hasLaunchedKey)
        } else {
            getCoreData()
        }
    }
    
    func getCoreData() {
        CoreDataManager.shared.retrieveTodos { result in
            switch result {
            case .success(let todos):
                self.todos = todos
                self.updateUI(todos: todos)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func updateUI(todos: [ToDo]) {
        DispatchQueue.main.async {
            self.countTasksLabel.text = "\(todos.count) Задач"
            self.tasksTableView.reloadData()
        }
    }

}

extension TasksVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isSearching {
            return filteredTodos.count
        } else {
            return todos.count
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CustomCellForTaskTable.reuseID) as! CustomCellForTaskTable
        if isSearching {
            cell.set(task: filteredTodos[indexPath.row])
        } else {
            cell.set(task: todos[indexPath.row])
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let destVC = DetailedTask()
        if isSearching {
            destVC.amendedTask = filteredTodos[indexPath.row]
        } else {
            destVC.amendedTask = todos[indexPath.row]
        }
        navigationController?.pushViewController(destVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, contextMenuConfigurationForRowAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        return UIContextMenuConfiguration(identifier: nil, previewProvider: nil) { suggestedAction in
            let edit = UIAction(title: "Редактировать", image: UIImage(systemName: "pencil")) { action in
                let destVC = DetailedTask()
                if self.isSearching {
                    destVC.amendedTask = self.filteredTodos[indexPath.row]
                } else {
                    destVC.amendedTask = self.todos[indexPath.row]
                }
                self.navigationController?.pushViewController(destVC, animated: true)
            }
            let share = UIAction(title: "Поделиться", image: UIImage(systemName: "square.and.arrow.up")) { action in
                print("share")
            }
            let delete = UIAction(title: "Удалить", image: UIImage(systemName: "trash"), attributes: .destructive) { action in
                if self.isSearching {
                    CoreDataManager.shared.deleteTodo(todo: self.filteredTodos[indexPath.row]) { error in
                        print(error?.rawValue ?? "error")
                    }
                    self.filteredTodos.remove(at: indexPath.row)
                    self.updateUI(todos: self.filteredTodos)
                } else {
                    CoreDataManager.shared.deleteTodo(todo: self.todos[indexPath.row]) { error in
                        print(error?.rawValue ?? "error")
                    }
                    self.todos.remove(at: indexPath.row)
                    self.updateUI(todos: self.todos)
                }
                self.tasksTableView.deleteRows(at: [indexPath], with: .automatic)
            }
            return UIMenu(title: "", children: [edit, share, delete])
        }
    }
    
    
}

extension TasksVC: UISearchBarDelegate {
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredTodos = todos.filter({($0.title!.prefix(searchText.count)) == searchText})
        isSearching = true
        updateUI(todos: filteredTodos)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        isSearching = false
        self.getCoreData()
        updateUI(todos: todos)
    }

}

