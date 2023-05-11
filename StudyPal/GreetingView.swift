//
//  GreetingView.swift
//  StudyPal
//
//  Created by Sana Chandna & Gurudeep Dhinjan on 10/5/2023.
//

import SwiftUI

struct GreetingView: View {
    let username: String
    
    @State private var bubble1Offset = CGSize(width: 0, height: 0)
    @State private var bubble2Offset = CGSize(width: 0, height: 0)
    @State private var bubble3Offset = CGSize(width: 0, height: 0)
    @State private var isActive = false
    
    var body: some View {
        ZStack {
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
            withAnimation(Animation.easeInOut(duration: 1.5).repeatForever(autoreverses: true)) {
                bubble1Offset = CGSize(width: -100, height: -100)
                bubble2Offset = CGSize(width: 100, height: -100)
                bubble3Offset = CGSize(width: 100, height: 100)
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                isActive = true
            }
        }
        .background(
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
