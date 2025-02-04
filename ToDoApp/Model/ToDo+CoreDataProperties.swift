//
//  ToDo+CoreDataProperties.swift
//  ToDoApp
//
//  Created by Rubin Vadim on 30.01.2025.
//
//

import Foundation
import CoreData


extension ToDo {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ToDo> {
        return NSFetchRequest<ToDo>(entityName: "ToDo")
    }

    @NSManaged public var completed: Bool
    @NSManaged public var date: Date?
    @NSManaged public var taskDescription: String?
    @NSManaged public var title: String?

}

extension ToDo : Identifiable {

}
