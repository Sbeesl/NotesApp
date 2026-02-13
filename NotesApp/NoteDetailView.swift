//
//  NotesDetailView.swift
//  NotesApp
//
//  Created by Skylar Beesley on 2/12/26.
//

import SwiftUI

struct NoteDetailView: View {
    var note: Note
    @ObservedObject var viewModel: NotesViewModel
    @State private var isShowingEditNote = false
    
    var body: some View {
        ZStack {
            // Gradient Background
            LinearGradient(gradient: Gradient(colors: [Color.blue.opacity(0.3), Color.purple.opacity(0.3)]),
                           startPoint: .topLeading,
                           endPoint: .bottomTrailing)
            .ignoresSafeArea()
            
            VStack(alignment: .leading, spacing: 16) {
                // Title
                Text(note.title)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .strikethrough(note.isCompleted, color: .gray)
                    .foregroundColor(note.isCompleted ? .gray : .primary)
                    .padding(.horizontal)
                
                // Content
                Text(note.content)
                    .font(.body)
                    .foregroundColor(.secondary)
                    .padding(.horizontal)
                
                // Completion Status
                HStack {
                    Image(systemName: note.isCompleted ? "checkmark.circle.fill" : "circle")
                        .foregroundColor(note.isCompleted ? .green: .gray)
                    Text(note.isCompleted ? "Completed" : "Not Completed")
                        .foregroundColor(note.isCompleted ? .green : .gray)
                }
                .padding(.horizontal)
                
                // Toggle completion button
                Button(action: {
                    viewModel.toggleCompletion(note: note)
                }) {
                    Text(note.isCompleted ? "Mark as Incomplete" : "Mark as Complete")
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(note.isCompleted ? Color.gray : Color.green)
                        .cornerRadius(12)
                        .shadow(color: .black.opacity(0.2), radius: 5, x : 0, y : 2)
                }
                .padding(.horizontal)
                
                Spacer()
            }
            .padding(.top)
        }
        .navigationTitle("Note Details")
        .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        isShowingEditNote = true
                    }) {
                        Text("Edit")
                    }
                }
            }
            .sheet(isPresented: $isShowingEditNote) {
                AddEditNoteView(viewModel: viewModel, noteToEdit: note)
        }
    }
}
