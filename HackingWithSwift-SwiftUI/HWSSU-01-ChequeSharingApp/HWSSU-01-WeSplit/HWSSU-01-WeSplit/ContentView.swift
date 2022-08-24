//
//  ContentView.swift
//  HWSSU-01-WeSplit
//
//  Created by Massimo Savino on 2022-08-24.
//

import SwiftUI

struct ContentView: View {
    private struct Constants {
        static let reset = "Press this button to reset Tap Count to 0"
        static func provide(_ tapCount: Int) -> String {
            "Tap Count: \(tapCount)"
        }
    }
    @State private var tapCount = 0
    
    var body: some View {
        Button(Constants.provide(tapCount)) {
            self.tapCount += 1
        }
        .padding()
        
        Button(Constants.reset) {
            self.tapCount = 0
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
