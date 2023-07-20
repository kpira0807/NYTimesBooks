import Foundation
import UIKit
import SnapKit

final class CategoryCell: UITableViewCell {
    
    static let identifier = "CategoryCell"
    
    private let backView = UIView()
    private let titleCategotyLabel = UILabel()
    private let updateData = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(_ viewModel: CategoryCellViewModel) {
        titleCategotyLabel.text = viewModel.name
        updateData.text = "Last update: \(viewModel.time)"
    }
    
}

extension CategoryCell {
    
    private func setupView() {
        addSubview(backView)
        backView.accessibilityIdentifier = "backView"
        backView.layer.cornerRadius = 8.0
        backView.layer.borderWidth = 1.0
        backView.layer.borderColor = Asset.borderColor.color.cgColor
        backView.backgroundColor = Asset.backgroundColor.color
        backView.snp.makeConstraints{make in
            make.top.equalToSuperview().offset(8.0)
            make.bottom.equalToSuperview().inset(8.0)
            make.leading.equalToSuperview().offset(8.0)
            make.trailing.equalToSuperview().inset(8.0)
        }
        
        backView.addSubview(titleCategotyLabel)
        titleCategotyLabel.accessibilityIdentifier = "titleCategotyLabel"
        titleCategotyLabel.numberOfLines = 0
        titleCategotyLabel.textAlignment = .left
        titleCategotyLabel.textColor = Asset.textTitleColor.color
        titleCategotyLabel.font = UIFont.boldSystemFont(ofSize: 14.0)
        titleCategotyLabel.snp.makeConstraints{make in
            make.top.equalToSuperview().offset(8.0)
            make.leading.equalToSuperview().offset(8.0)
            make.bottom.equalToSuperview().inset(8.0)
        }
        
        backView.addSubview(updateData)
        updateData.accessibilityIdentifier = "updateData"
        updateData.numberOfLines = 1
        updateData.textAlignment = .right
        updateData.textColor = Asset.textTitleColor.color.withAlphaComponent(0.8)
        updateData.font = UIFont.boldSystemFont(ofSize: 10.0)
        updateData.snp.makeConstraints{make in
            make.top.equalToSuperview().offset(8.0)
            make.leading.equalTo(titleCategotyLabel.snp.trailing).offset(8.0)
            make.bottom.equalToSuperview().inset(8.0)
            make.trailing.equalToSuperview().inset(8.0)
        }
    }
    
}
