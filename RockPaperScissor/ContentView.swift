//
//  ContentView.swift
//  RockPaperScissor
//
//  Created by Md. Shoibur Rahman Khan Sifat on 10/1/24.
//

import SwiftUI

struct ContentView: View {
    @State private var options: [String] = ["👊", "✋", "✌️"].shuffled()
    @State private var selectedByComputer: Int = Int.random(in: 0...2)
    @State private var winOrLose: Bool = Bool.random()
    @State private var score: Int = 0
    @State private var gameStart : Bool = false
    @State private var alertShowing: Bool = false
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @State private var remainingTime: Int = 30
    
    
    
    var body: some View {
        VStack {
            Spacer()
            Text("Brain Training")
                .font(.system(size: 48).bold())
            Spacer()
            Button{
                startGame()
            }label: {
                Text(gameStart ? "Remain \(remainingTime) seconds" : "Start Game")
                    .foregroundColor(remainingTime <= 10 ? .red : .blue)
            }
            Text("\(options[selectedByComputer])")
                .font(.system(size: 200))
            Text("Which one \(winOrLose ? "wins" : "loses")?")
                .font(.system(size: 32))
            HStack{
                ForEach(0..<3){number in
                    Button{
                        tap(number)
                        
                    }label: {
                        Text(options[number])
                            .font(.system(size: 80))
                    }
                }
            }
            Spacer()
            Text("Score: \(score)")
            Spacer()
        }
        .onReceive(timer){_ in
            if gameStart && remainingTime > 0{
                remainingTime -= 1
            }else if remainingTime == 0{
                gameStart = false
                alertShowing = true
            }
        }
        .alert(isPresented: $alertShowing){
            Alert(title: Text("Time is up!"), message: Text("Your score is \(score)"),dismissButton: .default(Text("Reset")){
                resetGame()
            })
        }
    }
    func tap(_ number: Int){
        if result(options[selectedByComputer],winOrLose, options[number]){
            score += 1
            continueGame()
        }else{
            score -= 1
            continueGame()
        }
    }
    func result(_ selectedByApp: String, _ winOrLose: Bool,_ selectedByUser: String)->Bool{
        switch (selectedByApp,winOrLose,selectedByUser) {
        case ("👊",true,"👊"):
            return false
        case ("👊", false,"👊"):
            return true
        case ("👊", true,"✋"):
            return true
        case ("👊",false,"✋"):
            return false
        case ("👊", true,"✌️"):
            return false
        case ("👊", false,"✌️"):
            return true
            
        case ("✋",true,"👊"):
            return false
        case ("✋", false,"👊"):
            return true
        case ("✋", true,"✋"):
            return false
        case ("✋",false,"✋"):
            return true
        case ("✋", true,"✌️"):
            return true
        case ("✋", false,"✌️"):
            return false
            
        case ("✌️",true,"👊"):
            return true
        case ("✌️", false,"👊"):
            return false
        case ("✌️", true,"✋"):
            return false
        case ("✌️",false,"✋"):
            return true
        case ("✌️", true,"✌️"):
            return false
        case ("✌️", false,"✌️"):
            return true
        default:
            return false
        }
    }
    func startGame(){
        gameStart = true
        options = options.shuffled()
        selectedByComputer = Int.random(in: 0..<3)
        winOrLose = Bool.random()
        score = 0
    }
    func continueGame(){
        options = options.shuffled()
        selectedByComputer = Int.random(in: 0..<3)
        winOrLose = Bool.random()
    }
    func resetGame(){
        gameStart = false
        remainingTime = 30
        options = options.shuffled()
        selectedByComputer = Int.random(in: 0..<3)
        winOrLose = Bool.random()
        score = 0
    }
    
}

//#Preview {
//    ContentView()
//}
