
import SwiftUI

func generateRandomTile()->Bool {
    
    var tileAdded = false
    while(!tileAdded){
        let randomRow = Int.random(in: 0..<4)
        let randomColumn = Int.random(in: 0..<4)
        if(Board.gameBoard[randomRow][randomColumn] == 0){
            Board.gameBoard[randomRow][randomColumn] = [2, 4].randomElement()!
            tileAdded = true
        }
    }
    return tileAdded
}

func moveUp() -> Int {
    var value = 0
    for column in 0..<Board.gameBoard.count {
        var mergeOccurred = false
        var mergeValue = 0
        
        for row in 1..<Board.gameBoard.count {
            let currentTile = Board.gameBoard[row][column]
            
            if currentTile == 0 {
                continue
            }
            var targetRow = row - 1
            
            while targetRow >= 0 && Board.gameBoard[targetRow][column] == 0 {
                Board.gameBoard[targetRow][column] = currentTile
                Board.gameBoard[targetRow + 1][column] = 0
                targetRow -= 1
            }
            
            if targetRow >= 0 && Board.gameBoard[targetRow][column] == currentTile && !mergeOccurred && mergeValue != currentTile {
                value = mergeTilesUp(row: targetRow, column: column)
                mergeOccurred = true
                Board.gameBoard[row][column] = 0
                mergeValue = currentTile
            }
        }
    }
    return value
}

func mergeTilesUp(row: Int, column: Int) -> Int {
    let value = Board.gameBoard[row][column]
    Board.gameBoard[row][column] *= 2
    if(row != 3){
        Board.gameBoard[row+1][column] = 0
    }
    return value*2
}


func moveDown() -> Int {
    var value = 0
    for column in 0..<Board.gameBoard.count {
        var mergeOccurred = false
        var mergeValue = 0

        for row in (0..<Board.gameBoard.count-1).reversed() {
            let currentTile = Board.gameBoard[row][column]

            if currentTile == 0 {
                continue
            }

            var targetRow = row + 1

            while targetRow < Board.gameBoard.count && Board.gameBoard[targetRow][column] == 0 {
                Board.gameBoard[targetRow][column] = currentTile
                Board.gameBoard[targetRow - 1][column] = 0
                targetRow += 1
            }
            
            if targetRow < Board.gameBoard.count && Board.gameBoard[targetRow][column] == currentTile && !mergeOccurred && mergeValue != currentTile {
                value = mergeTilesDown(row: targetRow, column: column)
                mergeOccurred = true
                mergeValue = currentTile
            }
        }
    }
    return value
}


func mergeTilesDown(row: Int, column: Int) -> Int {
    let value = Board.gameBoard[row][column]
    Board.gameBoard[row][column] *= 2
    if(row != 0){
        Board.gameBoard[row-1][column] = 0
    }
    return value*2
}

func moveLeft() -> Int {
    var value = 0
    for row in 0..<Board.gameBoard.count {
        var mergeOccurred = false
        var mergeValue = 0

        for column in 1..<Board.gameBoard[row].count {
            let currentTile = Board.gameBoard[row][column]

            if currentTile == 0 {
                continue
            }

            var targetColumn = column - 1

            while targetColumn >= 0 && Board.gameBoard[row][targetColumn] == 0 {
                Board.gameBoard[row][targetColumn] = currentTile
                Board.gameBoard[row][targetColumn + 1] = 0
                targetColumn -= 1
            }

            if targetColumn >= 0 && Board.gameBoard[row][targetColumn] == currentTile && !mergeOccurred && mergeValue != currentTile {
                value = mergeTilesLeft(row: row, column: targetColumn)
                mergeOccurred = true
                mergeValue = currentTile
            }
        }
    }
    return value
}

func mergeTilesLeft(row: Int, column: Int) -> Int {
    let value = Board.gameBoard[row][column]
    Board.gameBoard[row][column] *= 2
    if(column != 3){
        Board.gameBoard[row][column + 1] = 0
    }
    return value*2
}

func moveRight() -> Int {
    var value = 0
    for row in 0 ..< Board.gameBoard.count {
        var mergeOccurred = false
        var mergeValue = 0

        for column in (0 ..< Board.gameBoard[row].count-1).reversed() {
            let currentTile =  Board.gameBoard[row][column]

            if currentTile == 0 {
                continue
            }

            var targetColumn = column + 1

            while targetColumn <  Board.gameBoard[row].count &&  Board.gameBoard[row][targetColumn] == 0 {
                Board.gameBoard[row][targetColumn] = currentTile
                Board.gameBoard[row][targetColumn - 1] = 0
                targetColumn += 1
            }

            if targetColumn <  Board.gameBoard[row].count &&  Board.gameBoard[row][targetColumn] == currentTile && !mergeOccurred && mergeValue != currentTile {
                value = mergeTilesRight(row: row, column: targetColumn)
                mergeOccurred = true
                mergeValue = currentTile
            }
        }
    }
    return value
}

func mergeTilesRight(row: Int, column: Int) -> Int {
    let value = Board.gameBoard[row][column]
    Board.gameBoard[row][column] *= 2
    if(column != 0){
        Board.gameBoard[row][column-1] = 0
    }
    return value*2
}

func chooseColor(value: Int) -> Color {
    switch value {
    case 0:
        return Color.white
    case 2:
        return Color.orange
    case 4:
        return Color.pink
    case 8:
        return Color(.red)
    case 16:
        return Color(.purple)
    case 32:
        return Color(.blue)
    case 64:
        return Color(.cyan)
    case 128:
        return Color(.green)
    default:
        return Color(.gray)
    }
}
