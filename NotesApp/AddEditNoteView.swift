//
//  AddEditNoteView.swift
//  NotesApp
//
//  Created by Skylar Beesley on 2/12/26.
//

import SwiftUI

struct AddEditNoteView: View {
    @ObservedObject var viewModel: NotesViewModel
    var noteToEdit: Note? = nil
    
    @State private var title: String = ""
    @State private var content: String = ""
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            ZStack {
                // Gradient Background
                LinearGradient(gradient: Gradient(colors: [Color.blue.opacity(0.3), Color.purple.opacity(0.3)]),
                               startPoint: .topLeading,
                               endPoint: .bottomTrailing)
                .ignoresSafeArea()
                
                VStack(spacing: 16) {
                    // Title Field
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Title")
                            .font(.headline)
                            .padding(.horizontal)
                        TextField("Enter note title...", text: $title)
                            .padding()
                            .background(Color.white.opacity(0.8))
                            .cornerRadius(12)
                            .shadow(color: .black.opacity(0.1), radius: 5, x: 0, y: 2)
                            .padding(.horizontal)
                    }
                    
                    // Content Field
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Content")
                            .font(.headline)
                            .padding(.horizontal)
                        TextEditor(text: $content)
                            .frame(minHeight: 200)
                            .padding()
                            .background(Color.white.opacity(0.8))
                            .cornerRadius(12)
                            .shadow(color: .black.opacity(0.1), radius: 5, x: 0, y: 2)
                            .padding(.horizontal)
                    }
                    
                    Spacer()
                }
                .padding(.top)
            }
            .navigationTitle(noteToEdit == nil ? "New Note" : "Edit Note")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                // cancel Button
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        if noteToEdit == nil {
                            viewModel.addNote(title: title, content: content)
                        } else {
                            viewModel.updateNote(note: noteToEdit!, title: title, content: content)
                        }
                        dismiss()
                    }
                    .disabled(title.isEmpty)
                    .fontWeight(.semibold)
                }
            }
            .onAppear {
                if let note = noteToEdit {
                    title = note.title
                    content = note.content
                }
            }
        }
    }
}
