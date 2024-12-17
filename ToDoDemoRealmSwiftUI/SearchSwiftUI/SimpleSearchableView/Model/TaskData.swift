//
//  TaskData.swift
//  ToDoDemoRealmSwiftUI
//
//  Created by Kcct on 17/12/2024.
//

import SwiftUI
import Observation

struct TaskData: Identifiable, Hashable {
   let id = UUID()
   var title: String
   var description: String
   var dueDate: Date
   var category: String // e.g., "Work" or "Personal"
   var completed: Bool
   
   var displayDueDate: String {
      let formatter = DateFormatter()
      formatter.dateStyle = .medium
      return formatter.string(from: dueDate)
   }
}

@Observable class ApplicationData: @unchecked Sendable {
   @ObservationIgnored var userData: [TaskData] {
      didSet {
         filterValues(search: "")
      }
   }
   var filteredItems: [TaskData] = []

    func filterValues(search: String, scope: Scopes = .work) {
        let filteredByCategory: [TaskData]
        switch scope {
        case .work:
            filteredByCategory = userData.filter { $0.category == "Work" }
        case .personal:
            filteredByCategory = userData.filter { $0.category == "Personal" }
        }
       
      if search.isEmpty {
          filteredItems = filteredByCategory.sorted(by: { $0.title < $1.title })
      } else {
          let list = filteredByCategory.filter { $0.title.localizedStandardContains(search) ||
                   $0.description.localizedStandardContains(search)
         }
         filteredItems = list.sorted(by: { $0.title < $1.title })
      }
   }

   static let shared: ApplicationData = ApplicationData()
   
   private init() {
      let formatter = DateFormatter()
      formatter.dateFormat = "yyyy/MM/dd"

       userData = [
        TaskData(title: "Prepare presentation", description: "Work on the Q1 project presentation for the team.", dueDate: formatter.date(from: "2024/12/15")!, category: "Work", completed: false),
        TaskData(title: "Grocery shopping", description: "Buy groceries for the week.", dueDate: formatter.date(from: "2024/12/10")!, category: "Personal", completed: false),
        TaskData(title: "Submit report", description: "Finalize and submit the annual report.", dueDate: formatter.date(from: "2024/12/14")!, category: "Work", completed: false),
        TaskData(title: "Doctor's appointment", description: "Annual health check-up.", dueDate: formatter.date(from: "2024/12/12")!, category: "Personal", completed: false),
        TaskData(title: "Team meeting", description: "Discuss project updates with the team.", dueDate: formatter.date(from: "2024/12/11")!, category: "Work", completed: false),
        TaskData(title: "Read a book", description: "Finish reading the latest novel.", dueDate: formatter.date(from: "2024/12/20")!, category: "Personal", completed: false),
        TaskData(title: "Plan vacation", description: "Research and book tickets for the holiday.", dueDate: formatter.date(from: "2024/12/18")!, category: "Personal", completed: false),
        TaskData(title: "Update resume", description: "Revise resume for new job opportunities.", dueDate: formatter.date(from: "2024/12/16")!, category: "Work", completed: false),
        TaskData(title: "Organize files", description: "Organize work files and folders for easy access.", dueDate: formatter.date(from: "2024/12/09")!, category: "Work", completed: false),
        TaskData(title: "Prepare dinner party", description: "Plan and prepare for the weekend dinner party.", dueDate: formatter.date(from: "2024/12/13")!, category: "Personal", completed: false),
        TaskData(title: "Fix plumbing issue", description: "Call a plumber to fix the leaking kitchen sink.", dueDate: formatter.date(from: "2024/12/14")!, category: "Personal", completed: false),
        TaskData(title: "Complete online course", description: "Finish the advanced SwiftUI course by the end of the month.", dueDate: formatter.date(from: "2024/12/22")!, category: "Work", completed: false),
        TaskData(title: "Visit parents", description: "Spend the weekend with parents.", dueDate: formatter.date(from: "2024/12/17")!, category: "Personal", completed: false),
        TaskData(title: "Finish project prototype", description: "Complete the initial prototype for the new app.", dueDate: formatter.date(from: "2024/12/19")!, category: "Work", completed: false),
        TaskData(title: "Christmas shopping", description: "Buy Christmas gifts for family and friends.", dueDate: formatter.date(from: "2024/12/21")!, category: "Personal", completed: false),
        TaskData(title: "Car service", description: "Take the car for a scheduled maintenance service.", dueDate: formatter.date(from: "2024/12/14")!, category: "Personal", completed: false),
        TaskData(title: "Plan Q1 strategy", description: "Draft a strategic plan for Q1 objectives.", dueDate: formatter.date(from: "2024/12/23")!, category: "Work", completed: false),
        TaskData(title: "Call bank", description: "Resolve account issues with the bank.", dueDate: formatter.date(from: "2024/12/10")!, category: "Personal", completed: false),
        TaskData(title: "Holiday decoration", description: "Decorate the house for the holiday season.", dueDate: formatter.date(from: "2024/12/20")!, category: "Personal", completed: false),
        TaskData(title: "Prepare tax documents", description: "Organize and prepare tax documents for submission.", dueDate: formatter.date(from: "2024/12/15")!, category: "Work", completed: false)
             ]
      
      filterValues(search: "")
   }
}
