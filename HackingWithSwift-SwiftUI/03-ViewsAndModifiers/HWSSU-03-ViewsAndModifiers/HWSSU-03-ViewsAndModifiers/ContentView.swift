//
//  ContentView.swift
//  HWSSU-03-ViewsAndModifiers
//
//  Created by Massimo Savino on 2022-09-05.
//

import SwiftUI

struct ContentView: View {
    private struct Constants {
        static let helloWorld = "Hello, world!"
        static let helloWorld2 = "Hello, world II!"
        static let twoHundred = CGFloat(200)
        static let gryffindor = "Gryffindor"
        static let hufflepuff = "Hufflepuff"
        static let ravenclaw = "Ravenclaw"
        static let slytherin = "Slytherin"
        static let motto1 = "Draco dormiens"
        static let motto2 = "nunquam titillandus"
    }
    
    @State private var useRedText = false
    
    var motto3: some View {
        Text("Bloody hell!!")
    }
    
    var spells: some View {
        VStack {
            Text("Lumos")
            Text("Obliviate")
        }
    }
    
    var altSpells: some View {
        Group {
            Text("Abracadabra")
                .foregroundColor(Color.indigo)
            Text("Alakazam")
                .foregroundColor(Color.mint)
            Text("Shazam")
                .foregroundColor(Color.accentColor)
        }
        .font(.largeTitle)
        .blur(radius: 2.3)
    }
    
    @ViewBuilder var anotherAltSpells: some View {
        Text("Zap")
            .foregroundColor(Color.orange)
        Text("al-ah-Zammzm")
            .foregroundColor(Color.pink)
        Text("ka-boom")
            .foregroundColor(Color.red)
    }
    
    var body: some View {
        Button(Constants.helloWorld2) {
            useRedText.toggle()
        }
        .foregroundColor(
            useRedText ? .red : .blue)
        
        VStack {
            Text(Constants.gryffindor)
                .font(.largeTitle)
                .blur(radius: 0)
                .tint(Color.blue)
            Text(Constants.hufflepuff)
            Text(Constants.ravenclaw)
            Text(Constants.slytherin)
        }
        .font(.title)
        .blur(radius: 4.3)
        
        
        let motto1 = Text(Constants.motto1)
        let motto2 = Text(Constants.motto2)
        
        VStack {
            motto1
                .foregroundColor(.red)
            motto2
                .foregroundColor(.blue)
            motto3
                .foregroundColor(.green)
        }.blur(radius: 2.5)
        
        spells
        altSpells
        anotherAltSpells
        
        VStack(spacing: 10) {
            CapsuleText(text: "First")
                .foregroundColor(.yellow)
            CapsuleText(text: "second")
                .foregroundColor(.orange)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
