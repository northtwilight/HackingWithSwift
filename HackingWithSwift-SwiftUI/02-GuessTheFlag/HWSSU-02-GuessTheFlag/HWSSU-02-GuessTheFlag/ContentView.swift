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
//                LinearGradient(
//                    gradient: Gradient(
//                        stops: [
//                            Gradient.Stop(color: .white, location: 0.45),
//
//                            Gradient.Stop(color: .black, location: 0.55),
//                                ]),
//                    startPoint: .top,
//                    endPoint: .bottom)
                
//                RadialGradient(
//                    gradient: Gradient(colors: [.blue, .black]),
//                    center: .center,
//                    startRadius: 20,
//                    endRadius: 200)
                
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
