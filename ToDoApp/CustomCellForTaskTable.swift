//
//  CustomCellForTaskTable.swift
//  ToDoApp
//
//  Created by Rubin Vadim on 29.01.2025.
//

import UIKit

class CustomCellForTaskTable: UITableViewCell {
    
    static let reuseID = "CustomCellForTaskTable"
    let sfSymbolImageView = UIImageView()
    let taskLabel = UILabel()
    let taskDescription = TDDesciptionLabel()
    let dateLabel = TDDateLabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(task: Task) {
        taskLabel.text = task.todo
        configureSFSymbol(done: task.completed)
    }
    
    func configureSFSymbol(done: Bool) {
        switch done {
        case true:
            sfSymbolImageView.image = UIImage(systemName: "checkmark.circle")
        case false:
            sfSymbolImageView.image = UIImage(systemName: "circle")?.withTintColor(.systemYellow)
        }
    }
    
    func configure() {
        contentView.addSubview(sfSymbolImageView)
        contentView.addSubview(taskLabel)
        contentView.addSubview(taskDescription)
        contentView.addSubview(dateLabel)
        
        sfSymbolImageView.tintColor = UIColor.systemYellow
        
        taskLabel.font = .systemFont(ofSize: 16, weight: .bold)
        taskLabel.textColor = .label
        
        taskDescription.text = "Нет описания"
        dateLabel.text = "Нет даты"
        
        sfSymbolImageView.translatesAutoresizingMaskIntoConstraints = false
        taskLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            sfSymbolImageView.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            sfSymbolImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            sfSymbolImageView.widthAnchor.constraint(equalToConstant: 20),
            sfSymbolImageView.heightAnchor.constraint(equalToConstant: 20),
            
            taskLabel.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            taskLabel.leadingAnchor.constraint(equalTo: sfSymbolImageView.trailingAnchor, constant: 5),
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


}
