//
//  Menu.swift
//  TelePort
//
//  Created by Sepehr Rafiei on 4/22/24.
//

import SwiftUI

struct Menu: View {
    @State var showResume = true
    var game = GameView()
    var body: some View {
            NavigationView {
                ZStack {
                    Color(red: 13/255, green: 13/255, blue: 13/255)
                        .edgesIgnoringSafeArea(.all)
                    VStack{
                        
                        Image("tplogo")
                            .resizable()
                            .scaledToFit()
                            .padding(100)
                            .onAppear{
                                showResume = game.gameLogic.showResume()
                                print(showResume)
                            }
                        Spacer()
                        NavigationLink(destination: RuleView()) {
                            Text("Rules")
                                .frame(width: 200, height: 20)
                                .font(.title)
                                .bold()
                                .foregroundColor(.white)
                                .padding(25)
                                .background(Color.clear) // Transparent background
                                .cornerRadius(10) // Rounded corners
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10) // Overlay a rounded rectangle
                                        .stroke(Color.white, lineWidth: 4) // White border
                                )
                                
                        }
                        .padding()
                        if showResume {
                            NavigationLink(destination: game.onAppear { game.gameLogic.loadGame() }) {
                                Text("Resume")
                                    .frame(width: 200, height: 20)
                                    .font(.title)
                                    .bold()
                                    .foregroundColor(.white)
                                    .padding(25)
                                    .background(Color.clear) // Transparent background
                                    .cornerRadius(10) // Rounded corners
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 10) // Overlay a rounded rectangle
                                            .stroke(Color.white, lineWidth: 4) // White border
                                    )
                                
                            }
                        }
                        //.padding()
                        
                        
                        NavigationLink(destination: game.onAppear { game.gameLogic.newGame() }) {
                            Text("New Game")
                                .frame(width: 200, height: 20)
                                .font(.title)
                                .bold()
                                .foregroundColor(.yellow)
                                .padding(25)
                                .background(Color.clear) // Transparent background
                                .cornerRadius(10) // Rounded corners
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10) // Overlay a rounded rectangle
                                        .stroke(Color.white, lineWidth: 4) // White border
                                )
                                
                        }
                        .padding()
                        Spacer()
                    }
                }
            }
        }
}

#Preview {
    Menu()
}
