//
//  MenuView.swift
//  StudyPal
//
//  Created by Sana Chandna & Gurudeep Dhinjan on 10/5/2023.
//

import SwiftUI
import AVFoundation

struct MenuView: View {
    @State private var currentQuote = Quote.getRandomQuote()
    @State private var previousQuote: Quote?
    @State private var quoteTimer: Timer?
    @State private var isDeepFocusModeOn = false
    @State private var minutes = 5 {
        didSet {
            if minutes > 60 {
                minutes = 60
            }
        }
    }
    @State private var task = ""
    @State private var timeRemaining = 0.0
    @State private var initialTimeRemaining = 0.0
    @State private var timer: Timer?
    @State private var progressValue: CGFloat = 1.0
    @State private var audioPlayer: AVAudioPlayer?
    @State private var isPaused = false
    @State private var pausedTimeRemaining = 0.0
    @State private var previousMinutes = 0

    
    let progressBarWidth: CGFloat = 300.0
    let progressBarHeight: CGFloat = 20.0
    let progressBarCornerRadius: CGFloat = 10.0
    
    func playTimerEndSound() {
        guard let soundURL = Bundle.main.url(forResource: "timer_end_sound", withExtension: "mp3") else {
            return
        }
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: soundURL)
            audioPlayer?.play()
        } catch {
            print("Failed to play timer end sound: \(error)")
        }
    }

    
    func startTimer() {
        if timeRemaining <= 0 {
            // Start a new session
            timeRemaining = Double(minutes * 60)
            initialTimeRemaining = timeRemaining
        }
        
        
        self.timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            if self.timeRemaining > 0 {
                self.timeRemaining -= 1
                self.progressValue = CGFloat(self.timeRemaining / Double(self.minutes * 60))
                
                // Check if the time remaining exceeds 60 minutes and adjust it
                if self.timeRemaining > Double(60 * 60) {
                    self.timeRemaining = Double(60 * 60)
                }
            } else {
                self.isDeepFocusModeOn = false
                self.timer?.invalidate()
                self.timer = nil
                
                playTimerEndSound() // Play the sound when the timer ends
            }
        }
        
        self.timer?.invalidate() // Invalidate the existing timer
        
        self.timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            if self.timeRemaining > 0 {
                if self.isPaused {
                    self.pausedTimeRemaining = self.timeRemaining // Store the remaining time when paused
                    return
                    // Exit the closure and wait for the next tick
                }
                
                self.timeRemaining -= 1
                self.progressValue = CGFloat(self.timeRemaining / Double(self.minutes * 60))
                
                // Check if the time remaining exceeds 60 minutes and adjust it
                if self.timeRemaining > Double(60 * 60) {
                    self.timeRemaining = Double(60 * 60)
                }
            } else {
                self.isDeepFocusModeOn = false
                self.timer?.invalidate()
                self.timer = nil
                
                playTimerEndSound()
            }
        }
    }

    func pauseTimer() {
            isPaused = true
            pausedTimeRemaining = timeRemaining
            timer?.invalidate()
            timer = nil
        }

    func clearTimer() {
        timeRemaining = Double(minutes * 60)
        progressValue = 1.0
        
        // Stop the timer when cleared
        timer?.invalidate()
        timer = nil
        
        // Play the "lost.mp3" sound when the timer is cleared
        guard let soundURL = Bundle.main.url(forResource: "lost", withExtension: "mp3") else {
            return
        }
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: soundURL)
            audioPlayer?.play()
        } catch {
            print("Failed to play lost sound: \(error)")
        }
    }
    var body: some View {
            NavigationView {
                ZStack {
                    // Background gradient
                    LinearGradient(gradient: Gradient(colors: [Color("LColor4"), Color("Black")]), startPoint: .top, endPoint: .bottom)
                        .edgesIgnoringSafeArea(.all)
                    
                    VStack {
                        // Motivational Quote
                        VStack(spacing: 15) {
                            Text(" The 2-Minute Wisdom")
                                .font(.title3)
                                .fontWeight(.bold)
                                .foregroundColor(.white)

                            Text(currentQuote.text)
                                .font(.custom("HelveticaNeue-Light", size: 18))
                                .foregroundColor(.white)
                                .multilineTextAlignment(.center)
                                .padding(.horizontal, 20)
                                .lineLimit(3)
                                .fixedSize(horizontal: false, vertical: true)
                                .scaleEffect(isDeepFocusModeOn ? 1.0 : 0.8) // Apply scale animation

                            Text("- \(currentQuote.author)")
                                .font(.custom("HelveticaNeue-Light", size: 15))
                                .foregroundColor(.white)
                        }
                        .padding(.top, 20)
                        .padding(.horizontal, 20)

                        Spacer()
                        
                    VStack {
                        // Task to complete during session
                        TextField("Task to complete", text: $task)
                            .font(.headline)
                            .padding()
                            .background(Color.white)
                            .cornerRadius(10)
                            .padding(.horizontal, 20)
                            .padding(.bottom, 20)
                        Text("Please enter the task details to continue")
                            .foregroundColor(.white)
                            
                        // Progress bar
                        ZStack {
                            GeometryReader { geometry in
                                RoundedRectangle(cornerRadius: progressBarCornerRadius)
                                    .foregroundColor(Color.gray.opacity(0.4))
                                RoundedRectangle(cornerRadius: progressBarCornerRadius)
                                    .foregroundColor(Color.green)
                                    .frame(width: geometry.size.width * self.progressValue)
                            }
                            .frame(width: progressBarWidth, height: 7)
                            .padding(.bottom, 20)
                        }
                        
                        // Timer
                        Text(String(format: "%02d:%02d", Int(timeRemaining / 60), Int(timeRemaining) % 60))
                            .font(.custom("HelveticaNeue-Light", size: 80))
                            .foregroundColor(isDeepFocusModeOn ? .green : .white)

                        HStack(spacing: 20) {
                            Button(action: {
                                minutes = max(5, minutes - 5)
                                timeRemaining = Double(minutes * 60)
                                progressValue = 1.0
                            }) {
                                Image(systemName: "minus.circle.fill")
                                    .font(.largeTitle)
                            }
                            .buttonStyle(PlainButtonStyle())
                            
                            Button(action: {
                                minutes = min(120, minutes + 5)
                                timeRemaining = Double(minutes * 60)
                                progressValue = 1.0
                            }) {
                                Image(systemName: "plus.circle.fill")
                                    .font(.largeTitle)
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                        .foregroundColor(.white)
                        
                        //Buttons
                        VStack {
                            HStack {
                                Button(action: {
                                    isDeepFocusModeOn = true
                                    timeRemaining = Double(minutes * 60)
                                    startTimer()
                                }) {
                                    Text("Start")
                                        .font(.headline)
                                        .bold()
                                        .padding()
                                        .background(Color.green)
                                        .foregroundColor(Color.black)
                                        .cornerRadius(10)
                                        .padding(.horizontal, 55)
                                }
                                .buttonStyle(PlainButtonStyle())
                                .disabled(task.isEmpty || minutes < 5)
                                
                                Button(action: {
                                    isPaused.toggle()
                                    if isPaused {
                                        pauseTimer()
                                    } else {
                                        startTimer()
                                    }
                                }) {
                                    Text(isPaused ? "Resume" : "Pause")
                                        .font(.headline)
                                        .bold()
                                        .padding()
                                        .background(Color.red)
                                        .foregroundColor(Color.black)
                                        .cornerRadius(10)
                                        .padding(.horizontal, 50)
                                }
                                .buttonStyle(PlainButtonStyle())
                                .disabled(task.isEmpty || minutes < 5)
                            }
                            .padding(.bottom, 10)

                            
                            Button(action: {
                                clearTimer()
                                progressValue = 1.0
                            }) {
                                Text("Clear")
                                    .font(.headline)
                                    .bold()
                                    .padding()
                                    .background(Color.yellow)
                                    .foregroundColor(Color.black)
                                    .cornerRadius(10)
                                    .padding(.horizontal, 50)
                            }
                            .buttonStyle(PlainButtonStyle())
                            .disabled(task.isEmpty || minutes < 5)
                        }
                    }
                }
            }
                .navigationBarHidden(true)
                        .onAppear {
                            // Update the quote every 2 minutes
                            quoteTimer = Timer.scheduledTimer(withTimeInterval: 120, repeats: true) { _ in
                                withAnimation(.easeInOut(duration: 0.5)) {
                                    currentQuote = Quote.getRandomQuote()
                                }
                            }
                            quoteTimer?.fire()

                            // Set initial time to 05:00
                            timeRemaining = Double(minutes * 60)
                        }
                        .onDisappear {
                            // Stop the quote timer when the view disappears
                            quoteTimer?.invalidate()
                            quoteTimer = nil
                        }
        }
    }
}


struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
    }
}

