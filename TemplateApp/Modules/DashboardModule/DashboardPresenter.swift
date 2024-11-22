//
//  DashboardPresenter.swift
//  TemplateApp
//
//  Created by Abhishek Dhiman on 21/11/24.
//

import Foundation
import SwiftUI

protocol DashboardPresenterProtocol: Observable {
  var exercisePresenter: ExercisePresenter { get set }
}

class DashboardPresenter: ObservableObject {
  
  @ObservedObject
  var graphPresenter: GraphPresenter
  
  init(graphPresenter: GraphPresenter) {
    self.graphPresenter = graphPresenter
  }
}

extension View {
  func injectDashboardDependencies(using presenter: DashboardPresenter) -> some View {
    self
      .environmentObject(presenter.graphPresenter)
  }
}
