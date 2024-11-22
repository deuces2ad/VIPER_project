////
////  HealthView.swift
////  TemplateApp
////
////  Created by Abhishek Dhiman on 21/11/24.
////
//
import Foundation
import SwiftUI
import Charts

struct HealthView: View {
  
  @ObservedObject
  var presenter: GraphPresenter
  
  var height = UIScreen.main.bounds.height
  
  init(presenter: GraphPresenter) {
    self.presenter = presenter
  }
  
  var body: some View {
    ScrollView {
      VStack(spacing: 40) {
        GraphView(presenter: presenter)
          .frame(height: height * 0.50)
        SliderView()
      }
    }
  }
}
#Preview {
  HealthView(presenter: .init())
}
//
//import SwiftUI
//import Charts
//
//// Data Model
////struct DailyCalories: Identifiable {
////    let id = UUID()
////    let date: Date
////    let caloriesBurned: Int
////}
//
//// Main View
//struct CalorieBurnLineChart: View {
//    @State private var currentWeekOffset: Int = 0 // Tracks the current week offset
//    let data: [DailyCalories]
//    
//    // Filter data for the current week
//    var filteredData: [DailyCalories] {
//        let calendar = Calendar.current
//        let today = Date()
//        let startOfCurrentWeek = calendar.date(byAdding: .day, value: currentWeekOffset * 7, to: calendar.startOfDay(for: today))!
//        let endOfCurrentWeek = calendar.date(byAdding: .day, value: 7, to: startOfCurrentWeek)!
//
//        return data.filter { $0.date >= startOfCurrentWeek && $0.date < endOfCurrentWeek }
//    }
//    
//    // Date Range for Display
//    var weekRangeText: String {
//        let calendar = Calendar.current
//        let today = Date()
//        let startOfCurrentWeek = calendar.date(byAdding: .day, value: currentWeekOffset * 7, to: calendar.startOfDay(for: today))!
//        let endOfCurrentWeek = calendar.date(byAdding: .day, value: 7, to: startOfCurrentWeek)!
//        
//        let formatter = DateFormatter()
//        formatter.dateFormat = "dd MMM"
//        return "\(formatter.string(from: startOfCurrentWeek)) - \(formatter.string(from: endOfCurrentWeek))"
//    }
//    
//    var body: some View {
//        VStack {
//            Text("Calories Burned (\(weekRangeText))")
//                .font(.title2)
//                .padding()
//            
//            Chart(filteredData) {
//                // Gradient Area
//                AreaMark(
//                    x: .value("Date", $0.date),
//                    y: .value("Calories Burned", $0.caloriesBurned)
//                )
//                .foregroundStyle(
//                    LinearGradient(
//                        colors: [Color.blue.opacity(0.5), Color.blue.opacity(0.1)],
//                        startPoint: .top,
//                        endPoint: .bottom
//                    )
//                )
//                
//                // Line
//                LineMark(
//                    x: .value("Date", $0.date),
//                    y: .value("Calories Burned", $0.caloriesBurned)
//                )
//                .interpolationMethod(.linear)
//                .foregroundStyle(.blue)
//                .lineStyle(StrokeStyle(lineWidth: 2))
//            }
//            .chartXAxis {
//                AxisMarks(values: .stride(by: .day, count: 1)) {
//                    AxisValueLabel(format: .dateTime.day().month())
//                }
//            }
//            .chartYAxis {
//                AxisMarks {
//                    AxisValueLabel()
//                }
//            }
//            .frame(height: 300)
//            .padding()
//            .background(Color(.systemGray6))
//            .cornerRadius(10)
//            .shadow(radius: 5)
//            
//            // Buttons for Navigation
//            HStack {
//                Button(action: {
//                    currentWeekOffset -= 1 // Move to the previous week
//                }) {
//                    Text("Previous Week")
//                        .padding()
//                        .background(Color.blue)
//                        .foregroundColor(.white)
//                        .cornerRadius(8)
//                }
//                
//                Button(action: {
//                    currentWeekOffset += 1 // Move to the next week
//                }) {
//                    Text("Next Week")
//                        .padding()
//                        .background(Color.green)
//                        .foregroundColor(.white)
//                        .cornerRadius(8)
//                }
//            }
//        }
//        .padding()
//    }
//}
//
//// Preview and Data Setup
//struct DummGraph: View {
//    var body: some View {
//        // Generate Dummy Data for 90 Days
//        let sampleData: [DailyCalories] = (0..<90).map { dayOffset in
//            let randomCalories = Int.random(in: 200...600)
//            return DailyCalories(
//                date: Calendar.current.date(byAdding: .day, value: -dayOffset, to: Date())!,
//                caloriesBurned: randomCalories
//            )
//        }
//        
//        return CalorieBurnLineChart(data: sampleData)
//    }
//}
//
//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//      DummGraph()
//    }
//}
