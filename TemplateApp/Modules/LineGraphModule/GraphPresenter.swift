//
//  GraphPresenter.swift
//  TemplateApp
//
//  Created by Abhishek Dhiman on 21/11/24.
//

import Foundation

class GraphPresenter: ObservableObject {
  @Published
  var filteredData: [DailyCalories] = []

  @Published
  var weekRangeText: String = ""

  @Published
  var hasData: Bool = false

  @Published
  var canNavigateToPreviousWeek: Bool = false

  @Published
  var canNavigateToNextWeek: Bool = false

    private let interactor: GraphInteractor
    private var currentWeekOffset: Int = 0
    
  init(interactor: GraphInteractor = .init()) {
        self.interactor = interactor
        self.updateData()
    }
    
    func showPreviousWeek() {
        currentWeekOffset -= 1
        updateData()
    }
    
    func showNextWeek() {
        currentWeekOffset += 1
        updateData()
    }
    
    private func updateData() {
        let (data, weekRange) = interactor.fetchData(forWeekOffset: currentWeekOffset)
        filteredData = data
        weekRangeText = weekRange
        hasData = !data.isEmpty
        
        // Validation for buttons
        canNavigateToPreviousWeek = currentWeekOffset > -4 // Example: limit to 4 weeks back
        canNavigateToNextWeek = currentWeekOffset < 4      // Example: limit to 4 weeks ahead
    }
}
