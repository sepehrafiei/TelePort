//
//  RuleView.swift
//  TelePort
//
//  Created by Sepehr Rafiei on 5/2/24.
//

import SwiftUI

struct RuleView: View {
    var rules = [
        "The player who starts the game can make their move in any of the smaller tic-tac-toe boards.",
        "After the first move, the location of the previous player's move determines which smaller tic-tac-toe board the next player can play in.",
        "If a player is directed to a completed smaller tic-tac-toe board, they have the option to make their move in any available smaller board.",
        "When a player wins a smaller tic-tac-toe board, they claim that space on the larger tic-tac-toe board.",
        "The player who wins the larger tic-tac-toe board wins the game."
    ]
    
    var body: some View {
        ZStack {
            Color(red: 13/255, green: 13/255, blue: 13/255)
                .edgesIgnoringSafeArea(.all)
            VStack{
                Text("TelePort Rules")
                    .font(.largeTitle)
                    .bold()
                    .foregroundColor(.yellow)
                    .padding(30)

                ForEach(rules, id: \.self) { rule in
                    HStack {
                        Text(rule)
                            .font(.system(size: 20))
                            .italic()
                            .foregroundColor(.white)
                            .padding(18)
                        Spacer()
                    }
                }
                
                Spacer()
                    
            }
        }
    }
}

#Preview {
    RuleView()
}
