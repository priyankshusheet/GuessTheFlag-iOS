//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Priyankshu Sheet on 10/07/24.
//

import SwiftUI
import AVFoundation

struct ContentView: View {
    @State private var countries = ["Estonia", "France", "Germany", "India", "Ireland", "Italy", "Nigeria", "Poland", "Spain", "UK", "Ukraine", "US"]
    @State private var correctAnswer = Int.random(in: 0...2)
    
    @State private var showingScore = false
    @State private var scoreTitle = ""
    
    @State private var score = 0
    @State private var rotationAmount = 0.0
    @State private var opacityAmount = 1.0
    
    var body: some View {
        ZStack {
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3)
            ], center: .top, startRadius: 200, endRadius: 700)
            .ignoresSafeArea()
            
            VStack {
                Text ("Guess The Flag")
                    .font(.largeTitle.bold())
                    .foregroundStyle(Color (red: 255/255, green: 253/255, blue: 208/255))
                
                VStack(spacing: 30) {
                    VStack {
                        Text ("Tap the Flag of")
                            .foregroundStyle(.white)
                            .font(.headline.weight(.heavy))
                        Text(countries[correctAnswer])
                            .foregroundStyle(.white)
                            .font(.largeTitle.weight(.semibold))
                    }
                    ForEach(0..<3) { number in
                        Button {
                            withAnimation {
                                flagTapped(number)
                            }
                        } label: {
                            Image (countries[number])
                                .clipShape(.capsule)
                                .shadow(radius: 10)
                                .rotation3DEffect(.degrees(rotationAmount), axis: (x: 0.0, y: 1.0, z: 0.0)
                                )
                                .opacity(opacityAmount)
                                .animation(.easeInOut(duration: 0.5), value: rotationAmount)
                                .animation(.easeInOut(duration: 0.5), value: opacityAmount)
                        }
                    }
                    Text ("Score: \(score)")
                        .font(.title.bold())
                        .foregroundStyle(Color (red: 255/255, green: 253/255, blue: 208/255))
                        .padding()
                        .background(Color.black.opacity(0.55))
                        .clipShape(.capsule)
                }
                .padding()
            }
        }
        .alert(scoreTitle, isPresented: $showingScore) {
            Button ("Continue", action: askQuestion)
        } message: {
            Text ("Your Score is \(score)")
        }
    }
    func flagTapped (_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Correct"
            score += 1
            withAnimation {
                rotationAmount += 360
                opacityAmount = 1.0
            }
        }
        else {
            scoreTitle = "Wrong! That's the Flag of \(countries[number])"
            score -= 1
            withAnimation {
                opacityAmount = 0.25
            }
        }
        showingScore = true
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        opacityAmount = 1.0
    }
}


#Preview {
    ContentView()
}
