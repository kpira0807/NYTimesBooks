import Swinject
import UIKit

final class CategoryAssembly: Assembly {
    
    private let parent: NavigationNode
    
    init(_ parent: NavigationNode) {
        self.parent = parent
    }
    
    func assemble(container: Container) {
        container.register(CategoryControllerView.self) { (resolver, navigationHandler: CategoryNavigationHandler) in
            let model = CategoryModel(navigationHandler: navigationHandler)
            let viewModel = CategoryViewModel(model: model)
            let controller = CategoryControllerView(viewModel: viewModel)
            
            return controller
        }.inObjectScope(.transient)
    }
    
}
