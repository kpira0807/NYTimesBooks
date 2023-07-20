import Foundation
import UIKit
import SnapKit

final class BookCell: UITableViewCell {
    
    static let identifier = "BookCell"
    
    private let backView = UIView()
    private let bookNameLabel = UILabel()
    private let bookDescriptionLabel = UILabel()
    private let bookAuthorLabel = UILabel()
    private let bookPublisherLabel = UILabel()
    private let bookImage = UIImageView()
    private let bookRankLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(_ viewModel: BookCellViewModel) {
        bookNameLabel.text = viewModel.name
        bookDescriptionLabel.text = viewModel.description
        bookAuthorLabel.text = viewModel.author
        bookPublisherLabel.text = "Publisher: \(viewModel.publisher)"
      //  bookImage.image = viewModel.image
        bookRankLabel.text = "Rank: \(viewModel.rank)"
    }
    
}

extension BookCell {
    
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
        
        backView.addSubview(bookNameLabel)
        bookNameLabel.accessibilityIdentifier = "bookNameLabel"
        bookNameLabel.numberOfLines = 0
        bookNameLabel.textAlignment = .center
        bookNameLabel.textColor = Asset.textColor.color
        bookNameLabel.font = UIFont.boldSystemFont(ofSize: 14.0)
        bookNameLabel.snp.makeConstraints{make in
            make.top.equalToSuperview().offset(4.0)
            make.leading.equalToSuperview().offset(8.0)
            make.trailing.equalToSuperview().inset(8.0)
        }
        
        backView.addSubview(bookAuthorLabel)
        bookAuthorLabel.accessibilityIdentifier = "bookAuthorLabel"
        bookAuthorLabel.numberOfLines = 0
        bookAuthorLabel.textAlignment = .center
        bookAuthorLabel.textColor = Asset.textColor.color
        bookAuthorLabel.font = UIFont.boldSystemFont(ofSize: 12.0)
        bookAuthorLabel.snp.makeConstraints{make in
            make.top.equalTo(bookNameLabel.snp.bottom).offset(4.0)
            make.leading.equalToSuperview().offset(8.0)
            make.trailing.equalToSuperview().inset(8.0)
        }
        
        backView.addSubview(bookPublisherLabel)
        bookPublisherLabel.accessibilityIdentifier = "bookPublisherLabel"
        bookPublisherLabel.numberOfLines = 0
        bookPublisherLabel.textAlignment = .center
        bookPublisherLabel.textColor = Asset.textColor.color
        bookPublisherLabel.font = UIFont.boldSystemFont(ofSize: 12.0)
        bookPublisherLabel.snp.makeConstraints{make in
            make.top.equalTo(bookAuthorLabel.snp.bottom).offset(4.0)
            make.leading.equalToSuperview().offset(8.0)
            make.trailing.equalToSuperview().inset(8.0)
        }
        
        backView.addSubview(bookRankLabel)
        bookRankLabel.accessibilityIdentifier = "bookRankLabel"
        bookRankLabel.numberOfLines = 1
        bookRankLabel.textAlignment = .center
        bookRankLabel.textColor = Asset.textColor.color
        bookRankLabel.font = UIFont.boldSystemFont(ofSize: 12.0)
        bookRankLabel.snp.makeConstraints{make in
            make.top.equalTo(bookPublisherLabel.snp.bottom).offset(4.0)
            make.leading.equalToSuperview().offset(8.0)
            make.trailing.equalToSuperview().inset(8.0)
        }
        
        backView.addSubview(bookImage)
        bookImage.accessibilityIdentifier = "bookImage"
        bookImage.layer.cornerRadius = 8.0
        bookImage.image = UIImage.checkmark
        bookImage.image = ImageAsset(name: "book").image
        bookImage.snp.makeConstraints{make in
            make.top.equalTo(bookRankLabel.snp.bottom).offset(8.0)
            make.leading.equalToSuperview().offset(8.0)
            make.bottom.equalToSuperview().inset(8.0)
            make.trailing.equalTo(backView.snp.centerX).inset(8.0)
            make.height.equalTo(150.0)
        }
        
        backView.addSubview(bookDescriptionLabel)
        bookDescriptionLabel.accessibilityIdentifier = "bookDescriptionLabel"
        bookDescriptionLabel.numberOfLines = 0
        bookDescriptionLabel.textAlignment = .left
        bookDescriptionLabel.textColor = Asset.textColor.color
        bookDescriptionLabel.font = UIFont.systemFont(ofSize: 10.0)
        bookDescriptionLabel.snp.makeConstraints{make in
            make.top.equalTo(bookImage.snp.top)
            make.bottom.equalTo(bookImage.snp.bottom)
            make.leading.equalTo(backView.snp.centerX).offset(8.0)
            make.trailing.equalToSuperview().inset(8.0)
        }

    }
    
}
