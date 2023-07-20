import Swinject
import UIKit

final class BookAssembly: Assembly {
    
    private let parent: NavigationNode
    
    init(_ parent: NavigationNode) {
        self.parent = parent
    }
    
    func assemble(container: Container) {
        container.register(BookControllerView.self) { (
            resolver,
            categoryName: String,
            category: String,
            navigationHandler: BookNavigationHandler
        ) in
            let model = BookModel(categoryName: categoryName, category: category, navigationHandler: navigationHandler)
            let viewModel = BookViewModel(model: model)
            let controller = BookControllerView(viewModel: viewModel)
            
            return controller
        }.inObjectScope(.transient)
    }
    
}
