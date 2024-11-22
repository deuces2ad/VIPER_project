//
//  LineGraphView.swift
//  TemplateApp
//
//  Created by Abhishek Dhiman on 21/11/24.
//

import Foundation
import SwiftUI
import Charts

struct GraphView: View {
  
  @ObservedObject
  var presenter: GraphPresenter
    
    var body: some View {
        VStack {
            if presenter.hasData {
                Text("Calories Burned (\(presenter.weekRangeText))")
                    .font(.title2)
                    .padding()
                
              Chart(presenter.filteredData) {
                    AreaMark(
                        x: .value("Date", $0.date),
                        y: .value("Calories Burned", $0.caloriesBurned)
                    )
                    .foregroundStyle(
                        LinearGradient(
                            colors: [Color.blue.opacity(0.5), Color.blue.opacity(0.1)],
                            startPoint: .top,
                            endPoint: .bottom
                        )
                    )
                    LineMark(
                        x: .value("Date", $0.date),
                        y: .value("Calories Burned", $0.caloriesBurned)
                    )
                    .interpolationMethod(.linear)
                    .foregroundStyle(.blue)
                    .lineStyle(StrokeStyle(lineWidth: 2))
                }
                .chartXAxis {
                    AxisMarks(values: .stride(by: .day, count: 1)) {
                        AxisValueLabel(format: .dateTime.day().month())
                    }
                }
                .chartYAxis {
                    AxisMarks {
                        AxisValueLabel()
                    }
                }
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(10)
                .shadow(radius: 5)
            } else {
                Text("No data available for this week.")
                    .foregroundColor(.gray)
            }
            
            // Buttons
            HStack {
                Button(action: {
                    presenter.showPreviousWeek()
                }) {
                    Text("Previous Week")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                .disabled(!presenter.canNavigateToPreviousWeek)
                
                Button(action: {
                    presenter.showNextWeek()
                }) {
                    Text("Next Week")
                        .padding()
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                .disabled(!presenter.canNavigateToNextWeek)
            }
        }
    }
}


struct DailyCalories: Identifiable {
  var id: UUID = UUID()
    let date: Date
    let caloriesBurned: Int
}

#Preview {
  GraphView(presenter: .init(interactor: .init()))
}
