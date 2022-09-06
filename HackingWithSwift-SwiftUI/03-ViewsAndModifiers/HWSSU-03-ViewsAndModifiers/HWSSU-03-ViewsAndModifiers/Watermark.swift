//
//  Watermark.swift
//  HWSSU-03-ViewsAndModifiers
//
//  Created by Massimo Savino on 2022-09-06.
//

import Foundation
import SwiftUI

struct Watermark: ViewModifier {
    var text: String

    func body(content: Content) -> some View {
        ZStack(alignment: .bottomTrailing) {
            content
            Text(text)
                .font(.caption)
                .foregroundColor(.white)
                .padding(5)
                .background(.black)
        }
    }
}

extension View {
    func watermarked(with text: String) -> some View {
        modifier(Watermark(text: text))
    }
}
