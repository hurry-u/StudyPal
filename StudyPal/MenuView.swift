//
//  MenuView.swift
//  StudyPal
//
//  Created by Lavanya Chandna & Gurudeep Dhinjan on 10/5/2023.
//

import SwiftUI
import AVFoundation

struct MenuView: View {
    // State properties
    @State private var currentQuote = Quote.getRandomQuote()
    //Store the current quote
    @State private var previousQuote: Quote?
    //Store the previous quote
    @State private var quoteTimer: Timer?
    // Timer for updating the quote
    @State private var isDeepFocusModeOn = false
    // FLag for deep focus mode
    @State private var minutes = 5 {
        didSet {
            if minutes > 60 {
                minutes = 60
            }
            //Duration in minutes
        }
    }
    @State private var task = ""
    //Task to complete during the session
    @State private var timeRemaining = 0.0
    //Remaining time in seconds
    @State private var initialTimeRemaining = 0.0
    //Initial time remaining
    @State private var timer: Timer?
    //Timer for countdown
    @State private var progressValue: CGFloat = 1.0
    //Progress value for the progress bar
    @State private var audioPlayer: AVAudioPlayer?
    //Audio player for timer end sound
    @State private var isPaused = false
    //Flag for paused state
    @State private var pausedTimeRemaining = 0.0
    //Time remaining when paused
    @State private var previousMinutes = 0
    //Previous duration in minutes

    
    let progressBarWidth: CGFloat = 300.0
    //Width of the progress bar
    let progressBarHeight: CGFloat = 20.0
    //Height of the progress bar
    let progressBarCornerRadius: CGFloat = 10.0
    //Corner radius of the progress bar
    
    // Function that allows for the timer_end_sound to play when the clear button is pressed after the timer starts.
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

    // Function starts timer when the start button is pressed.
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
                
                playTimerEndSound()
                // Play the sound when the timer ends
            }
        }
        
        self.timer?.invalidate()
        // Invalidate the existing timer
        
        self.timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            if self.timeRemaining > 0 {
                if self.isPaused {
                    self.pausedTimeRemaining = self.timeRemaining
                    // Store the remaining time when paused
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
                //Play the sound when the timer ends
            }
        }
    }
    
    // Function used to pause the timer.
    func pauseTimer() {
            isPaused = true
            pausedTimeRemaining = timeRemaining
            timer?.invalidate()
            timer = nil
        }
    
    // Function used to clear the timer.
    func clearTimer() {
        timeRemaining = Double(minutes * 60)
        progressValue = 1.0
        
        // Stop the timer when cleared
        timer?.invalidate()
        timer = nil
        
        // Play the "lost.mp3" sound when the timer is cleared.
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
                    // Motivational Quote Heading
                    VStack(spacing: 15) {
                        Text(" The 2-Minute Wisdom")
                            .font(.title3)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                        
                        // Changing quotes from the collection made in the Quote file.
                        Text(currentQuote.text)
                            .font(.custom("HelveticaNeue-Light", size: 18))
                            .foregroundColor(.white)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 20)
                            .lineLimit(3)
                            .fixedSize(horizontal: false, vertical: true)
                            .scaleEffect(isDeepFocusModeOn ? 1.0 : 0.8)
                        // Apply scale animation
                        
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
                        Text("Enter The Task Details To Continue")
                        // To inform the users that they need to fill the text box inorder to activate the start button.
                            .foregroundColor(.white)
                        
                        ZStack {
                            // Progress bar
                            GeometryReader { geometry in
                                // Gray background of the progress bar
                                RoundedRectangle(cornerRadius: progressBarCornerRadius)
                                    .foregroundColor(Color.gray.opacity(0.4))
                                
                                // Green progress bar indicating the completion progress
                                RoundedRectangle(cornerRadius: progressBarCornerRadius)
                                    .foregroundColor(Color.green)
                                    .frame(width: geometry.size.width * self.progressValue)
                            }
                            .frame(width: progressBarWidth, height: 7)
                            .padding(.bottom, 20)
                        }
                        
                        // Timer display
                        Text(String(format: "%02d:%02d", Int(timeRemaining / 60), Int(timeRemaining) % 60))
                            .font(.custom("HelveticaNeue-Light", size: 80))
                            .foregroundColor(isDeepFocusModeOn ? .green : .white)
                        
                        HStack(spacing: 20) {
                            // Minus button to decrease the timer duration by 5 minutes
                            Button(action: {
                                minutes = max(5, minutes - 5)
                                timeRemaining = Double(minutes * 60)
                                progressValue = 1.0
                            }) {
                                Image(systemName: "minus.circle.fill")
                                    .font(.largeTitle)
                            }
                            .buttonStyle(PlainButtonStyle())
                            
                            // Plus button to increase the timer duration by 5 minutes
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
                        
                        // Control buttons for timer
                        VStack {
                            HStack {
                                // Start button to initiate the timer
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
                                
                                // Pause/Resume button to pause or resume the timer
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
                            
                            // Clear button to reset the timer and progress bar
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
                // Hide the navigation bar at the top of the view. Update the quote every 2 minutes
                quoteTimer = Timer.scheduledTimer(withTimeInterval: 120, repeats: true) { _ in
                    // Execute the closure every 2 minutes
                    withAnimation(.easeInOut(duration: 0.5)) {
                        // Apply a smooth animation to the quote update
                        currentQuote = Quote.getRandomQuote()
                        // Update the current quote with a randomly selected quote
                    }
                }
                quoteTimer?.fire()
                // Immediately trigger the timer to start the quote updates. Set the initial time to 05:00 (5 minutes)
                timeRemaining = Double(minutes * 60)
                // Convert minutes to seconds and assign it to the timeRemaining variable
            }
            .onDisappear {
                // Execute the closure when the view disappears. Stop the quoteTimer by invalidating it. Set the quoteTimer to nil to release its reference and free up resources
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

