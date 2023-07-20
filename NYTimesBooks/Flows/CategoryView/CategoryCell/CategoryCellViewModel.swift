import Foundation
import UIKit

final class CategoryCellViewModel {
    
    let name: String
    let time: String
    let onSelect: () -> Void
    
    init(
        name: String,
        time: String,
        onSelect: @escaping () -> Void
    ) {
        self.name = name
        self.time = time
        self.onSelect = onSelect
    }
    
}
