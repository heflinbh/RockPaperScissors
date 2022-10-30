//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Benjamin Heflin on 10/29/22.
//

import SwiftUI




struct ContentView: View {
    
    @State private var curAppMove = "Rock"
    @State private var shouldWin = false
    @State private var playerScore =  0
    @State private var showScoreAlert = false
    
    private let possibleMoves = ["Rock", "Paper", "Scissors"]
    private let winConditions = [("Rock", "Scissors"), ("Scissors", "Paper"), ("Paper", "Rock")]
    private let loseConditions = [("Scissors", "Rock"), ("Paper", "Scissors"), ("Rock", "Paper")]
    
    var body: some View {
        VStack (spacing: 30){
            Spacer()
            Text("Player Score: \(playerScore)")
            Text("App's Move: \(curAppMove)")
            Text(shouldWin ? "You should win" : "You should lose")
            Spacer()
            HStack {
                ForEach(possibleMoves, id: \.self) { playerMove in
                    Spacer()
                    Spacer()
                    Spacer()
                    Button {
                        respondToTap(playerMove: playerMove)
                    } label:{
                        Text(playerMove == "Rock" ? "🗿" : (playerMove == "Scissors" ? "✂️" : "📄"))
                            .font(.largeTitle)
                    }
                    .alert("Result", isPresented: $showScoreAlert) {
                        Button("OK", action: playAgain)
                    } message: {
                        Text(
                        """
                        Your score is now \(playerScore)
                        """)
                    }
                    Spacer()
                    Spacer()
                    Spacer()
                }
                
            }
            Spacer()
        }
        .padding()
    }
    
    func getRandomMove() -> String {
        possibleMoves[Int.random(in: 0...2)]
    }
    
    func respondToTap(playerMove: String) {
        let correctWin = shouldWin && winConditions.contains(where: {$0 == (playerMove, curAppMove)})
        let correctLose = !shouldWin && loseConditions.contains(where: {$0 == (playerMove, curAppMove)})
        
        if correctWin || correctLose {
            playerScore += 1
        }
        else {
            playerScore -= 1
        }
        showScoreAlert = true
    }
    
    func playAgain() {
        curAppMove = getRandomMove()
        shouldWin.toggle()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}



