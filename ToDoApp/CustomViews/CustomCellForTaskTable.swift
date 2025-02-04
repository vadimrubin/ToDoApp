//
//  CustomCellForTaskTable.swift
//  ToDoApp
//
//  Created by Rubin Vadim on 29.01.2025.
//

import UIKit

class CustomCellForTaskTable: UITableViewCell {
    
    static let reuseID = "CustomCellForTaskTable"
    @objc let changeStatusButton = UIButton()
    let sfSymbolImageView = UIImageView()
    let taskLabel = UILabel()
    let taskDescription = UILabel()
    let dateLabel = UILabel()
    var choosedTask: ToDo?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(task: ToDo) {
        choosedTask = task
        taskLabel.text = task.title
        taskDescription.text = task.taskDescription
        dateLabel.text = task.date?.convertToMonthYearFormat()
        configureStatus(done: task.completed)
    }
    
    func configureStatus(done: Bool) {
        switch done {
        case true:
            sfSymbolImageView.image = UIImage(systemName: "checkmark.circle")
            taskLabel.textColor = .systemGray
            taskDescription.textColor = .systemGray
            dateLabel.textColor = .systemGray
        case false:
            sfSymbolImageView.image = UIImage(systemName: "circle")?.withTintColor(.systemYellow)
            taskLabel.textColor = .label
            taskDescription.textColor = .label
            dateLabel.textColor = .label
        }
    }
    
    func configure() {
        contentView.addSubview(changeStatusButton)
        contentView.addSubview(sfSymbolImageView)
        contentView.addSubview(taskLabel)
        contentView.addSubview(taskDescription)
        contentView.addSubview(dateLabel)
        
        changeStatusButton.addSubview(sfSymbolImageView)
        changeStatusButton.addTarget(self, action: #selector(changeStatusButtonTapped), for: .touchUpInside)
        
        sfSymbolImageView.tintColor = UIColor.systemYellow
        
        taskLabel.font = .systemFont(ofSize: 16, weight: .bold)
        taskDescription.font = .systemFont(ofSize: 12, weight: .regular)
        dateLabel.font = .systemFont(ofSize: 12, weight: .regular)

        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        taskDescription.translatesAutoresizingMaskIntoConstraints = false
        changeStatusButton.translatesAutoresizingMaskIntoConstraints = false
        sfSymbolImageView.translatesAutoresizingMaskIntoConstraints = false
        taskLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            changeStatusButton.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            changeStatusButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            changeStatusButton.widthAnchor.constraint(equalToConstant: 20),
            changeStatusButton.heightAnchor.constraint(equalToConstant: 20),
            
            sfSymbolImageView.topAnchor.constraint(equalTo: changeStatusButton.topAnchor),
            sfSymbolImageView.leadingAnchor.constraint(equalTo: changeStatusButton.leadingAnchor),
            sfSymbolImageView.trailingAnchor.constraint(equalTo: changeStatusButton.trailingAnchor),
            sfSymbolImageView.bottomAnchor.constraint(equalTo: changeStatusButton.bottomAnchor),
            
            taskLabel.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            taskLabel.leadingAnchor.constraint(equalTo: changeStatusButton.trailingAnchor, constant: 5),
            taskLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            taskLabel.heightAnchor.constraint(equalToConstant: 20),
            
            taskDescription.topAnchor.constraint(equalTo: taskLabel.bottomAnchor, constant: 5),
            taskDescription.leadingAnchor.constraint(equalTo: taskLabel.leadingAnchor),
            taskDescription.trailingAnchor.constraint(equalTo: taskLabel.trailingAnchor),
            taskDescription.heightAnchor.constraint(equalToConstant: 30),
            
            dateLabel.topAnchor.constraint(equalTo: taskDescription.bottomAnchor, constant: 5),
            dateLabel.leadingAnchor.constraint(equalTo: taskLabel.leadingAnchor),
            dateLabel.trailingAnchor.constraint(equalTo: taskLabel.trailingAnchor),
            dateLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    @objc func changeStatusButtonTapped() {
        choosedTask?.completed.toggle()
        set(task: choosedTask!)
        CoreDataManager.shared.saveAmendedTodo()
        print("кнопка нажата")
    }


}
