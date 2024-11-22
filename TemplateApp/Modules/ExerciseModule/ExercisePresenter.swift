//
//  ExercisePresenter.swift
//  TemplateApp
//
//  Created by Abhishek Dhiman on 17/11/24.
//

import Foundation
import Combine

protocol ExercisePresenterProtocol: ObservableObject {
  func renderExerciseList()
}

import Combine

class ExercisePresenter: ObservableObject {
  
  private var interactor: ExerciseInteractorProtocol
  private var cancellables = Set<AnyCancellable>()
  
  @Published
  var exercise: [Exercise] = []
  
  init(interactor: ExerciseInteractorProtocol) {
    self.interactor = interactor
  }
  
  
  func renderExerciseList() {
    interactor.fetchExercise()  // Fetch the exercises via the Interactor
      .sink(receiveCompletion: { completion in
        switch completion {
        case .finished:
          break  // Success case
        case .failure(let error):
          print("Error fetching exercises: \(error)")  // Handle errors here
        }
      }, receiveValue: { [weak self] exercises in
        print("result: Abhishek\(#line)",exercises)
        self?.exercise = exercises  // Update the exercises array on success
      })
      .store(in: &cancellables)  // Store the subscription to manage its lifecycle
  }
  
  
}
