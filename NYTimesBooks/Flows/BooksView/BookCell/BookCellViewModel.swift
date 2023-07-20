import Foundation
import UIKit

final class BookCellViewModel {
    
    let name: String
    let description: String
    let author: String
    let publisher: String
    let rank: String
    
    
    init(
        name: String,
        description: String,
        author: String,
        publisher: String,
        rank: String
    ) {
        self.name = name
        self.description = description
        self.author = author
        self.publisher = publisher
        self.rank = rank
    }
    
}
