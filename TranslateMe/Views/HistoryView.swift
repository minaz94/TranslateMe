//
//  HistoryView.swift
//  TranslateMe
//
//  Created by Mina on 4/2/24.
//

import SwiftUI
import FirebaseFirestore

struct HistoryView: View {
    
    @Environment(TranslationViewModel.self) var translationViewModel
    
    var body: some View {
        ZStack {

            Rectangle()
                .ignoresSafeArea()
                .foregroundStyle(.teal.gradient.opacity(0.3))
            ScrollView {
                ForEach(translationViewModel.history) { history in
                    HStack {
                        Text(history.date, style: .date)
                            .padding(.leading, 8)
                            .padding(.bottom, -8)
                     Spacer()
                    }
                    HStack {
                        Text(history.text)
                            .multilineTextAlignment(.leading)
                            .font(.custom("Avenir", size: 20))
                            .foregroundStyle(.black)
                            .padding()
                        Spacer()
                        Text("|")
                            .bold()
                        Spacer()
                        Text(history.translatedText)
                            .multilineTextAlignment(.trailing)
                            .font(.custom("Avenir", size: 20))
                            //.fontWeight(.medium)
                            .foregroundStyle(.blue)
                            .padding(.horizontal)

                    }
                    .background(
                        RoundedRectangle(cornerRadius: 8)
                            .foregroundStyle(.teal.opacity(0.1))
                    )
                    .padding(.bottom, 16)
                    .padding(.horizontal, 8)

                }
            }
            
        }
        .toolbar(content: {
            Button(action: {
                Task {
                    do {
                        
                        try await translationViewModel.deleteHistory()
                    } catch {
                        print(error.localizedDescription)
                    }
                }
            }, label: {
                Text("Delete")
                    .foregroundStyle(.orange)
                    .fontWeight(.semibold)
            })
        })
        .navigationTitle("History")
    }
}

#Preview {
    HistoryView()
        .environment(TranslationViewModel())
}
