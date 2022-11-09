import Foundation
import UIKit

final class EmployeeCell: UITableViewCell {
    
    // MARK: Private constants
    
    private enum Constants {
        enum NameLabel {
            static let fontSize: CGFloat = 16
        }
        enum SkillLabel {
            static let fontSize: CGFloat = 14
        }
        enum PhoneNumberLabel {
            static let fontSize: CGFloat = 16
        }
        enum Cell {
            static let leadingTrailingIndent: CGFloat = 16
            static let topBottomIndent: CGFloat = 4
        }
    }
    
    // MARK: Display data
    
    struct DisplayData {
        let name: String
        let phoneNumber: String
        let skills: String
    }
    
    // MARK: Static reuseId
    
    static let reuseId: String = "EmployeeCell"
    
    // MARK: Private views
    
    private let nameLabel: UILabel = UILabel()
    private let skillLabel: UILabel = UILabel()
    private let phoneNumberLabel: UILabel = UILabel()
    
    // MARK: Lifecycle
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setupViews()
        setupConstraints()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
        setupConstraints()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: Constants.Cell.topBottomIndent,
                                                                     left: Constants.Cell.leadingTrailingIndent,
                                                                     bottom: Constants.Cell.topBottomIndent,
                                                                     right: Constants.Cell.leadingTrailingIndent))
    }
    
    // MARK: Internal method
    
    func configure(displayData: DisplayData) {
        nameLabel.text = displayData.name
        skillLabel.text = displayData.skills
        phoneNumberLabel.text = displayData.phoneNumber
    }
    
    // MARK: Private methods
    
    private func setupViews() {
        [nameLabel, skillLabel, phoneNumberLabel].forEach(contentView.addSubview(_:))
        
        nameLabel.font = UIFont.systemFont(ofSize: Constants.NameLabel.fontSize)
        nameLabel.textColor = .black
        
        skillLabel.font = UIFont.systemFont(ofSize: Constants.SkillLabel.fontSize)
        skillLabel.textColor = .systemGray
        
        phoneNumberLabel.font = UIFont.systemFont(ofSize: Constants.PhoneNumberLabel.fontSize)
        phoneNumberLabel.textColor = .systemGray
    }
    
    private func setupConstraints() {
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        skillLabel.translatesAutoresizingMaskIntoConstraints = false
        phoneNumberLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            nameLabel.trailingAnchor.constraint(lessThanOrEqualTo: phoneNumberLabel.trailingAnchor),
            
            skillLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            skillLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            skillLabel.trailingAnchor.constraint(lessThanOrEqualTo: phoneNumberLabel.trailingAnchor),
            
            phoneNumberLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            phoneNumberLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            phoneNumberLabel.leadingAnchor.constraint(greaterThanOrEqualTo: nameLabel.trailingAnchor),
            phoneNumberLabel.leadingAnchor.constraint(greaterThanOrEqualTo: skillLabel.trailingAnchor),
        ])
        
        nameLabel.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        skillLabel.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        phoneNumberLabel.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
    }
}
