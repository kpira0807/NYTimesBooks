import Foundation
import UIKit
import Combine

final class BookViewModel {
    
    var requestState: AnyPublisher<RequestState, Never> {
      model.requestState.eraseToAnyPublisher()
    }
    
    var reloadBookData: AnyPublisher<Void, Never> {
      _reloadBookData.receive(on: DispatchQueue.main).eraseToAnyPublisher()
    }
    
    var category: String {
        model.category
    }
    
    var cellViewModels: [BookCellViewModel] = []

    private let model: BookModel
    private let _reloadBookData = PassthroughSubject<Void, Never>()
    private var subscriptions = Set<AnyCancellable>()
    
    init(model: BookModel) {
        self.model = model
        
        setupBindings()
    }
    
    private func setupBindings() {
      model.reloadBooksData.sink { [weak self] _ in
        guard let self = self else { return }

        self.buildCellViewModels()
        self._reloadBookData.send(())
      }.store(in: &subscriptions)
    }
    
    private func buildCellViewModels() {
        cellViewModels = model.books.map { value in
            BookCellViewModel(name: value.title, description: value.shortDescription, author: value.author, publisher: value.publisher, rank: "\(value.rank)")
        }
    }
    
}
