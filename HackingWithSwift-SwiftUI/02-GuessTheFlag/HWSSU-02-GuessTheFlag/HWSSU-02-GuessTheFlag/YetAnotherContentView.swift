//
//  YetAnotherContentView.swift
//  HWSSU-02-GuessTheFlag
//
//  Created by Massimo Savino on 2022-08-24.
//

import Foundation
import SwiftUI

struct YetAnotherContentView: View {
    private struct Constants {
        static let deleteHeader = "Delete selection"
    }
    
    @State private var showingAlert = false
    
    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                AngularGradient(
                    gradient: Gradient(
                        colors: [
                            .red,
                            .yellow,
                            .green,
                            .blue,
                            .purple,
                            .red
                        ]),
                    center: .center)
            }
            
            VStack {
                Spacer()
                Text("Your content")
                    .foregroundColor(.secondary)
                    .padding(50)
                    .background(.ultraThinMaterial)
                Spacer()
                Button("Button 1") { }
                    .buttonStyle(.bordered)
                    .tint(.orange)
                Button("Button 2", role: .destructive) { }
                    .buttonStyle(.bordered).tint(.mint)
                Button("Button 3") { }
                    .buttonStyle(.borderedProminent)
                Button("Button 4", role: .destructive) { }
                    .buttonStyle(.borderedProminent)
                Button {
                    print("Button was tapped")
                } label: {
                    Text("Tap me!").padding().foregroundColor(.white).background(.green)
                }
                
                Spacer()
            }
        }.ignoresSafeArea()
        
        Button("Show Alert") {
            showingAlert = true
        }
        .alert("Important message", isPresented: $showingAlert) {
            Button("OK") { }
            Button("Delete", role: .destructive) { }
            Button("Cancel", role: .cancel) { }
        } message: {
            Text("Please read this...")
        }
    }
}
