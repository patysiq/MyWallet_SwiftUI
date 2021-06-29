//
//  AddView.swift
//  MyWallet
//
//  Created by PATRICIA S SIQUEIRA on 29/06/21.
//
import SwiftUI

struct AddView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var expenses: Expenses
    @State private var paid = false
    @State private var type = "Personal"
    @State private var describe = ""
    @State private var amount = ""
    @State private var date = Date()
    @State private var showingAlert = false

    static let types = ["Business", "Personal", "Education", "Home"]
    static let options = ["Yes", "No"]
    
    var body: some View {
        NavigationView {
                Form {
                    DatePicker("Date", selection: $date, in: ...Date(), displayedComponents: .date)
                    Picker("Type", selection: $type) {
                        ForEach(Self.types, id: \.self) {
                            Text($0)
                        }
                    }
                    Toggle("Paid ?", isOn: $paid)
                    TextField("Describe", text: $describe)
                        .keyboardType(.alphabet)
                    TextField("Amount", text: $amount)
                        .keyboardType(.numberPad)
                }
                .navigationBarTitle("Add new expense")
                .navigationBarItems(trailing: Button("Save") {
                    if let actualAmount = Int(self.amount) {
                        let item = ExpenseItem(paid: self.paid, type: self.type, describe: self.describe, amount: actualAmount, date: self.date)
                        self.expenses.items.append(item)
                        self.presentationMode.wrappedValue.dismiss()
                    } else {
                        showingAlert = true
                        self.amount = ""
                    }
                })
                .alert(isPresented: $showingAlert) {
                    Alert(title: Text("Amount invalid"), message: Text("Type Again"), dismissButton: .cancel(Text("Continue")))
                }
        }
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView(expenses: Expenses())
    }
}
