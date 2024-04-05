//
//  WelcomeView.swift
//  TranslateMe
//
//  Created by Mina on 4/2/24.
//

import SwiftUI
import FirebaseAuth

struct WelcomeView: View {
    
        
    @State var bubbleIndex: Int = 0
    
    @State var isNavigating: Bool = false
    
    var body: some View {
        ZStack {
            
            Rectangle()
                .ignoresSafeArea()
                .foregroundStyle(.teal.gradient.opacity(0.3))

            VStack {
                HelloBubble( word: "Hello")
                    .padding(.trailing, 300)
                    .padding(.top, 50)
                    .opacity(bubbleIndex > 8 ? 1 : 0)
                HelloBubble( word: "你好")
                    .padding(.leading, 300)
                    .opacity(bubbleIndex > 10 ? 1 : 0)
                HelloBubble( word: "Bonjour")
                    .opacity(bubbleIndex > 4 ? 1 : 0)
                HelloBubble( word: "Привет")
                    .padding(.trailing, 300)
                    .opacity(bubbleIndex > 2 ? 1 : 0)
                HelloBubble( word: "Γειά σου")
                    .padding(.leading, 200)
                    .opacity(bubbleIndex > 6 ? 1 : 0)
                Text("Translate Me")
                    .font(Font.custom("Avenir", size: 30))
                    .fontWeight(.semibold)
                HelloBubble( word: "Ciao")
                    .padding(.trailing, 200)
                    .opacity(bubbleIndex > 1 ? 1 : 0)
                HelloBubble( word: "Hallo")
                    .padding(.leading, 300)
                    .opacity(bubbleIndex > 5 ? 1 : 0)
                HelloBubble( word: "مرحبا")
                    .opacity(bubbleIndex > 3 ? 1 : 0)
                HelloBubble( word: "Hola")
                    .padding(.trailing, 300)
                    .opacity(bubbleIndex > 7 ? 1 : 0)
                HelloBubble( word: "नमस्ते")
                    .padding(.leading, 300)
                    .padding(.bottom, 70)
                    .opacity(bubbleIndex > 9 ? 1 : 0)
            }
            .navigationDestination(isPresented: $isNavigating, destination: {
                if Auth.auth().currentUser != nil {
                    TranslateView()
                } else {
                    AuthenticationView()
                }
            })
        }
        .onChange(of: bubbleIndex, {
            if bubbleIndex == 11 {
                isNavigating = true
            }
        })
        .onAppear {
            bubbleIndex = 0
            Timer.scheduledTimer(withTimeInterval: 0.3, repeats: true) { timer in
                withAnimation {
                    bubbleIndex += 1
                    if bubbleIndex == 11 {
                        timer.invalidate()
                    }
                }
            }
        }
    }
}

#Preview {
    WelcomeView()
}
