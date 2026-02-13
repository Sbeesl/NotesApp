//
//  ContentView.swift
//  NotesApp
//
//  Created by Skylar Beesley on 2/12/26.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = NotesViewModel()
    @State private var isShowingAddNote = false
    @State private var isGridView = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                // Gradient Background
                LinearGradient(gradient: Gradient(colors: [Color.blue.opacity(0.3), Color.purple.opacity(0.3)]), startPoint: .topLeading,
                               endPoint: .bottomTrailing)
                
                .ignoresSafeArea()
                
                // Notes List or Grid
                if viewModel.notes.isEmpty {
                    VStack {
                        Image(systemName: "note.text")
                            .font(.system(size: 60))
                            .foregroundColor(.gray)
                        Text("No notes yet!")
                            .font(.title2)
                            .foregroundColor(.gray)
                        Text("Tap + to add your first note")
                            .foregroundColor(.gray)
                    }
                } else {
                    if isGridView {
                        // Grid view
                        ScrollView {
                            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
                                ForEach(viewModel.notes) { note in
                                    NavigationLink(destination: NoteDetailView(note: note, viewModel: viewModel)) {
                                    NoteCardView(note: note)
                                    }
                                }
                            }
                            .padding()
                        }
                    } else {
                        // List View
                        List {
                            ForEach(viewModel.notes) { note in
                                NavigationLink(destination: NoteDetailView(note: note, viewModel: viewModel)) {
                                    VStack(alignment: .leading, spacing: 4) {
                                        Text(note.title)
                                            .font(.headline)
                                            .strikethrough(note.isComplete, color: .gray)
                                            .foregroundColor(note.isCompleted ? .gray : .primary)
                                        Text(note.content)
                                            .font(.subheadline)
                                            .foregroundColor(.secondary)
                                            .lineLimit(2)
                                    }
                                    .padding(.vertical, 4)
                                }
                            }
                            .onDelete(perform: viewModel.deleteNotes)
                        }
                        .scrollContentBackground(.hidden)
                    }
                }
            }
            .navigationTitle("My Notes")
            .toolbar {
                // Grid/List toggle button
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        isGridView.toggle()
                    }) {
                        Image(systemName: isGridView ? "list.bullet" : "square.grid.2x2")
                    }
                }
                
                // Add Note Button
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        isShowingAddNote = true
                    }) {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $isShowingAddNote) {
                AddEditNoteView(viewModel: viewModel)
            }
        }
    }
}

struct NoteCardView: View {
    var note: Note
    
    var body : some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text(note.title)
                    .font(.headline)
                    .strikethrough(note.isCompleted, color: .gray)
                    .foregroundColor(note.isCompleted ? .gray : .primary)
                    .lineLimit(1)
                Spacer()
                if note.isCompleted {
                    Image(systemName: "checkmark.circle.fill")
                        .foregroundColor(.green)
                }
            }
            Text(note.content)
                .font(.subheadline)
                .foregroundColor(.secondary)
                .lineLimit(3)
        }
        .padding()
        .background(Color.white.opacity(0.8))
        .cornerRadius(12)
        .shadow(color: .black.opacity(0.1), radius: 5, x: 0, y: 2)
    }
}
#Preview {
    ContentView()
}
