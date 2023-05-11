//
//  MenuView.swift
//  StudyPal
//
//  Created by Gurudeep Dhinjan on 11/5/2023.
//

import SwiftUI

struct MenuView: View {
    @State private var currentQuote = Quote.getRandomQuote()
    @State private var isDeepFocusModeOn = false
    @State private var minutes = 30
    @State private var task = ""
    @State private var timeRemaining = 0.0
    @State private var timer: Timer?
    @State private var progressValue: CGFloat = 1.0

    let progressBarWidth: CGFloat = 300.0
    let progressBarHeight: CGFloat = 20.0
    let progressBarCornerRadius: CGFloat = 10.0
    
    func startTimer() {
        self.timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            if self.timeRemaining > 0 {
                self.timeRemaining -= 1
                self.progressValue = CGFloat(self.timeRemaining / Double(self.minutes * 60))
            } else {
                self.isDeepFocusModeOn = false
                self.timer?.invalidate()
                self.timer = nil
//                let newTask = Task(taskName: self.task, dueDate: Date(), priority: .low, tags: [])
//                toDoList.addTask(newTask)
            }
        }
    }
    func stopTimer() {
        timer?.invalidate()
        isDeepFocusModeOn = false
        timeRemaining = 0
        progressValue = 1.0
    }
    
    func clearTimer() {
            timeRemaining = 0
            progressValue = 1.0
        }
