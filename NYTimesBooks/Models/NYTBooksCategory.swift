import Foundation

struct NYTBooksCategoryJSON: Codable {
    
    let status: String
    let num_results: Int
    let copyright: String
    let results: [NYTBooksCategory]
    
}

struct NYTBooksCategory: Codable {
    
    let listName: String
    let listNameEncoded: String
    let displayName: String
    let updated: String
    let newestPublishedDate: String
    let oldestPublishedDate: String


    enum CodingKeys: String, CodingKey {
        case listName = "list_name"
        case listNameEncoded = "list_name_encoded"
        case displayName = "display_name"
        case updated
        case newestPublishedDate = "newest_published_date"
        case oldestPublishedDate = "oldest_published_date"
    }
    
}
