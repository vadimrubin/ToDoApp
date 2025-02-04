//
//  NetworkManager.swift
//  ToDoApp
//
//  Created by Rubin Vadim on 30.01.2025.
//

import UIKit

class NetworkManager {
    
    static let shared = NetworkManager()
    
    private init() {}
    
    func getTasks(completed: @escaping (Result<[Task], ErrorMessages>) -> Void) {
        
        let urlString = "https://dummyjson.com/todos"
        
        guard let url = URL(string: urlString) else {
            
            completed(.failure(.unableToComplete))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            if let _ = error {
                completed(.failure(.unableToComplete))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.unableToComplete))
                return
            }
            
            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
//                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let response = try decoder.decode(TodosResponse.self, from: data)
                completed(.success(response.todos))
            } catch {
                completed(.failure(.invalidData))
            }
        }
        task.resume()
    }
}
