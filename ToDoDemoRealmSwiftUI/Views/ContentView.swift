//
//  ContentView.swift
//  ToDoDemoRealmSwiftUI
//
//  Created by Kcct on 09/12/2024.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var realmManager = RealmManager()
    
    @State private var showAddTaskView = false
    
    var body: some View {
        ZStack(alignment: .bottomTrailing){
            TasksView()
                .environmentObject(realmManager)

            SmallAddButton()
                .padding()
                .onTapGesture {
                    showAddTaskView.toggle()
                }
        }
        .sheet(isPresented: $showAddTaskView){
            AddTaskView()
                .environmentObject(realmManager)

        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
        .background(Color(hue: 0.086, saturation: 0.141, brightness: 0.972))
    }
}

#Preview {
    ContentView()
}
