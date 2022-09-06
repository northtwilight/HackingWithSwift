//
//  CapsuleText.swift
//  HWSSU-03-ViewsAndModifiers
//
//  Created by Massimo Savino on 2022-09-06.
//

import Foundation
import SwiftUI

struct CapsuleText: View {
    var text: String
    
    var body: some View {
        Text(text)
            .font(.largeTitle)
            .padding()
            .background(.blue)
            .clipShape(Capsule())
    }
}
