//
//  ErrorMessages.swift
//  ToDoApp
//
//  Created by Rubin Vadim on 30.01.2025.
//

import Foundation

enum ErrorMessages: String, Error {
    case unableToComplete = "Unnable to complete your request. Please check your internet connection"
    case invalidData = "The data received from the server was invalid. Please try again."
}
