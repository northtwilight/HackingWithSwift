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
        static let enterName = "Enter your name"
        static let helloWorld = "Hello, world"
        static let swiftUItext = "SwiftUI"
        static let harry = "Harry"
        static let hermione = "Hermione"
        static let ron = "Ron"
        static let selectYourStudent = "Select your student"
        
        static func provide(_ tapCount: Int) -> String {
            "Tap Count: \(tapCount)"
        }
        
        static func yourNameIs(_ name: String) -> String {
            "Your name is: \(name)"
        }
    }
    @State private var tapCount = 0
    @State private var name = ""
    @State private var selectedStudent = Constants.harry
    
    let students = [
        Constants.harry,
        Constants.hermione,
        Constants.ron
    ]
    
    var body: some View {
        NavigationView {
            Form {
                Picker(Constants.selectYourStudent, selection: $selectedStudent) {
                    ForEach(students, id: \.self) {
                        Text($0)
                    }
                }
                
                TextField(Constants.enterName, text: $name)
                
                Text(Constants.yourNameIs(name))
                
                Button(Constants.provide(tapCount)) {
                    self.tapCount += 1
                }
                .padding()
                
                Button(Constants.reset) {
                    self.tapCount = 0
                }
                .padding()
                
            }.navigationTitle(Constants.swiftUItext)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
