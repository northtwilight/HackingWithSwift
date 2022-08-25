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
        
        static let tapTheFlagOf = "Tap the flag of"
    }
    
    var countries: [String] = [
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
    ]
    var correctAnswer = Int.random(in: 0...2)
    
    var body: some View {
        ZStack {
            Color.blue.ignoresSafeArea()
            VStack(spacing: 20) {
                Text(Constants.tapTheFlagOf)
                    .foregroundColor(.white)
                Text(countries[correctAnswer])
                    .foregroundColor(.white)
            }
        }
        
        ForEach(0..<3) { number in
            Button {
                // flag was tapped
            } label: {
                Image(countries[number])
                    .renderingMode(.original)
            }
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
