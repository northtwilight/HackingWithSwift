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
        static let numberOfPeople = "Number of people"
        static let navTitle = "WeSplit"
        static let tipPercent = "Tip percentage"
        static let howMuchTip = "How much tip do you want to leave?"
        static let done = "Done"
        static let amtPerPerson = "Amount per person"
        static let grandTotalText = "Grand total, including tip"
        
        static func textNumberOfPeople(number: Int) -> String {
            "\(number) people"
        }
    }
    
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 20
    
    let tipPercentages = [10, 15, 20, 25, 0]
    
    var totalPerPerson: Double {
        // calculateTotalPerPerson()
        calculateTotalOrTotalPerPerson(showTotal: false)
    }
    
    @FocusState private var amountIsFocused: Bool
    
    var body: some View {
        NavigationView {
            Form {
                // section 1
                Section {
                    
                    TextField(
                        Constants.amount,
                        value: $checkAmount,
                        format: .currency(
                            code: Locale.current.currencyCode ?? Constants.usd))
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                    
                    Picker(Constants.numberOfPeople, selection: $numberOfPeople) {
                        ForEach(2 ..< 100) {
                            Text(Constants.textNumberOfPeople(number: $0))
                        }
                    }
                }
                
                // section 2
                Section {
                    Picker(Constants.tipPercent, selection: $tipPercentage) {
                        ForEach(tipPercentages, id: \.self) {
                            Text($0, format: .percent)
                        }
                    }
                    .pickerStyle(.segmented)
                } header: {
                    Text(Constants.howMuchTip)
                }
                
                // section 1
                Section {
                    Text(totalPerPerson, format: .currency(code: Locale.current.currencyCode ?? Constants.usd))
                } header: {
                    Text(Constants.amtPerPerson)
                }
                
                // section 4
                Section {
                    Text("\(calculateTotalOrTotalPerPerson(showTotal: true), format: .currency(code: Locale.current.currencyCode ?? Constants.usd))")
                } header: {
                    Text(Constants.grandTotalText)
                }
            }
            .navigationTitle(Constants.navTitle)
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button(Constants.done) {
                        amountIsFocused = false
                    }
                }
            }
        }
    }
    
    func calculateTotalOrTotalPerPerson(showTotal: Bool) -> Double {
        let peopleCount = Double(numberOfPeople + 2)
        let tipSelection = Double(tipPercentage)
        
        let tipValue = checkAmount / 100 * tipSelection
        let grandTotal = checkAmount + tipValue
        let amountPerPerson = grandTotal / peopleCount
        
        return showTotal ? grandTotal : amountPerPerson
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
