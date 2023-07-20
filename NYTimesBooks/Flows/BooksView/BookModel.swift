import Foundation
import Combine

protocol BookNavigationHandler {}

final class BookModel {
    
    private let navigationHandler: BookNavigationHandler
    
    let categoryName: String
    let category: String
    let requestState = CurrentValueSubject<RequestState, Never>(.finished)
    let reloadBooksData = PassthroughSubject<Void, Never>()
    
    var books = [NYTBooks]()
    
    init(
        categoryName: String,
        category: String,
         navigationHandler: BookNavigationHandler
    ) {
        self.categoryName = categoryName
        self.category = category
        self.navigationHandler = navigationHandler
        
        fetchData()
    }
    
    
    private func fetchData() {
        let url = "https://api.nytimes.com/svc/books/v3/lists.json?api-key=\(APIKeys.NYTBookApiKey)&list=\(categoryName)"
        let urls = URL(string: url)
        
        URLSession.shared.dataTask(with: urls!) { (data, response, error) in
            
            guard let data = data else { return }
            
            Task {
                do {
                    let decoder = JSONDecoder()
                    
                    let bookJSON = try decoder.decode(NYTBooksJSON.self, from: data).results
                    print(bookJSON)
                    
                    DispatchQueue.main.async { [self] in
                        let bookNames = bookJSON.sorted(by: {$0.displayName < $1.displayName})
                        self.books.append(contentsOf: bookNames)
                        print(books)
                        reloadBooksData.send(())
                        requestState.send(.finished)
                    }
                } catch {
                    self.requestState.send(.failed(error))
                    print(String(describing: error))
                }
            }
            
        }.resume()
    }
    
}
