//
//  Expense.swift
//  demo_animationCreditCards
//
//  Created by Asmaa Ashraf Oraby on 03/06/2025.
//

import SwiftUI

// MARK: Expense Model and Sample Data

struct Expense: Identifiable{
    var id = UUID().uuidString
    var amountSpent: String
    var product: String
    var productIcon: String
    var spendType: String
}

var expenses: [Expense] = [
    Expense(amountSpent: "$123", product: "Noon", productIcon: "Image1", spendType: "typeSpend"),
]
