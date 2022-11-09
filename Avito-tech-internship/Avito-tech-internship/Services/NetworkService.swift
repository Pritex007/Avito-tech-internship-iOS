import Foundation

// MARK: - NetworkError

enum NetworkError: Error {
    case noData
    case transportError(Error)
    case serverError(statusCode: Int)
}

// MARK: - NetworkServiceProtocol

protocol NetworkServiceProtocol: AnyObject {
    func sendRequest(_ request: URLRequest, completion: @escaping (Result<Data, NetworkError>) -> Void)
}

// MARK: - NetworkService

final class NetworkService: NetworkServiceProtocol {
    private let session: URLSession
    
    init(session: URLSession) {
        self.session = session
    }
    
    func sendRequest(_ request: URLRequest, completion: @escaping (Result<Data, NetworkError>) -> Void) {
        session.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(.transportError(error)))
            }
            if let response = response as? HTTPURLResponse,
               !(200...299).contains(response.statusCode) {
                
            }
            if let data = data {
                completion(.success(data))
            } else {
                completion(.failure(.noData))
            }
        }.resume()
    }
}
