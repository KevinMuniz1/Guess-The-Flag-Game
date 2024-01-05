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
                            Image(countries[number])
                                .clipShape(.buttonBorder)
                                .shadow(radius: 5)
                        }
                    }
                }.frame(maxWidth: .infinity)
                    .padding(.vertical, 20)
                    .background(.regularMaterial)
                    .clipShape(.rect(cornerRadius: 20))
                    .padding()
                Text("Score: ???")
                    .foregroundStyle(.white)
                    .font(.largeTitle.bold())
                Spacer()
                Spacer()
            }
            .alert(titleName, isPresented: $showScore){
                Button("Ok, Next Question", action: askQuestion)
            } message: {
                Text("Your score is ???")
            }
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
