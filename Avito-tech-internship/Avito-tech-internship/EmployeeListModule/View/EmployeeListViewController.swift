import Foundation
import UIKit

final class EmployeeListViewController: UIViewController {
    
    // MARK: Private constants
    
    private enum Constants {
        enum TableView {
            static let rowHeight: CGFloat = 50
        }
    }
    
    var output: EmployeeListViewOutput?
    
    // MARK: Private views
    
    private let tableView: UITableView = UITableView()
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        title = "Employees"
        
        setupNavigationBar()
        setupTable()
        setupConstraints()
        output?.loadData()
    }
    
    // MARK: Private methods
    
    private func setupNavigationBar() {
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    private func setupTable() {
        view.addSubview(tableView)
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(EmployeeCell.self, forCellReuseIdentifier: EmployeeCell.reuseId)
        
        tableView.separatorStyle = .none
    }
    
    private func setupConstraints() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

// MARK: - UITableViewDataSource

extension EmployeeListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let count = output?.getCountOfCells() else { return 0 }
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: EmployeeCell.reuseId) as? EmployeeCell,
              let displayData = output?.configureCell(index: indexPath.row)
        else {
            return UITableViewCell()
        }
        cell.configure(displayData: displayData)
        return cell
    }
}

// MARK: - UITableViewDelegate

extension EmployeeListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Constants.TableView.rowHeight
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: - EmployeeListViewInput

extension EmployeeListViewController: EmployeeListViewInput {
    func reloadTable() {
        tableView.reloadData()
    }
    
    func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: "",
                                                message: message,
                                                preferredStyle: .alert)
        let acceptAction = UIAlertAction(title: "Ok",
                                         style: .cancel)
        alertController.addAction(acceptAction)
        present(alertController, animated: true)
    }
}
