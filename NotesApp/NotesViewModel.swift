//
//  NotesViewModel.swift
//  NotesApp
//
//  Created by Skylar Beesley on 2/12/26.
//

import SwiftUI
import Combine

class NotesViewModel: ObservableObject {
    @Published var notes: [Note] = [] {
        didSet {
        saveNotes()
        }
    }
    
    init() {
        loadNotes()
    }
    
    // Add a new note
    func addNote(title: String, content: String) {
        let newNote = Note(title: title, content: content)
        notes.append(newNote)
    }
    
    // Update an existing note
    func updateNote(note: Note, title: String, content: String) {
        if let index = notes.firstIndex(where: { $0.id == note.id }) {
            notes[index].title = title
            notes[index].content = content
        }
    }
    
    // Toggle completion status
    func toggleCompletion(note: Note) {
        if let index = notes.firstIndex(where: { $0.id == note.id }) {
            notes[index].isCompleted.toggle()
        }
    }
    
    // Delete notes
    func deleteNotes(at offsets: IndexSet) {
        notes.remove(atOffsets: offsets)
    }
    
    // Save notes to AppStorage
    private func saveNotes() {
        if let encoded = try? JSONEncoder().encode(notes) {
            UserDefaults.standard.set(encoded, forKey: "savedNotes")
        }
    }
    
    // Load notes from UserDefaults
    private func loadNotes() {
        if let data = UserDefaults.standard.data(forKey: "savedNotes"),
           let decoded = try? JSONDecoder().decode([Note].self, from: data) {
            notes = decoded
        }
    }
}
