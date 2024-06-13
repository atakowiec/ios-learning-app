//
//  Flashcard+CoreDataProperties.swift
//  LearningApp
//
//  Created by Mateusz on 03/06/2024.
//
//

import Foundation
import CoreData


extension Flashcard {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Flashcard> {
        return NSFetchRequest<Flashcard>(entityName: "Flashcard")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var learned: Bool
    @NSManaged public var question: String?
    @NSManaged public var toOtherAnswers: NSSet?
    @NSManaged public var toCollection: Collection?
    @NSManaged public var toCorrectAnswer: Answer?

}

// MARK: Generated accessors for toOtherAnswers
extension Flashcard {

    @objc(addToOtherAnswersObject:)
    @NSManaged public func addToToOtherAnswers(_ value: Answer)

    @objc(removeToOtherAnswersObject:)
    @NSManaged public func removeFromToOtherAnswers(_ value: Answer)

    @objc(addToOtherAnswers:)
    @NSManaged public func addToToOtherAnswers(_ values: NSSet)

    @objc(removeToOtherAnswers:)
    @NSManaged public func removeFromToOtherAnswers(_ values: NSSet)

}

extension Flashcard : Identifiable {

}
