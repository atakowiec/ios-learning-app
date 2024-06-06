//
//  EditHolder.swift
//  LearningApp
//
//  Created by Mateusz on 06/06/2024.
//

import Foundation
import SwiftUI

class CollectionEditHolder: ObservableObject {
    @Published var editorVisible: Bool = false
    @Published var editedCollection: Collection? = nil
    
    func isEditing() -> Bool {
        return editedCollection != nil
    }
}
