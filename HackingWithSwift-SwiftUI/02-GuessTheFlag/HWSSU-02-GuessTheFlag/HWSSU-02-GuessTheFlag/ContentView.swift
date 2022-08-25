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
    }
    
    @State private var showingScore = false
    @State private var scoreTitle = ""
    
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
    
    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(
                    colors: [.blue, .black]),
                    startPoint: .top,
                    endPoint: .bottom)
            .ignoresSafeArea()
            
            VStack(spacing: 15) {
                Spacer()
                
                Text(Constants.tapTheFlagOf)
                    .foregroundColor(.white)
                    .font(.subheadline.weight(.heavy))
                
                Text(countries[correctAnswer])
                    .foregroundColor(.white)
                    .font(.largeTitle.weight(.semibold))
                
                var buttonRange: Range<Int> = 0..<3
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
        }
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("Continue", action: askQuestion)
        } message: {
            Text("Your score is what again??")
        }
    }
    
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = Constants.correctScoreTitle
        } else {
            scoreTitle = Constants.incorrectScoreTitle
        }
        showingScore = true
    }
    
    func askQuestion() {
        countries.shuffle()
        let deuce = 0...2
        correctAnswer = Int.random(in: deuce)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
