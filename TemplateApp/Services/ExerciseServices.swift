//
//  ExerciseServices.swift
//  TemplateApp
//
//  Created by Abhishek Dhiman on 17/11/24.
//

import Foundation
import Combine
protocol ExerciseService {
  func fetchExercise() -> AnyPublisher<[Exercise], Error>
}

extension APIService: ExerciseService {
  
  func fetchExercise() -> AnyPublisher<[Exercise], Error> {
    // Create a Publisher using Future
    return Future { promise in
      // Call the existing sendRequest method
      self.sendRequest(endpoint: "https://jsonplaceholder.typicode.com/posts", method: .get, decodingType: [Exercise].self) { result in
        switch result {
        case .success(let list):
          promise(.success(list))  // If successful, emit the list of exercises
        case .failure(let error):
          promise(.failure(error)) // If failure, emit the error
        }
      }
    }
    .receive(on: DispatchQueue.main)  // Ensure updates happen on the main thread
    .eraseToAnyPublisher()           // Return a generic Publisher type
  }
}

