//
//  CoreDataManager.swift
//  ToDoApp
//
//  Created by Rubin Vadim on 30.01.2025.
//

import UIKit
import CoreData

class CoreDataManager {
    
    static let shared = CoreDataManager()
    
    private init() {}
    
    static let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func saveTodo(name: String, description: String, date: Date, status: Bool, completed: @escaping (ErrorMessages?) -> Void) {
        
        let newTodo = ToDo(context: CoreDataManager.context)
        newTodo.title = name
        newTodo.taskDescription = description
        newTodo.date = date
        newTodo.completed = status
        
        //сохраняем CoreData
        do {
            try CoreDataManager.context.save()
            return
        }
        //или передаем ошибку
        catch {
            completed(.cantSaveTask)
        }
    }
    
    func saveAmendedTodo() {
        do {
            try CoreDataManager.context.save()
        }
        //или передаем ошибку
        catch {
            
        }
    }
    
    func retrieveTodos(completed: @escaping (Result<[ToDo], ErrorMessages>) -> Void) {
        do {
            let request = ToDo.fetchRequest() as NSFetchRequest<ToDo>
            //сортируя по имени
            let sort = NSSortDescriptor(key: "date", ascending: false)
            request.sortDescriptors = [sort]
            let todos = try CoreDataManager.context.fetch(request)
            completed(.success(todos))
        }
        catch {
            completed(.failure(.cantRetriveTodos))
        }
    }
    
    func deleteTodo(todo: ToDo, completed: @escaping (ErrorMessages?) -> Void) {
        
        CoreDataManager.context.delete(todo)
        do {
            try CoreDataManager.context.save()
            return
        }
        catch {
            completed(.cantDeleteTodo)
        }
    }
}
