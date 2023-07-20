import Foundation
import Combine

protocol CategoryNavigationHandler {
    
    func categoryModelDidRequestToPresentBooksInfo(
        _ model: CategoryModel,
        categoryName: String,
        category: String
    )
    
}

final class CategoryModel {
    
    private let navigationHandler: CategoryNavigationHandler
    
    let requestState = CurrentValueSubject<RequestState, Never>(.finished)
    let reloadCategoryData = PassthroughSubject<Void, Never>()
    var booksCategory = [NYTBooksCategory]()
    
    init(navigationHandler: CategoryNavigationHandler) {
        self.navigationHandler = navigationHandler
        
        fetchData()
    }
    
    func showVehicleInfo(categoryName: String, category: String) {
        navigationHandler.categoryModelDidRequestToPresentBooksInfo(self, categoryName: categoryName, category: category)
    }
    
    private func fetchData() {
        let url = "https://api.nytimes.com/svc/books/v3/lists/names.json?api-key=\(APIKeys.NYTBookApiKey)"
        let urls = URL(string: url)
        
        URLSession.shared.dataTask(with: urls!) { (data, response, error) in
            guard let data = data else { return }
            
            Task {
                do {
                    let decoder = JSONDecoder()
                    let bookCategory = try decoder.decode(NYTBooksCategoryJSON.self, from: data).results
                    DispatchQueue.main.async { [self] in
                        let categoryNames = bookCategory.sorted(by: {$0.displayName < $1.displayName})
                        self.booksCategory.append(contentsOf: categoryNames)
                        reloadCategoryData.send(())
                        requestState.send(.finished)
                    }
                } catch {
                    self.requestState.send(.failed(error))
                    print("Error: \(error.localizedDescription)")
                }
            }
        }.resume()
    }
    
}
