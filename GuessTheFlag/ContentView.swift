//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Kevin Muniz on 1/4/24.
//

import SwiftUI

struct ContentView: View {
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Spain", "UK", "Ukraine", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    @State var titleName = ""
    @State private var showScore = false
    var body: some View {
        ZStack{
            Color.indigo
                .ignoresSafeArea()
            VStack(spacing: 30) {
                VStack {
                    Text("Tap the flag of")
                        .foregroundStyle(.white)
                        .font(.largeTitle)
                    
                    Text(countries[correctAnswer])
                        .font(.title)
                        .foregroundStyle(.white)
                }
                
                ForEach(0..<3){ number in
                    Button {
                        displayTitleAndCheckAnswer(number)
                    } label: {
                        Image(countries[number])
                    }
                }
            }
        }.alert(titleName, isPresented: $showScore){
            Button("Ok, Next Question", action: askQuestion)
        } message: {
            Text("Your score is ???")
        }
    }
    func displayTitleAndCheckAnswer(_ number: Int){
        if number == correctAnswer{
            titleName = "Correct"
            showScore = true
        } else {
            titleName = "Wrong"
            showScore = true
        }
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
}

#Preview {
    ContentView()
}
