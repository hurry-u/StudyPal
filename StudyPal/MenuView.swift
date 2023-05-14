//
//  MenuView.swift
//  StudyPal
//
//  Created by Sana Chandna & Gurudeep Dhinjan on 10/5/2023.
//

import SwiftUI

struct MenuView: View {
    @State private var currentQuote = Quote.getRandomQuote()
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
    @State private var timer: Timer?
    @State private var progressValue: CGFloat = 1.0

    let progressBarWidth: CGFloat = 300.0
    let progressBarHeight: CGFloat = 20.0
    let progressBarCornerRadius: CGFloat = 10.0
    
    //func startTimer() {
//     //   self.timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
//      //      if self.timeRemaining > 0 {
//                self.timeRemaining -= 1
//                self.progressValue = CGFloat(self.timeRemaining / Double(self.minutes * 60))
//        //    } else {
//                self.isDeepFocusModeOn = false
//                self.timer?.invalidate()
//                self.timer = nil
//            }
//        }
   // }
    func startTimer() {
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
                    VStack(spacing: 15) {
                        Text("Quote of the Hour")
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
                                minutes = max(30, minutes - 5)
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
                                .disabled(task.isEmpty || isDeepFocusModeOn || minutes < 5)
                                
                                Button(action: {
                                    isDeepFocusModeOn = false
                                    timer?.invalidate()
                                    progressValue = 1.0
                                }) {
                                    Text("Stop")
                                        .font(.headline)
                                        .bold()
                                        .padding()
                                        .background(Color.red)
                                        .foregroundColor(Color.black)
                                        .cornerRadius(10)
                                        .padding(.horizontal, 55)
                                }
                                .buttonStyle(PlainButtonStyle())
                            }
                            .padding(.bottom, 10)
                            
                            Button(action: {
                                stopTimer()
                                progressValue = 1.0
                            }) {
                                Text("Clear")
                                    .font(.headline)
                                    .bold()
                                    .padding()
                                    .background(Color.yellow)
                                    .foregroundColor(Color.black)
                                    .cornerRadius(10)
                                    .padding(.horizontal, 55)
                            }
                            .buttonStyle(PlainButtonStyle())
                            
                        }


                    }
                }
            }
            .navigationBarHidden(true)
            .onAppear {
                // Update the quote every hour
                let timer = Timer.scheduledTimer(withTimeInterval: 3600, repeats: true) { _ in
                    currentQuote = Quote.getRandomQuote()
                }
                timer.fire()
            }
        }
    }
}


struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
    }
}

