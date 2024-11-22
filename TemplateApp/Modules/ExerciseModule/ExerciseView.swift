//
//  ExerciseView.swift
//  TemplateApp
//
//  Created by Abhishek Dhiman on 17/11/24.
//

import Foundation
import SwiftUI

struct ExerciseView: View {
  
  @ObservedObject
  var presenter: ExercisePresenter
  
  var body: some View {
    VStack {
      List(presenter.exercise) { item in
        HStack {
          Text("\(item.id)")
          Text(item.body)
        }
        
      }
    }.onAppear {
       presenter.renderExerciseList()
    }
  }
}
