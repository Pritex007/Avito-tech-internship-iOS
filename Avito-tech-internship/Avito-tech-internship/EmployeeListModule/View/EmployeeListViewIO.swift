import Foundation

protocol EmployeeListViewInput: AnyObject {
    func reloadTable()
    func showAlert(title: String, message: String)
}

protocol EmployeeListViewOutput: AnyObject {
    func loadData()
    func getCountOfCells() -> Int
    func configureCell(index: Int) -> EmployeeCell.DisplayData
}
