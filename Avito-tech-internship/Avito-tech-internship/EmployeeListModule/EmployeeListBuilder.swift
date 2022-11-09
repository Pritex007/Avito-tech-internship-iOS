import Foundation
import UIKit

final class EmployeeListBuilder {
    func build() -> UIViewController {
        let networkService = NetworkService(session: URLSession(configuration: .default))
        
        let employeeDisplayDataFactory = EmployeeDisplayDataFactory()
        
        let view = EmployeeListViewController()
        let presenter = EmployeePresenter(networkService: networkService,
                                          employeeDisplayDataFactory: employeeDisplayDataFactory)
        
        view.output = presenter
        presenter.view = view
        
        return view
    }
}
