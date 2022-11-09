//import Foundation
//
//protocol DataProvideProtocol {
//    func getDataFromCache(withURL url: URL) -> ModelContainerData?
//    func loadDataFromInternet(withURL url: URL, completion: @escaping (Result<ModelContainerData, NetworkError>) -> Void)
//}
//
//final class DataProvider: DataProvideProtocol {
//    private let networkService: NetworkServiceProtocol
//
//    init(networkService: NetworkServiceProtocol) {
//        self.networkService = networkService
//    }
//
//    private let cache = Cache<String, ModelContainerData>()
//
//    func loadDataFromInternet(withURL url: URL, completion: @escaping (Result<ModelContainerData, NetworkError>) -> Void) {
//        let request = URLRequest(url: url, cachePolicy: .reloadRevalidatingCacheData, timeoutInterval: 10)
//        networkService.sendRequest(request) { [weak self] result in
//            switch(result) {
//            case .failure(let error):
//                print("Failed to load data: \(error.localizedDescription)")
//                completion(.failure(error))
//            case .success(let rawData):
//                do {
//                    let decoder = JSONDecoder()
//                    decoder.keyDecodingStrategy = .convertFromSnakeCase
//                    let data: ModelContainerData = try decoder.decode(ModelContainerData.self, from: rawData)
//
//                    self?.cache.insert(data, forKey: url.absoluteString)
//
//                    completion(.success(data))
//                } catch {
//                    print("Decoding failure: \(error.localizedDescription)")
//                }
//            }
//        }
//    }
//
//    func getDataFromCache(withURL url: URL) -> ModelContainerData? {
//        return cache.value(forKey: url.absoluteString)
//    }
//}
