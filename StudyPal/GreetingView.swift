//
//  GreetingView.swift
//  StudyPal
//
//  Created by Lavanya Chandna & Gurudeep Dhinjan on 10/5/2023.
//

import SwiftUI

struct GreetingView: View {
    let username: String
    
    
    // Define state variables for bubble offsets and isActive flag
    @State private var bubble1Offset = CGSize(width: 0, height: 0)
    @State private var bubble2Offset = CGSize(width: 0, height: 0)
    @State private var bubble3Offset = CGSize(width: 0, height: 0)
    @State private var isActive = false
    
    var body: some View {
        ZStack {
            // Display the three bubbles
            Circle()
                .foregroundColor(Color("LColor1"))
                .frame(width: 200, height: 200)
                .offset(bubble1Offset)
            
            Circle()
                .foregroundColor(Color("LColor2"))
                .frame(width: 150, height: 150)
                .offset(bubble2Offset)
            
            Circle()
                .foregroundColor(Color("LColor3"))
                .frame(width: 100, height: 100)
                .offset(bubble3Offset)
                
            VStack {
                Spacer()
                
                // Display welcome message with the username
                Text("Welcome back, \(username)!")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding()
                    .foregroundColor(.white)
                    .background(Color("LColor4"))
                    .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                    .shadow(radius: 10)
                    .padding()
                    .alignmentGuide(.top) { d in d[.bottom]}
                    .alignmentGuide(.trailing) { d in d[.trailing]}
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    
                    Spacer()
            }
            .edgesIgnoringSafeArea(.all)
        }
        .onAppear {
            // Animate bubble offsets
            withAnimation(Animation.easeInOut(duration: 1.5).repeatForever(autoreverses: true)) {
                bubble1Offset = CGSize(width: -100, height: -100)
                bubble2Offset = CGSize(width: 100, height: -100)
                bubble3Offset = CGSize(width: 100, height: 100)
            }
            
            // Set isActive flag after a delay
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                isActive = true
            }
        }
        .background(
            // Navigate to MenuView when isActive is true
            NavigationLink(
                destination: MenuView(),
                isActive: $isActive,
                label: EmptyView.init
            )
            .hidden()
        )
    }
}

struct GreetingView_Previews: PreviewProvider {
    static var previews: some View {
        GreetingView(username: "")
    }
}
