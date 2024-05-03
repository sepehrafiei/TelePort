//
//  Cell.swift
//  TelePort
//
//  Created by Sepehr Rafiei on 4/22/24.
//

import Foundation
import SwiftUI

struct Cell : Codable{
    var tile: Tile
    
    func displayTile() -> String {
        switch(tile){
        case Tile.O:
            return "O"
        case Tile.X:
            return "X"
        default:
            return ""
        }
    }
    
    func tileColor() -> Color {
        switch(tile){
        case Tile.O:
            return Color.yellow
        case Tile.X:
            return Color.white
        default:
            return Color.black
        }
    }
}


enum Tile : Codable
{
    case O
    case X
    case Empty
}
