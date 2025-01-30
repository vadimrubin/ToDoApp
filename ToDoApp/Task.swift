//
//  Task.swift
//  ToDoApp
//
//  Created by Rubin Vadim on 30.01.2025.
//

import Foundation

struct Task: Codable {
    let id: Int
    let todo: String
    let completed: Bool
    let userId: Int
}

struct TodosResponse: Codable {
    let todos: [Task]
}
