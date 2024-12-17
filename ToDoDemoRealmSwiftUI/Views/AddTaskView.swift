//
//  AskTaskView.swift
//  ToDoDemoRealmSwiftUI
//
//  Created by Kcct on 09/12/2024.
//

import SwiftUI

struct AddTaskView: View {
    
    @State private var title: String = ""
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var realmManger : RealmManager
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20){
            Text("Create a new task")
                .font(.title3).bold()
                .frame(maxWidth: .infinity, alignment: .leading)
            
            TextField("Enter your task here", text: $title)
                .padding(10) 
                .frame(height: 50)
                .background(Color.white)
                .cornerRadius(8) 
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.white, lineWidth: 1)
                )

            Button{
                if title != ""{
                    realmManger.addTask(title: title)
                }
                dismiss()
            } label: {
                Text("Add task")
                    .foregroundStyle(Color(.white))
                    .padding()
                    .padding(.horizontal)
                    .background(Color(hue: 0.328, saturation: 0.796, brightness: 0.408))
                    .cornerRadius(30)
            }
              
            Spacer()
            
        }
        .padding(.top, 40)
        .padding(.horizontal)
        .background(Color(hue: 0.086, saturation: 0.141, brightness: 0.972))
    }
}

#Preview {
    AddTaskView()
        .environmentObject(RealmManager())
}
