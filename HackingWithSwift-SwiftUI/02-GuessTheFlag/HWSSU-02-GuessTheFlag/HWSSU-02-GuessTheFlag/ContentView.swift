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
        }
        /**
         
        VStack {
            HStack {
                Text("1").padding()
                Text("2").padding()
                Text("3").padding()
            }
            HStack {
                Text("4").padding()
                Text("5").padding()
                Text("6").padding()
            }
            HStack {
                Text("7").padding()
                Text("8").padding()
                Text("9").padding()
            }
        }
        
        */
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
