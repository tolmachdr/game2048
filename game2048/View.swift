

import SwiftUI



struct GridView: View {
    let gridSize = 4
    let cellSize: CGFloat = 70.0
    let cellSpacing: CGFloat = 10.0
    let maxWidth: CGFloat = .infinity
    let maxHeight: CGFloat = .infinity
    
    @State private var counter = 0
    @State var score: Int = 0
    @State var highScore: Int = 0
    @State var gameContinues: Bool = true
    
    @State private var showAlert = false
    
    
    var body: some View {
        
        VStack{
            HStack {
                Text("2048")
                    .font(.system(size: 36, weight: .heavy, design: .rounded))
                    .foregroundColor(.white)
                    .frame(width: 120, height: 120)
                    .background(Color.orange)
                    .cornerRadius(4)
                VStack(alignment: .center) {
                    HStack {
                        VStack{
                            Spacer()
                            Text("Score")
                                .font(.system(size: 16, weight: .heavy, design: .rounded))
                                .foregroundColor(.black)
                            Text(score.description) // Use the observed score
                                .font(.system(size: 24, weight: .heavy, design: .rounded))
                                .foregroundColor(.black)
                        }
                        .frame(maxWidth: .infinity)
                        .padding(.horizontal, 16)
                        .padding(.vertical, 8)
                        .background(Color.yellow)
                        .cornerRadius(4)

                        VStack{
                            Spacer()
                            Text("Best")
                                .font(.system(size: 16, weight: .heavy, design: .rounded))
                                .foregroundColor(.black)
                            Text(highScore.description) // Use the observed score
                                .font(.system(size: 24, weight: .heavy, design: .rounded))
                                .foregroundColor(.black)
                        }
                        .frame(maxWidth: .infinity)
                        .padding(.horizontal, 16)
                        .padding(.vertical, 8)
                        .background(Color.yellow)
                        .cornerRadius(4)
                    }
                    .frame(maxWidth: .infinity)
                    
                    Button(action: {
                        score = 0
                        for i in 0..<4 {
                            for j in 0..<4 {
                                Board.gameBoard[i][j] = 0
                            }
                        }
                        _ = generateRandomTile()
                        _ = generateRandomTile()
                        counter += 1
                    }) {
                        Text("New Game")
                            .font(.system(size: 24, weight: .heavy, design: .rounded))
                            .foregroundColor(.black)
                            .frame(maxWidth: maxWidth, maxHeight: maxHeight)
                            .background(Color.red)
                            .cornerRadius(4)
                    }


                }
                .frame(height: 120)
            }
            .frame(width: 338)
            
            
            Spacer()
            
            VStack(spacing: cellSpacing) {
                
                
                ForEach(0..<gridSize, id: \.self) { row in
                    HStack(spacing: cellSpacing) {
                        ForEach(0..<gridSize, id: \.self) { column in
                            Rectangle()
                                .fill(chooseColor(value: Board.gameBoard[row][column]))
                                .frame(width: cellSize, height: cellSize)
                                .overlay(
                                    Text(String(Board.gameBoard[row][column]+counter-counter)).font(.system(size: 28)).foregroundColor(.white)
                                )
                        }
                    }
                }
                
                
            }
            .padding(cellSpacing)
            .background(Color.yellow)
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
            
            
        }
    }
}
