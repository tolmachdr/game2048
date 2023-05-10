//
//  View.swift
//  game2048
//
//  Created by Rustem Orazbayev on 5/7/23.
//

import SwiftUI



struct GridView: View {
    let gridSize = 4
    let cellSize: CGFloat = 80.0
    let cellSpacing: CGFloat = 10.0
    
    @State private var counter = 0
    @State var score: Int = 0
    @State var highScore: Int = 0
    @State var gameContinues: Bool = true
    
    @State private var showAlert = false
    
    
    var body: some View {
        VStack{
            HStack{
                Spacer()
                Text("  High score:  \(highScore)  ")
                    .multilineTextAlignment(.center)
                    .foregroundColor(Color.white)
                    .font(.system(size: 24))
            }
            .padding(10)
            .background(Color.blue)
            
            
            HStack{
                Spacer()
                Text("Current score: \(score)")
                    .multilineTextAlignment(.center)
                    .foregroundColor(Color.white)
                    .font(.system(size: 24))
            }
            .padding(10)
            .background(Color.blue)
            
            Spacer()
            
            VStack(spacing: cellSpacing) {
                
                
                ForEach(0..<gridSize, id: \.self) { row in
                    HStack(spacing: cellSpacing) {
                        ForEach(0..<gridSize, id: \.self) { column in
                            Rectangle()
                                .fill(chooseColor(value: Board.gameBoard[row][column]))
                                .frame(width: cellSize, height: cellSize)
                                .overlay(
                                    Text(String(Board.gameBoard[row][column]+counter-counter)).font(.system(size: 28))
                                )
                        }
                    }
                }
                
                
            }
            .padding(cellSpacing)
            .background(Color.cyan)
            .gesture(
                DragGesture(minimumDistance: 50)
                    .onEnded {
                        if $0.translation.height < -100 {
                            score += moveUp()
                            counter+=1
                            gameContinues = generateRandomTile()
                            counter+=1
                        } else if $0.translation.height > 100 {
                            score += moveDown()
                            counter+=1
                            gameContinues = generateRandomTile()
                            counter+=1
                        } else if $0.translation.width < -100 {
                            score += moveLeft()
                            counter+=1
                            gameContinues = generateRandomTile()
                            counter+=1
                        } else if $0.translation.width > 100 {
                            score += moveRight()
                            counter+=1
                            gameContinues = generateRandomTile()
                            counter+=1
                        }
                        
                        if(score > highScore){
                            highScore = score
                        }
                        
                        
                        for i in 0..<4 {
                            for j in 0..<4 {
                                if Board.gameBoard[i][j] > 2047
                                {
                                    self.showAlert.toggle()
                                }
                            }
                        }
                        
                    }
            )
            .alert(isPresented: $showAlert) {
                return Alert(title: Text("You Won"), message: Text("Congratulations! your score \(score)"), dismissButton: .default(Text("Play again")))
            }
            
            
            Spacer()
            
            
            Button("New Game") {
                score = 0
                for i in 0..<4 {
                    for j in 0..<4 {
                        Board.gameBoard[i][j] = 0
                    }
                }
                _ = generateRandomTile()
                _ = generateRandomTile()
                counter+=1
            }
        }
    }
}
