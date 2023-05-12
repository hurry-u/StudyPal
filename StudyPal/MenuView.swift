//
//  MenuView.swift
//  StudyPal
//
//  Created by Sana Chandna & Gurudeep Dhinjan on 10/5/2023.
//

import SwiftUI

struct MenuView: View {
    //    @State private var currentQuote = Quote.getRandomQuote()
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
    
    
    var body: some View {
        NavigationView {
            
            ZStack {
                // Background gradient
                LinearGradient(gradient: Gradient(colors: [Color("LColor4"), Color("Black")]), startPoint: .top, endPoint: .bottom)
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    // Motivational Quote
                    VStack(spacing: 10) {
                        Text("Quote of the Hour")
                            .font(.title3)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                        
                        Spacer()
                    }
                }
            }
        }
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
    }
}
