//
//  TasksView.swift
//  ToDoDemoRealmSwiftUI
//
//  Created by Kcct on 09/12/2024.
//

import SwiftUI
import RealmSwift

struct TasksView: View {
    @ObservedResults(Task.self) var tasks
    
    @EnvironmentObject var realmManager: RealmManager
    
    var body: some View {
        VStack {
            Text("My tasks")
                .font(.title3).bold()
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
            
            List {
                ForEach(tasks) { task in
                    TaskRow(task: task.title, completed: task.completed)
                        .onTapGesture {
                            // Update task completed status via RealmManager
                            realmManager.updateTask(id: task.id, completed: !task.completed)
                        }
                        .swipeActions(edge: .trailing) {
                            Button(role: .destructive) {
                                // Delete task via RealmManager
                                realmManager.deleteTask(id: task.id)
                            } label: {
                                Label("Delete", systemImage: "trash")
                            }
                        }
                }
                .listRowSeparator(.hidden)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(hue: 0.086, saturation: 0.141, brightness: 0.972))
    }
}


