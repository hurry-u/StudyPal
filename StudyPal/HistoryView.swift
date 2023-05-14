////
////  HistoryView.swift
////  StudyPal
////
////  Created by Sana Chandna & Gurudeep Dhinjan on 10/5/2023.
////
//
//
//import SwiftUI
//
//struct HistoryView: View {
//    // Array to store the task history
//    @State private var taskHistory: [Task] = []
//
//    var body: some View {
//        VStack {
//            if taskHistory.isEmpty {
//                Text("No tasks in history")
//                    .font(.title)
//                    .foregroundColor(.gray)
//            } else {
//                List<Task, Identifiable>(taskHistory) { task in
//                    VStack(alignment: .leading) {
//                        Text(task.task)
//                            .font(.headline)
//                        Text("Duration: \(task.duration) minutes")
//                            .font(.subheadline)
//                            .foregroundColor(.gray)
//                    }
//                }
//            }
//        }
//        .padding()
//        .onAppear {
//            // Load task history from storage or API
//            // taskHistory = ...
//        }
//    }
//}
//
//struct HistoryView_Previews: PreviewProvider {
//    static var previews: some View {
//        HistoryView()
//    }
//}
