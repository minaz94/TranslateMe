//
//  TranslateView.swift
//  TranslateMe
//
//  Created by Mina on 4/2/24.
//

import SwiftUI

struct TranslateView: View {
    
    @Environment(AuthViewModel.self) var authviewModel
    @Environment(TranslationViewModel.self) var translationViewModel
    @Environment(\.dismiss) var dismiss
    
    @FocusState var isKeybaordShowing: Bool
    
    @State private var text = ""
    @State private var translatedText = ""
    @State private var isNavigating = false
    
    @State private var inputLanguage = ""
    @State private var outputLanguage = ""
    @State private var showAlert = false
    @State private var placeholder = "Text here"
    
    var body: some View {
        ZStack {
            
            Rectangle()
                .ignoresSafeArea()
                .foregroundStyle(.teal.gradient.opacity(0.3))
            VStack {
                HStack {
                    Button(action: {
                        Task {
                            do {
                                try await authviewModel.logOut()
                                dismiss()
                            } catch {
                                print(error.localizedDescription)
                            }
                            
                        }
                    }, label: {
                        Text("Log out")
                            .font(.custom("Avenir", size: 20))
                            .foregroundStyle(.black)
                            .fontWeight(.bold)
                    })
                    Spacer()
                    Button(action: {
                        Task {
                            do {
                                try await translationViewModel.fetchHistory()
                                
                            } catch {
                                print(error.localizedDescription)
                            }
                        }
                        placeholder = "Text here"
                        text = ""
                        translatedText = ""
                        inputLanguage = ""
                        outputLanguage = ""
                        translationViewModel.inputLanguage = ""
                        translationViewModel.outputLanguage = ""
                        isNavigating = true
                    }, label: {
                        Text("History")
                            .font(.custom("Avenir", size: 20))
                            .foregroundStyle(.black)
                            .fontWeight(.bold)
                    })
                }
                .padding(.horizontal, 17)
                VStack {
                    ZStack {
                        TextEditor(text: $text)
                            .onTapGesture {
                                placeholder = ""
                            }
                            .focused($isKeybaordShowing)
                            .clipShape(RoundedRectangle(cornerRadius: 15))
                            .padding()
                            .textEditorStyle(.automatic)
                        Text(placeholder)
                            .font(.custom("Avenir", size: 20))
                    }
                    
                    HStack {
                        VStack {
                            Menu {
                                ForEach(Languages.allCases) { language in
                                    Button(action: {
                                        translationViewModel.inputLanguage = language.rawValue
                                        inputLanguage = language.name
                                    }, label: {
                                        Text(language.name)
                                        
                                    })
                                }
                            } label: {
                                Label(
                                    title: {
                                        Text("Pick Language")
                                            .font(.custom("Avenir", size: 17))
                                        
                                    },
                                    icon: { Image(systemName: "chevron.down") }
                                )
                                .foregroundStyle(.black)
                                .bold()
                            }
                            Text(inputLanguage)
                        }
                        Image(systemName: "arrow.forward.circle")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 20)
                            .bold()
                            .foregroundColor(.orange)
                        VStack {
                            Menu {
                                ForEach(Languages.allCases) { language in
                                    Button(action: {
                                        translationViewModel.outputLanguage = language.rawValue
                                        outputLanguage = language.name
                                    }, label: {
                                        Text(language.name)
                                        
                                    })
                                }
                            } label: {
                                Label(
                                    title: {
                                        Text("Pick Language")
                                            .font(.custom("Avenir", size: 17))
                                        
                                    },
                                    icon: { Image(systemName: "chevron.down") }
                                )
                                .foregroundStyle(.black)
                                .bold()
                            }
                            Text(outputLanguage)
                        }

                    }
                        

                    TextEditor(text: $translatedText)
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                        .disabled(true)
                        .padding()

                }
                Button(action: {
                    if inputLanguage == "" || outputLanguage == "" {
                        showAlert = true
                    }
                    translationViewModel.text = text
                    Task {
                        do {
                            translatedText = try await translationViewModel.translatedText() ?? "no translated text"
                        } catch {
                            print(error.localizedDescription)
                        }
                    }
                }, label: {
                    Text("Translate Me")
                        .font(.custom("Avenir", size: 20))
                        .bold()
                        .frame(width: 300)
                        .padding()
                        .background(.teal.gradient)
                        .foregroundStyle(.black.gradient)
                        .clipShape(.capsule)
                })
                .shadow(radius: 8)
                
            }
            .padding(.horizontal, 8)
            
        }.onTapGesture {
            isKeybaordShowing = false
        }
        .alert("Missing field", isPresented: $showAlert, actions: {
            Button("Ok", action: {})
        }, message: {
            Text("Pick a language first")
        })
        .navigationBarBackButtonHidden()
        .navigationDestination(isPresented: $isNavigating) {
            HistoryView()
        }
        
    }
}

#Preview {
    TranslateView()
        .environment(AuthViewModel())
        .environment(TranslationViewModel())
}
