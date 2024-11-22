//
//  ExerciseIntractor.swift
//  TemplateApp
//
//  Created by Abhishek Dhiman on 17/11/24.
//

import Foundation
import Combine

protocol ExerciseInteractorProtocol {
  func fetchExercise() -> AnyPublisher<[Exercise], Error>
}

class ExerciseIntractor: ExerciseInteractorProtocol {
  
  private var service: APIServiceCompositeProtocol
  private(set) var exercise: [Exercise] = []
  
  init(service: APIServiceCompositeProtocol = APIService.shared) {
    self.service = service
  }
  
  func fetchExercise() -> AnyPublisher<[Exercise], Error> {
     service.fetchExercise()
  }
}


struct Exercise: Codable, Identifiable, Equatable {
  var id: Int
  var body: String
  var title: String
}
