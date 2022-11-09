import Foundation

final class EmployeePresenter {
    weak var view: EmployeeListViewInput?
    private var model: ModelContainerData?
    
    private let networkService: NetworkServiceProtocol
    private let employeeDisplayDataFactory: EmployeeDisplayDataFactoryProtocol
    
    init(networkService: NetworkServiceProtocol, employeeDisplayDataFactory: EmployeeDisplayDataFactoryProtocol) {
        self.networkService = networkService
        self.employeeDisplayDataFactory = employeeDisplayDataFactory
    }
}

// MARK: - EmployeeListViewOutput

extension EmployeePresenter: EmployeeListViewOutput {
    func getCountOfCells() -> Int {
        guard let count = model?.company.employees.count
        else {
            return 0
        }
        return count
    }
    
    func configureCell(index: Int) -> EmployeeCell.DisplayData {
        guard let cellInfo = model?.company.employees[index] else {
            return EmployeeCell.DisplayData(name: "", phoneNumber: "", skills: "")
        }
        let displayData = employeeDisplayDataFactory.configureEmployeeCellDisplayData(name: cellInfo.name, phoneNumber: cellInfo.phoneNumber, skills: cellInfo.skills)
        
        return EmployeeCell.DisplayData(name: displayData.name,
                                        phoneNumber: displayData.phoneNumber,
                                        skills: displayData.skills)
    }
    
    func loadData() {
        let isConnected = Reachability.isConnectedToNetwork()
        if isConnected {
            guard let url = URL(string: "https://run.mocky.io/v3/1d1cb4ec-73db-4762-8c4b-0b8aa3cecd4c") else {
                return
            }
            let request = URLRequest(url: url, cachePolicy: .reloadRevalidatingCacheData, timeoutInterval: 10)
            networkService.sendRequest(request) { [weak self] result in
                switch(result) {
                case .failure(let error):
                    print("Failed to load data: \(error.localizedDescription)")
                case .success(let rawData):
                    do {
                        let decoder = JSONDecoder()
                        decoder.keyDecodingStrategy = .convertFromSnakeCase
                        let data: ModelContainerData = try decoder.decode(ModelContainerData.self, from: rawData)
                        self?.model = data
                        
                        DispatchQueue.main.async {
                            self?.view?.reloadTable()
                        }
                    } catch {
                        print("Decoding failure: \(error.localizedDescription)")
                    }
                }
            }
        } else {
            view?.showAlert(title: "Warning", message: "No internet connection")
        }
    }
}
