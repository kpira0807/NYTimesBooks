import Foundation
import UIKit
import SnapKit
import Combine

class CategoryControllerView: NiblessViewController {
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(CategoryCell.self, forCellReuseIdentifier: CategoryCell.identifier)
        return tableView
    }()
    
    private let viewModel: CategoryViewModel
    private var subscriptions = Set<AnyCancellable>()
    
    init(viewModel: CategoryViewModel) {
        self.viewModel = viewModel
        
        super.init()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: Asset.textColor.color]
        navigationController?.navigationBar.largeTitleTextAttributes = [.foregroundColor: Asset.textColor.color, .font: UIFont.systemFont(ofSize: 20.0)]
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
//        self.navigationController?.navigationBar.largeTitleTextAttributes = [.font : UIFont.systemFont(ofSize: 20.0)]
        navigationItem.title = L10n.Category.Title.name
        
        view.backgroundColor = .white
        setupBindings()
    }
    
    private func setupBindings() {
        //    bind(requestState: viewModel.requestState).store(in: &subscriptions)
        
        viewModel.reloadCategoryData
            .receive(on: DispatchQueue.main)
            .sink { [weak self] in
                self?.setupViews()
                self?.tableView.reloadData()
            }.store(in: &subscriptions)
    }
    
}

extension CategoryControllerView {
    
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

extension CategoryControllerView: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.cellViewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: CategoryCell = tableView.dequeueReusableCell(withIdentifier: CategoryCell.identifier, for: indexPath) as! CategoryCell
        let cellViewModel = viewModel.cellViewModels[indexPath.row]
        cell.setup(cellViewModel)
        cell.selectionStyle = .none
        
        return cell
    }
    
}

extension CategoryControllerView: UITableViewDropDelegate {
    func tableView(_ tableView: UITableView, performDropWith coordinator: UITableViewDropCoordinator) {
        print("performDropWith")
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let viewModel = viewModel.cellViewModels[indexPath.row]
        viewModel.onSelect()
    }
}

extension CategoryControllerView: UITableViewDragDelegate {
    
    func tableView(_ tableView: UITableView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        
        [UIDragItem(itemProvider: NSItemProvider())]
    }
    
}
