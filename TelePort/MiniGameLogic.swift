//
//  GameLogic.swift
//  TelePort
//
//  Created by Sepehr Rafiei on 4/22/24.
//

import Foundation
import SwiftUI
class MiniGameLogic: ObservableObject
{
    @Published var gameOver = false
    @Published var winner = Tile.Empty
    
    @Published var Logic : GameLogic
    @Published var board = [[Cell]]()
    @Published var locked = false
    

    @Published var X_score : [Int] = []
    @Published var O_score :  [Int] = []

    @Published var main_row : Int
    @Published var main_column : Int

    
    @Published var magicSquare = [[2,7,6],[9,5,1],[4,3,8]]
    @Published var count = 0

    
    
    init(_ masterLogic: GameLogic, _ main_row : Int, _ main_column : Int) {
        Logic = masterLogic
        self.main_row = main_row
        self.main_column = main_column
        resetBoard()
    }
    
    
    func placeTile(_ row: Int, _ column: Int) {
        if !Logic.gameStarted{
            Logic.gameStarted = true
        }
        if(locked || gameOver || board[row][column].tile != Tile.Empty){
            return
        }
        count += 1
        board[row][column].tile = Logic.turn == Tile.X ? Tile.X : Tile.O
        if Logic.turn == Tile.X {
            X_score.append(magicSquare[row][column])
            gameOver = findTripletWithSum(arr: X_score)
            if gameOver {
                winner = Tile.X
            }
        } else {
            O_score.append(magicSquare[row][column])
            gameOver = findTripletWithSum(arr: O_score)
            if gameOver {
                winner = Tile.O
            }
        }
        if count == 9 {
            gameOver = true
        }
        if gameOver {
            Logic.count += 1
            if winner != Tile.Empty {
                Logic.board[main_row][main_column] =
                Text(winner == Tile.X ? "X" : "O")
                    .font(.system(size: 100))
                    .bold()
                    .foregroundColor(winner == Tile.X ? Color.white : Color.yellow)
                    .frame(width: 117, height: 117)
                    .aspectRatio(1, contentMode: .fit)
                    .padding(5)
            }
            
            if winner == Tile.X {
                Logic.X_score.append(Logic.magicSquare[main_row][main_column])
                Logic.gameOver = findTripletWithSum(arr: Logic.X_score)
                if Logic.gameOver {
                    Logic.winner = Tile.X
                }
            }
            else if winner == Tile.O{
                Logic.O_score.append(Logic.magicSquare[main_row][main_column])
                Logic.gameOver = findTripletWithSum(arr: Logic.O_score)
                if Logic.gameOver {
                    Logic.winner = Tile.O
                }
            }
            if Logic.count == 9 {
                Logic.gameOver = true
                Logic.lockAll()
            }
            if Logic.gameOver {
                Logic.turn = winner
                Logic.lockAll()
                return
            }
        }

        Logic.lockAll()
        let target = Logic.board[row][column]
        if let m = target as? MiniBoard {
            if m.gameLogic.gameOver {
                Logic.unLockAll()
            }
            else {
                m.gameLogic.locked = false
            }
        }else if let _ = target as? ModifiedContent<ModifiedContent<ModifiedContent<Text, _FrameLayout>, _AspectRatioLayout>, _PaddingLayout> {
            Logic.unLockAll()
                
        }
        Logic.turn = Logic.turn == Tile.X ? Tile.O : Tile.X
        
        let data = GameData(X: main_row, Y: main_column, x: row, y: column)
        Logic.dataSource.appendItem(data: data)
    }
    
    
    func resetBoard() {
        X_score = []
        O_score = []
        var newBoard = [[Cell]]()
        for _ in 0...2{
            var row = [Cell]()
            for _ in 0...2{
                row.append(Cell(tile: Tile.Empty))
            }
            newBoard.append(row)
        }
        board = newBoard
    }
    
    func findTripletWithSum(arr: [Int]) -> Bool {
        let targetSum = 15
        print(arr)
        guard arr.count >= 3 else {
            return false
        }
        
        let sortedArr = arr.sorted()
        let n = sortedArr.count

        for i in 0..<(n - 2) {
            if i > 0 && sortedArr[i] == sortedArr[i - 1] {
                continue // Skip duplicate elements
            }

            var left = i + 1
            var right = n - 1

            while left < right {
                let currentSum = sortedArr[i] + sortedArr[left] + sortedArr[right]
                if currentSum == targetSum {
                    return true
                } else if currentSum < targetSum {
                    left += 1
                    // Skip duplicates
                    while left < right && sortedArr[left] == sortedArr[left - 1] {
                        left += 1
                    }
                } else {
                    right -= 1
                    // Skip duplicates
                    while left < right && sortedArr[right] == sortedArr[right + 1] {
                        right -= 1
                    }
                }
            }
        }

        return false
    }
}
