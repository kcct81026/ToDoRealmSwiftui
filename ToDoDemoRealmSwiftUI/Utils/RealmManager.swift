//
//  RealmManager.swift
//  ToDoDemoRealmSwiftUI
//
//  Created by Kcct on 09/12/2024.
//

import Foundation
import RealmSwift

class RealmManager: ObservableObject {
    private(set) var localRealm: Realm?
    @Published var tasks: [Task] = []
    
    init() {
        openRealm()
        fetchTasks()
    }
    
    func openRealm() {
        do {
            let config = Realm.Configuration(schemaVersion: 1)
            Realm.Configuration.defaultConfiguration = config
            localRealm = try Realm()
        } catch {
            print("Error opening Realm: \(error)")
        }
    }
    
    func fetchTasks() {
        if let localRealm = localRealm {
            let allTasks = localRealm.objects(Task.self).sorted(byKeyPath: "completed", ascending: true) // Sorting in ascending order
            tasks = Array(allTasks) // Convert to array for SwiftUI
        }
    }
    
    func addTask(title: String) {
        if let localRealm = localRealm {
            do {
                try localRealm.write {
                    let newTask = Task(value: ["title": title, "completed": false])
                    localRealm.add(newTask)
                }
                fetchTasks() // Refresh tasks
            } catch {
                print("Error adding task: \(error)")
            }
        }
    }
    
    func updateTask(id: ObjectId, completed: Bool) {
        if let localRealm = localRealm,
           let task = localRealm.object(ofType: Task.self, forPrimaryKey: id) {
            do {
                try localRealm.write {
                    task.completed = completed
                }
                fetchTasks() // Refresh tasks
            } catch {
                print("Error updating task: \(error)")
            }
        }
    }
    
    func deleteTask(id: ObjectId) {
        if let localRealm = localRealm,
           let taskToDelete = localRealm.object(ofType: Task.self, forPrimaryKey: id) {
            do {
                try localRealm.write {
                    localRealm.delete(taskToDelete)
                }
                fetchTasks() // Refresh the tasks
            } catch {
                print("Error deleting task: \(error)")
            }
        }
    }
}

