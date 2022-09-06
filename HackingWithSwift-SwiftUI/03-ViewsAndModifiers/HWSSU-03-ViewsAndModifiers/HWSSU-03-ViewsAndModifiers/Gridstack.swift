//
//  Gridstack.swift
//  HWSSU-03-ViewsAndModifiers
//
//  Created by Massimo Savino on 2022-09-06.
//

import Foundation
import SwiftUI

struct Gridstack<Content: View>: View {
    let rows: Int
    let columns: Int
    @ViewBuilder let content: (Int, Int) -> Content
    
    var body: some View {
        VStack {
            ForEach(0 ..< rows, id: \.self) { row in
                HStack {
                    ForEach(0 ..< columns, id: \.self) { column in
                        content(row, column)
                    }
                }
            }
        }
    }
}
