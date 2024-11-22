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
   
    return Future { promise in
     
      self.sendRequest(endpoint: "https://jsonplaceholder.typicode.com/posts", method: .get, decodingType: [Exercise].self) { result in
        switch result {
        case .success(let list):
          promise(.success(list))
        case .failure(let error):
          promise(.failure(error))
        }
      }
    }
    .receive(on: DispatchQueue.main)
    .eraseToAnyPublisher() 
  }
}

