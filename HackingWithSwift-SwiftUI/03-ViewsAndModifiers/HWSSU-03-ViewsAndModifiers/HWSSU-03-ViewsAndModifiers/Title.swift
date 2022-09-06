//
//  Title.swift
//  HWSSU-03-ViewsAndModifiers
//
//  Created by Massimo Savino on 2022-09-06.
//

import Foundation
import SwiftUI

struct Title: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .foregroundColor(.white)
            .padding()
            .background(.blue)
            .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}
