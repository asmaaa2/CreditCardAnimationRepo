//
//  ExpenseCardView.swift
//  demo_animationCreditCards
//
//  Created by Asmaa Ashraf Oraby on 03/06/2025.
//

import SwiftUI

struct ExpenseCardView: View {
    var expense: Expense
    // Dispaly Expenses one by one vased on Index
    @State var showView: Bool = false
    var body: some View {
        HStack(spacing: 14){
            VStack(alignment: .leading, spacing: 8) {
                Text(expense.product)
                    .fontWeight(.bold)
                
                Text(expense.spendType)
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            VStack(spacing: 8){
                Text(expense.amountSpent)
                    .fontWeight(.bold)
                
                Text(Date().formatted(date: .numeric, time: .omitted))
                    .font(.caption)
                    .foregroundColor(.gray)
            }
        }
        .opacity(showView ? 1 : 0)
        .onAppear{
            // Time taken to show up
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                withAnimation(.easeInOut(duration: 0.3).delay(Double(getIndex()) * 0.1)){
                    showView = true
                }
            }
        }
    }
    
    func getIndex()->Int{
        return expenses.firstIndex{ currentExpense in
            return expense.id == currentExpense.id
        } ?? 0
    }
}
