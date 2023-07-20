import Foundation
import UIKit
import SnapKit
import Combine

class BookControllerView: NiblessViewController {
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(BookCell.self, forCellReuseIdentifier: BookCell.identifier)
        return tableView
    }()
    
    private var subscriptions = Set<AnyCancellable>()
    private let viewModel: BookViewModel
    
    init(viewModel: BookViewModel) {
        self.viewModel = viewModel
        
        super.init()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.tintColor = Asset.textColor.color
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: Asset.textColor.color]
        navigationController?.navigationBar.largeTitleTextAttributes = [.foregroundColor: Asset.textColor.color, .font: UIFont.systemFont(ofSize: 20.0)]
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
        navigationItem.title = viewModel.category
        
        view.backgroundColor = .white
        setupBindings()
    }
    
    private func setupBindings() {
        viewModel.reloadBookData
            .receive(on: DispatchQueue.main)
            .sink { [weak self] in
                self?.setupViews()
                self?.tableView.reloadData()
            }.store(in: &subscriptions)
    }
    
}

extension BookControllerView {
    
    private func setupViews() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .white
        tableView.separatorStyle = .none
        tableView.estimatedRowHeight = 80.0
        tableView.rowHeight = UITableView.automaticDimension
        
        view.addSubview(tableView)
        tableView.accessibilityIdentifier = "tableView"
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
}

extension BookControllerView: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.cellViewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: BookCell = tableView.dequeueReusableCell(withIdentifier: BookCell.identifier, for: indexPath) as! BookCell
        let cellViewModel = viewModel.cellViewModels[indexPath.row]
        cell.setup(cellViewModel)
        
        return cell
    }
    
}
