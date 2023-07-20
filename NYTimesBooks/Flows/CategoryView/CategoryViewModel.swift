import Foundation
import UIKit
import Combine

final class CategoryViewModel {
    
    var requestState: AnyPublisher<RequestState, Never> {
        model.requestState.eraseToAnyPublisher()
    }
    
    var reloadCategoryData: AnyPublisher<Void, Never> {
        _reloadCategoryData.receive(on: DispatchQueue.main).eraseToAnyPublisher()
    }
    
    var cellViewModels: [CategoryCellViewModel] = []
    
    private let model: CategoryModel
    private let _reloadCategoryData = PassthroughSubject<Void, Never>()
    private var subscriptions = Set<AnyCancellable>()
    
    init(model: CategoryModel) {
        self.model = model
        
        setupBindings()
    }
    
    private func setupBindings() {
        model.reloadCategoryData.sink { [weak self] _ in
            guard let self = self else { return }
            
            self.buildCellViewModels()
            self._reloadCategoryData.send(())
        }.store(in: &subscriptions)
    }
    
    private func buildCellViewModels() {
        cellViewModels = model.booksCategory.map { value in
            CategoryCellViewModel(
                name: value.listName,
                time: value.newestPublishedDate,
                onSelect: { [weak self] in
                    self?.model.showVehicleInfo(categoryName: value.listNameEncoded, category: value.listName)
                })
        }
    }
    
}
