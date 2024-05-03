//
//  GameView.swift
//  TelePort
//
//  Created by Sepehr Rafiei on 4/23/24.
//

import SwiftUI
import SwiftData

struct GameView: View {
    @ObservedObject var gameLogic : GameLogic
    
    init() {
        gameLogic = GameLogic()
    }
    
    var body: some View {
        VStack{
            Spacer()
            if gameLogic.winner == Tile.Empty && gameLogic.gameOver {
                Text("Draw").foregroundColor(Color.white)
                    .font(.system(size: 50))
                    .bold()
            } else{
                HStack{
                    Text(gameLogic.gameOver ? "Winner: " : "Player: ").foregroundColor(Color.white)
                        .font(.system(size: 50))
                        .bold()
                    Text("\(gameLogic.turn)").foregroundColor(gameLogic.turn == Tile.X ? Color.white : Color.yellow)
                        .font(.system(size: 50))
                        .bold()
                }
               
            }
            Spacer()
            let borderSize = CGFloat(3)
            VStack {
                VStack(spacing: borderSize) {
                    ForEach(0..<3, id: \.self){
                        row in HStack(spacing: borderSize){
                            ForEach(0..<3, id: \.self){
                                column in gameLogic.displayBoard(row, column)
                                    .background(Color(red: 13/255, green: 13/255, blue: 13/255))
                            }
                        }
                    }
                }

                .background(Color.white)
                //.aspectRatio(1, contentMode: .fit)
            }
            
            Spacer()
            Spacer()
            
            if gameLogic.gameOver {
                Button(action: {gameLogic.newGame()}, label: {
                    Text("New Game")
                        .font(.title3)
                        .bold()
                })
                Spacer()
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(red: 13/255, green: 13/255, blue: 13/255))
        
        
    }
   
    
        

}


#Preview {
    GameView()
}
