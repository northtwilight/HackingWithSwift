//
//  AnotherContentView.swift
//  HWSSU-03-ViewsAndModifiers
//
//  Created by Massimo Savino on 2022-09-06.
//

import SwiftUI

struct AnotherContentView: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            .titleStyle()
        
        Color.blue
            .frame(width: 300, height: 200)
            .watermarked(with: "Hacking with Swift")
        
        Gridstack(rows: 4, columns: 4) {
            row, column in
            Text("R\(row) C\(column)")
        }
        
        Gridstack(rows: 5, columns: 5) { row, column in
            HStack {
                Image(systemName: "\(row * 5 + column).circle")
                Text("R\(row) C\(column)")
            }
        }
    }
}

struct AnotherContentView_Previews: PreviewProvider {
    static var previews: some View {
        AnotherContentView()
    }
}

extension View {
    func titleStyle() -> some View {
        modifier(Title())
    }
}
