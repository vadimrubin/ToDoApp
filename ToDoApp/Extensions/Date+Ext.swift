//
//  Date+Ext.swift
//  ToDoApp
//
//  Created by Rubin Vadim on 04.02.2025.
//

import Foundation

extension Date {
    
    func convertToMonthYearFormat() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        
        return dateFormatter.string(from: self)
    }
    
}
