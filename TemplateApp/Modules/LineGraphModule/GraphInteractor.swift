//
//  GraphInteractor.swift
//  TemplateApp
//
//  Created by Abhishek Dhiman on 21/11/24.
//

import Foundation

class GraphInteractor {
    private let allData: [DailyCalories]
    
    init() {
        // Move dummy data creation to the interactor
        self.allData = (0..<90).map { dayOffset in
            let randomCalories = Int.random(in: 200...600)
            return DailyCalories(
                date: Calendar.current.date(byAdding: .day, value: -dayOffset, to: Date())!,
                caloriesBurned: randomCalories
            )
        }
    }
    
    func fetchData(forWeekOffset offset: Int) -> ([DailyCalories], String) {
        let calendar = Calendar.current
        let today = Date()
        let startOfWeek = calendar.date(byAdding: .day, value: offset * 7, to: calendar.startOfDay(for: today))!
        let endOfWeek = calendar.date(byAdding: .day, value: 7, to: startOfWeek)!
        
        let filteredData = allData.filter { $0.date >= startOfWeek && $0.date < endOfWeek }
        
        // Date Range for Display
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMM"
        let weekRange = "\(formatter.string(from: startOfWeek)) - \(formatter.string(from: endOfWeek))"
        
        return (filteredData, weekRange)
    }
}
