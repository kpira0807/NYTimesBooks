import UIKit
import Swinject

final class CategoryCoordinator: NavigationNode {
    
    var navigationController: UINavigationController? {
        rootViewController.navigationController
    }
    private weak var rootViewController: UIViewController!
    private weak var viewController: UIViewController?
    private var container: Container!
    
    override init(parent: NavigationNode?) {
        super.init(parent: parent)
        
        registerFlow()
        addHandlers()
    }
    
    private func registerFlow() {
        container = Container()
        
        CategoryAssembly(self).assemble(container: container)
        BookAssembly(self).assemble(container: container)
    }
    
    private func addHandlers() {
        // add Settings flow event handlers
    }
    
}

extension CategoryCoordinator: Coordinator {
    
    func createFlow() -> UIViewController {
        let controller: CategoryControllerView = container.autoresolve(argument: self as CategoryNavigationHandler)
        rootViewController = controller
        
        return controller
    }
    
}

extension CategoryCoordinator: CategoryNavigationHandler {
    func categoryModelDidRequestToPresentBooksInfo(_ model: CategoryModel, categoryName: String, category: String) {
        let controller: BookControllerView = container.autoresolve(arguments: categoryName, category, self as BookNavigationHandler)
        
        navigationController?.pushViewController(controller, animated: true)
    }
    
}

extension CategoryCoordinator: BookNavigationHandler {}
