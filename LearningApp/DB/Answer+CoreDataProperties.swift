//
//  Answer+CoreDataProperties.swift
//  LearningApp
//
//  Created by Mateusz on 03/06/2024.
//
//

import Foundation
import CoreData


extension Answer {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Answer> {
        return NSFetchRequest<Answer>(entityName: "Answer")
    }

    @NSManaged public var content: String?
    @NSManaged public var toFlashcardOther: Flashcard?
    @NSManaged public var toFlashcardCorrect: Flashcard?

}

extension Answer : Identifiable {

}
