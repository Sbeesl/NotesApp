//
//  Note.swift
//  NotesApp
//
//  Created by Skylar Beesley on 2/12/26.
//

import Foundation

struct Note: Identifiable, Codable {
    var id: UUID = UUID()
    var title: String
    var content: String
    var isCompleted: Bool = false
}
