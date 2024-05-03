//
//  GameData.swift
//  TelePort
//
//  Created by Sepehr Rafiei on 5/1/24.
//

import Foundation
import SwiftData

@Model
class GameData {
    var X : Int
    var Y : Int
    var x : Int
    var y : Int

    init(X: Int, Y: Int, x: Int, y: Int) {
        self.X = X
        self.Y = Y
        self.x = x
        self.y = y
    }
}
