//
//  MiniBoard.swift
//  TelePort
//
//  Created by Sepehr Rafiei on 4/22/24.
//

import SwiftUI

struct MiniBoard: View {
    @ObservedObject var gameLogic : MiniGameLogic
    var main_row : Int
    var main_column : Int
    
    init(masterLogic: GameLogic, main_row: Int, main_column:Int) {
        self.gameLogic = MiniGameLogic(masterLogic, main_row, main_column)
        self.main_row = main_row
        self.main_column = main_column
    }
    
    var body: some View {
        let borderSize = CGFloat(5)
        VStack{
            VStack(spacing: borderSize) {
                ForEach(0...2, id: \.self){
                    row in HStack(spacing: borderSize){
                        ForEach(0...2, id: \.self){
                            column in
                            let cell = gameLogic.board[row][column]
                            Text(cell.displayTile())
                                .font(.largeTitle)
                                .foregroundColor(cell.tileColor())
                                .frame(width: 27, height: 27) // Set width and height equal to make it square
                                .aspectRatio(1, contentMode: .fit)
                                .background(gameLogic.locked || !gameLogic.Logic.gameStarted ? Color(red: 13/255, green: 13/255, blue: 13/255): Color(red: 30/255, green: 30/255, blue: 30/255))
                                .onTapGesture {
                                    gameLogic.placeTile(row, column)
                                }
                        }
                    }
                }
            }.background(Color.white)
        }.padding(18)
            .background(gameLogic.locked || !gameLogic.Logic.gameStarted ? Color(red: 13/255, green: 13/255, blue: 13/255): Color(red: 30/255, green: 30/255, blue: 30/255))
    
    }
}

#Preview {
    MiniBoard(masterLogic: GameLogic(), main_row:1, main_column:1)
}
