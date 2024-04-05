//
//  HelloBubble.swift
//  TranslateMe
//
//  Created by Mina on 4/2/24.
//

import SwiftUI

struct HelloBubble: View {
    
    @State var word: String
    var body: some View {
        ZStack {
            Image("cloud")
                .resizable()
                .frame(width: 100, height: 75)
            Text(word)
                .padding(.bottom, 5)
        }
    }
}

#Preview {
    HelloBubble( word: "Hello")
}
