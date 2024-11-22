import Foundation

struct DummyParameters: Encodable {
    // No properties, or empty struct
}

protocol APIServiceProtocol {
  func sendRequest<T: Decodable, U: Encodable>(
      endpoint: String,
      method: HTTPMethod,
      parameters: U?,
      headers: [String: String]?,
      decodingType: T.Type,
      completion: @escaping (Result<T, Error>) -> Void
  )
}

// Base APIService implementation (single service layer for all APIs)
final class APIService: APIServiceProtocol {
    static let shared = APIService()
    private init() {}

  func sendRequest<T: Decodable, U: Encodable>(
      endpoint: String,
      method: HTTPMethod = .get,
      parameters: U? = Optional<Bool>.none,
      headers: [String: String]? = nil,
      decodingType: T.Type,
      completion: @escaping (Result<T, Error>) -> Void
  ) {
      guard let url = URL(string: endpoint) else {
          completion(.failure(NetworkError.invalidURL))
          return
      }

      var request = URLRequest(url: url)
      request.httpMethod = method.rawValue
      if let headers = headers {
          headers.forEach { key, value in
              request.setValue(value, forHTTPHeaderField: key)
          }
      }

      if let parameters = parameters {
          do {
              request.httpBody = try JSONEncoder().encode(parameters)
              request.setValue("application/json", forHTTPHeaderField: "Content-Type")
          } catch {
              completion(.failure(NetworkError.encodingFailed))
              return
          }
      }

      let task = URLSession.shared.dataTask(with: request) { data, response, error in
          if let error = error {
              completion(.failure(error))
              return
          }

          guard let data = data else {
              completion(.failure(NetworkError.noData))
              return
          }

          do {
              let result = try JSONDecoder().decode(decodingType, from: data)
              completion(.success(result))
          } catch(let error) {
            print(error)
              completion(.failure(NetworkError.decodingFailed))
          }
      } 
      task.resume()
  }
}

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
    case patch = "PATCH"
}

enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingFailed
    case custom(String)
    case encodingFailed
}

//// Define API protocols for different endpoints
//protocol UserAPI {
//    func fetchUsers(completion: @escaping (Result<[User], Error>) -> Void)
//}
//
//protocol PostAPI {
//    func fetchPosts(completion: @escaping (Result<[Post], Error>) -> Void)
//}
//
//// Extend APIService to conform to UserAPI protocol
//extension APIService: UserAPI {
//    func fetchUsers(completion: @escaping (Result<[User], Error>) -> Void) {
//        sendRequest(endpoint: "https://api.example.com/users", method: .get, parameters: nil, headers: nil, decodingType: [User].self, completion: completion)
//    }
//}
//
//// Extend APIService to conform to PostAPI protocol
//extension APIService: PostAPI {
//    func fetchPosts(completion: @escaping (Result<[Post], Error>) -> Void) {
//        sendRequest(endpoint: "https://api.example.com/posts", method: .get, parameters: nil, headers: nil, decodingType: [Post].self, completion: completion)
//    }
//}


//
//// ViewModel now only depends on APIService
//class ViewModel {
//    private var apiService: APIServiceProtocol
//
//    // Inject only APIService as the dependency
//    init(apiService: APIServiceProtocol = APIService.shared) {
//        self.apiService = apiService
//    }
//
//    // Method to fetch users (through UserAPI extension of APIService)
//    func fetchUsers() {
//        apiService.fetchUsers { result in
//            // Handle result
//        }
//    }
//
//    // Method to fetch posts (through PostAPI extension of APIService)
//    func fetchPosts() {
//        apiService.fetchPosts { result in
//            // Handle result
//        }
//    }
//}