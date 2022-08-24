//
//  ContentView.swift
//  HWSSU01-WeSplit
//
//  Created by Massimo Savino on 2022-08-24.
//

import SwiftUI

struct ContentView: View {
    private struct Constants {
        static let amount = "Amount"
        static let usd = "USD"
    }
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 20
    
    let tipPercentages = [10, 15, 20, 25, 0]
    
    var body: some View {
        Form {
            Section {
                TextField(
                    Constants.amount,
                    value: $checkAmount,
                    format: .currency(
                        code: Locale.current.currencyCode ?? Constants.usd))
                    .keyboardType(.decimalPad)
            }
            Section {
                Text(checkAmount, format: .currency(code: Locale.current.currencyCode ?? Constants.usd))
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
