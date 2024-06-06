//
//  Collection+CoreDataProperties.swift
//  LearningApp
//
//  Created by Mateusz on 03/06/2024.
//
//

import Foundation
import CoreData


extension Collection {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Collection> {
        return NSFetchRequest<Collection>(entityName: "Collection")
    }

    @NSManaged public var id: UUID
    @NSManaged public var name: String?
    @NSManaged public var toFlashcards: NSSet?

}

// MARK: Generated accessors for toFlashcards
extension Collection {

    @objc(addToFlashcardsObject:)
    @NSManaged public func addToToFlashcards(_ value: Flashcard)

    @objc(removeToFlashcardsObject:)
    @NSManaged public func removeFromToFlashcards(_ value: Flashcard)

    @objc(addToFlashcards:)
    @NSManaged public func addToToFlashcards(_ values: NSSet)

    @objc(removeToFlashcards:)
    @NSManaged public func removeFromToFlashcards(_ values: NSSet)

}

extension Collection : Identifiable {

}
