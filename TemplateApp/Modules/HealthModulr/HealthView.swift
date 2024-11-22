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
