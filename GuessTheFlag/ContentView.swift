//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Kevin Muniz on 1/4/24.
//

import SwiftUI

struct FlagView: View {
    let name: String
    var body: some View {
        Image(name)
            .clipShape(.buttonBorder)
            .shadow(radius: 5)
    }
}

struct ContentView: View {
    @State var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Spain", "UK", "Ukraine", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    @State var titleName = ""
    @State private var showScore = false
    @State private var score = 0
    @State private var totalQuestionsAsked = 0
    @State private var finishedGame = false
    var body: some View {
        ZStack{
            LinearGradient(colors: [.indigo, .black], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            VStack{
                Spacer()
                Text("Guess the Flag")
                    .font(.largeTitle.bold())
                    .foregroundStyle(.white)

                VStack(spacing: 30) {
                    VStack {
                        Text("Tap the flag of")
                            .foregroundStyle(.secondary)
                            .font(.subheadline.weight(.heavy))
                        
                        Text(countries[correctAnswer])
                            .font(.largeTitle.weight(.semibold))
                    }
                    
                    ForEach(0..<3){ number in
                        Button {
                            displayTitleAndCheckAnswer(number)
                        } label: {
                            FlagView(name: countries[number])
                        }
                    }
                }.frame(maxWidth: .infinity)
                    .padding(.vertical, 20)
                    .background(.regularMaterial)
                    .clipShape(.rect(cornerRadius: 20))
                    .padding()
                Text("Score: \(score) / 8")
                    .foregroundStyle(.white)
                    .font(.largeTitle.bold())
                Spacer()
                Spacer()
            }

            .alert(titleName, isPresented: $showScore){
                Button("Ok, Next Question", action: askQuestion)
            } message: {
                Text("Your score is \(score) out of \(totalQuestionsAsked)")
            }
            .alert(titleName, isPresented: $finishedGame){
                Button("Restart", action: restart)
            } message: {
                Text("Your final score was \(score) / \(totalQuestionsAsked)")
            }
        }
    }
    func displayTitleAndCheckAnswer(_ number: Int){
            if number == correctAnswer{
                titleName = "Correct"
                score += 1
                totalQuestionsAsked += 1
                if totalQuestionsAsked == 8 {
                    titleName = "That was correct and you have finished the game"
                    finishedGame = true
                } else {
                    showScore = true
                }
            } else {
                titleName = "Wrong! That is the flag of \(countries[number])"
                totalQuestionsAsked += 1
                if totalQuestionsAsked == 8 {
                    titleName = "That was wrong and you have finished the game"
                    finishedGame = true
                } else {
                    showScore = true
                }
            }

    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
    
    func restart() {
        askQuestion()
        totalQuestionsAsked = 0
        score = 0
    }
    
}

#Preview {
    ContentView()
}
