//
//  ContentView.swift
//  HWSSU-02-GuessTheFlag
//
//  Created by Massimo Savino on 2022-08-24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                Color.red
                Color.blue
            }
            Text("Your content")
                .foregroundColor(.secondary)
                .padding(50)
                .background(.ultraThinMaterial)
        }.ignoresSafeArea()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
