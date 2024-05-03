//
//  GameLogic.swift
//  TelePort
//
//  Created by Sepehr Rafiei on 4/22/24.
//

import Foundation
import SwiftUI
import SwiftData

class GameLogic: ObservableObject
{
    @Published var gameStarted = false
    @Published var gameOver = false
    @Published var winner = Tile.Empty
    
    @Published var board = [[Any]]()
    @Published var turn = Tile.X
    
    @Published var X_score : [Int] = []
    @Published var O_score :  [Int] = []
    
    @Published var magicSquare = [[2,7,6],[9,5,1],[4,3,8]]
    @Published var count = 0
    @ObservationIgnored let dataSource: ItemDataSource
    var data : [GameData] = []


    
    init(dataSource: ItemDataSource = ItemDataSource.shared) {
        print("inside init")
        self.dataSource = dataSource
        data = dataSource.fetchItems()
        resetBoard()
    }
    
    func loadGame() {
        print("in load")
        setup()
    }
    
    func showResume() -> Bool{
        return !dataSource.fetchItems().isEmpty
    }
    
    func newGame() {
        print("In newGame")
        dataSource.deleteAll()
        resetBoard()
    }
    
    func setup() {
        for move in data {
            replay(move: move)
        }
    }
    
    func replay(move : GameData) {
        if let m = board[move.X][move.Y] as? MiniBoard {
            m.gameLogic.placeTile(move.x, move.y)
        }
    }
    
//    func saveBoard() {
//        let data = GameData(gameStarted: self.gameStarted, gaveOver: self.gameOver, winner: self.winner, board: nil, main_board: self.board, turn: self.turn, locked:nil, X_score: self.X_score, O_score: self.O_score, main_row: nil, main_column: nil, count: self.count)
//        context.insert(data)
//        try! context.save()
//    }
    
    func displayBoard(_ row: Int, _ column : Int) -> AnyView {
        let target = board[row][column]

        if let m = target as? MiniBoard {
            return AnyView(m)
        }
        else if let m = target as? ModifiedContent<ModifiedContent<ModifiedContent<Text, _FrameLayout>, _AspectRatioLayout>, _PaddingLayout> {
            return AnyView(m)
                
        }
        return AnyView(Text(""))
    }
    
    func lockAll() {
        for row in board {
            for mini in row {
                if let m = mini as? MiniBoard {
                    m.gameLogic.locked = true
                }
            }
        }
    }
    
    func unLockAll() {
        for row in board {
            for mini in row {
                if let m = mini as? MiniBoard {
                    m.gameLogic.locked = false
                }
            }
        }
    }
    
    func resetBoard() {
        turn = Tile.X
        gameStarted = false
        gameOver = false
        X_score = []
        O_score = []
        var newBoard = [[Any]]()
        for r in 0...2{
            var row = [Any]()
            for c in 0...2{
                if c == 4{
                    row.append(
                        Text("X")
                            .font(.system(size: 100))
                        .bold()
                        .foregroundColor(.white)
                        .frame(width: 117, height: 117)
                        .aspectRatio(1, contentMode: .fit)
                        .padding(5)
                        
                    )
                }
                else{
                    row.append(MiniBoard(masterLogic: self, main_row: r, main_column: c)
                        //.background(Color.white)
                    )
                }
            }
            newBoard.append(row)
        }
        board = newBoard
    }
    
}


