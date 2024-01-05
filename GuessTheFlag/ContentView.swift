//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Kevin Muniz on 1/4/24.
//

import SwiftUI

struct ContentView: View {
    private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Spain", "UK", "Ukraine", "US"].shuffled()
    private var correctAnswer = Int.random(in: 0...2)
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
                        
                    } label: {
                        Image(countries[number])
                    }
                }
            }
        }
    }
    func checkAnswerAndDisplayTitle(_ number: Int){
        if number == correctAnswer{
            titleName = "Correct"
        } else {
            titleName = "Wrong"
        }
    }
    
    func showAlert()
}

#Preview {
    ContentView()
}
