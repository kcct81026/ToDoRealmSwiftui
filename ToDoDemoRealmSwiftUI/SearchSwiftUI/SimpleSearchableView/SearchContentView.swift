//
//  SearchContentView.swift
//  ToDoDemoRealmSwiftUI
//
//  Created by Kcct on 17/12/2024.
//

import SwiftUI

enum Scopes {
    case work, personal
}

struct SearchContentView: View {
    
    @Environment(ApplicationData.self) private var appData
    @State private var searchTerm: String = ""
    @State private var searchScope : Scopes = .work
    
    var body: some View {
        NavigationStack{
            List{
                ForEach(appData.filteredItems){ task in
                    TaskCell(task: task)
                }
                .onDelete(perform: deleteTask)
            }
            .navigationTitle(Text("Tasks"))
        }
        .searchable(text: $searchTerm, placement: .navigationBarDrawer(displayMode: .always) , prompt: "Search taks")
        .searchScopes($searchScope, scopes: {
            Text("Work").tag(Scopes.work)
            Text("Personal").tag(Scopes.personal)
        })
        .onChange(of: searchTerm, initial: false){ _,_ in
            performSearch()
        }
        .onChange(of: searchScope){ _,_ in
            performSearch()
        }
//        .onChange(of: searchTerm, initial: false ){ old, value in
//            let search = value.trimmingCharacters(in: .whitespaces)
//            appData.filterValues(search: search)
//        }
    }
    
    private func deleteTask(at offsets: IndexSet) {
        // Find the items to delete in the original `userData`
        let tasksToDelete = offsets.map { appData.filteredItems[$0] }
        for task in tasksToDelete {
            if let index = appData.userData.firstIndex(of: task) {
                appData.userData.remove(at: index)
            }
        }
    }
    
    func performSearch(){
        let search = searchTerm.trimmingCharacters(in: .whitespaces)
        appData.filterValues(search: search, scope: searchScope)
    }
}

struct TaskCell: View {
    let task: TaskData
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(task.title)
                .font(.headline)
                .bold()
            Text(task.description)
                .font(.subheadline)
                .foregroundColor(.gray)
                .lineLimit(2)
            Text("Due: \(task.displayDueDate)")
                .font(.caption)
                .foregroundColor(.primary)
                .fontWeight(.semibold)
        }
        .padding(.vertical, 8)
    }
}
#Preview {
    SearchContentView()
        .environment(ApplicationData.shared)
}
