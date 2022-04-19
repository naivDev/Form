//
//  Person+CoreDataProperties.swift
//  Formulario
//
//  Created by Oscar Ivan Pérez Salazar on 21/01/22.
//
//

import Foundation
import CoreData


extension Person {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Person> {
        return NSFetchRequest<Person>(entityName: "Person")
    }

    @NSManaged public var firstLastName: String?
    @NSManaged public var secondLastName: String?
    @NSManaged public var name: String?
    @NSManaged public var age: Int64
    @NSManaged public var email: String?
    @NSManaged public var homeNum: Int64
    @NSManaged public var movilNum: Int64
    @NSManaged public var direction: String?
    @NSManaged public var colony: String?
    @NSManaged public var cp: String?
    @NSManaged public var state: String?
    @NSManaged public var population: String?

}

extension Person : Identifiable {

}
