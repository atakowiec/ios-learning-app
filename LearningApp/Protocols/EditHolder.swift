//
//  EditHolder.swift
//  LearningApp
//
//  Created by Mateusz on 06/06/2024.
//

import Foundation
import SwiftUI

class EditHolder<ObjectType>: ObservableObject {
    @Published var editorVisible: Bool = false
    @Published var editedObject: ObjectType? = nil
    
    func isEditing() -> Bool {
        return editedObject != nil
    }
}
