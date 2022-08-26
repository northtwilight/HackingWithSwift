//
//  ContentView.swift
//  HWSSU-02-GuessTheFlag
//
//  Created by Massimo Savino on 2022-08-24.
//

import SwiftUI

struct ContentView: View {
    private struct Constants {
        static let estonia = "Estonia"
        static let france = "France"
        static let germany = "Germany"
        static let ireland = "Ireland"
        static let italy = "Italy"
        static let nigeria = "Nigeria"
        static let poland = "Poland"
        static let russia = "Russia"
        static let spain = "Spain"
        static let uk = "UK"
        static let us = "US"
        
        // flags and scoring
        static let tapTheFlagOf = "Tap the flag of"
        static let correctScoreTitle = "Correct"
        static let incorrectScoreTitle = "Incorrect"
        
        // flow control
        static let continueQuestionHeader = "Continue"
        
        // radial stops
        static let start = CGFloat(200)
        static let end = CGFloat(700)
        
        // screenTitle
        static let screenTitle = "Guess the Flag"
        static let scorePlaceholder = "Score: ???"
        
        static func display(score: Int) -> String {
            "Score: \(score)"
        }
        
        static func displayIncorrectAnswer(wrongAnswer: String) -> String {
            "Wrong! That's the flag of \(wrongAnswer)"
        }
        
        static func displayCurrent(round: Int) -> String {
            "Current Round: \(round)"
        }
        
        static let maxRound = 8
        static let lastRoundTitle = "Last round"
        static let lastRoundMessage = "Round number will reset"
    }
    
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var score = 0
    
    @State private var currentRound = 0
    @State private var showEndOfGameAlert = false
    
    @State private var countries: [String] = [
        Constants.estonia,
        Constants.france,
        Constants.germany,
        Constants.ireland,
        Constants.italy,
        Constants.nigeria,
        Constants.poland,
        Constants.russia,
        Constants.spain,
        Constants.uk,
        Constants.us
    ].shuffled()
    
    @State private var correctAnswer = Int.random(in: 0...2)
    
    @State private var messageText = ""
    var buttonRange: Range<Int> = 0..<3
    
    var body: some View {
        ZStack {
            RadialGradient(
                stops: [
                    .init(color: Color(
                        red: 0.1,
                        green: 0.2,
                        blue: 0.45), location: 0.3),
                    .init(color: Color(
                        red: 0.76,
                        green: 0.15,
                        blue: 0.26), location: 0.3)
                ],
                center: .top,
                startRadius: Constants.start,
                endRadius: Constants.end)
            .ignoresSafeArea()
            
            VStack {
                Spacer()

                Text(Constants.screenTitle)
                    .font(.title.bold())
                    .foregroundColor(.white)
                
                VStack(spacing: 15) {
                    Spacer()
                    
                    Text(Constants.tapTheFlagOf)
                        .foregroundStyle(.secondary)
                        .font(.subheadline.weight(.heavy))
                    
                    Text(countries[correctAnswer])
                        .font(.largeTitle.weight(.semibold))
                    
                    ForEach(buttonRange) { number in
                        Button {
                            flagTapped(number)
                        } label: {
                            Image(countries[number])
                                .renderingMode(.original)
                                .clipShape(Capsule())
                                .shadow(radius: 5)
                        }
                    }
                    Spacer()
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.regularMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                
                Spacer()
                Text(Constants.displayCurrent(round: currentRound))
                    .foregroundColor(.yellow)
                    .font(.subheadline.bold())
                Spacer()
                Text(Constants.display(score: score))
                    .foregroundColor(.white)
                    .font(.title.bold())
                
                Spacer()
            }
        }
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("Continue", action: askQuestion)
        } message: {
            Text(messageText)
        }
        
        .alert(Constants.lastRoundTitle, isPresented: $showEndOfGameAlert) {
            Button("Restart Game?", action: restart)
        } message: {
            Text("This is the final round")
        }
    }
    
    func flagTapped(_ number: Int) {
        currentRound += 1
        
        if currentRound < 8 {
            if number == correctAnswer {
                scoreTitle = Constants.correctScoreTitle
                score += 1
                messageText = ""
            } else {
                scoreTitle = Constants.incorrectScoreTitle
                messageText = Constants.displayIncorrectAnswer(wrongAnswer: countries[number])
                score -= 1
            }
            showingScore = true
            showEndOfGameAlert = false
        } else if currentRound == 8 {
            restart()
            return
        }
        
        
    }
    
    func askQuestion() {
        countries.shuffle()
        let deuce = 0...2
        correctAnswer = Int.random(in: deuce)
    }
    
    func restart() {
        score = 0
        currentRound = 0
        showEndOfGameAlert = true
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
