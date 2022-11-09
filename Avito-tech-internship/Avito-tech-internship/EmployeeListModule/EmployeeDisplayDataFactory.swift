import Foundation

// MARK: - EmployeeDisplayDataFactoryProtocol

protocol EmployeeDisplayDataFactoryProtocol {
    func configureEmployeeCellDisplayData(name: String, phoneNumber: String, skills: [String]) -> EmployeeCell.DisplayData
}

// MARK: - EmployeeDisplayDataFactory

final class EmployeeDisplayDataFactory: EmployeeDisplayDataFactoryProtocol {
    func configureEmployeeCellDisplayData(name: String, phoneNumber: String, skills: [String]) -> EmployeeCell.DisplayData {
        let formattedSkills = skills.joined(separator: ", ")
        return EmployeeCell.DisplayData(name: name, phoneNumber: phoneNumber, skills: formattedSkills)
    }
}
