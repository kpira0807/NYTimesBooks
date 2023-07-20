import Foundation

struct NYTBooksJSON: Codable {
    
    let status: String
    let num_results: Int
    let copyright: String
    let last_modified: String
    let results: [NYTBooks]
    
}

struct NYTBooks: Codable {
    
    let listName: String
    let displayName: String
    let bestsellersDate: String
    let publishedDate: String
    let rank: Double
    let amazonProductURL: String
    let bookDetails: [NYTBookDetails]
    let reviews: [BookReviews]
    
    enum CodingKeys: String, CodingKey {
        case listName = "list_name"
        case displayName = "display_name"
        case bestsellersDate = "bestsellers_date"
        case publishedDate = "published_date"
        case rank
        case amazonProductURL = "amazon_product_url"
        case bookDetails = "book_details"
        case reviews
    }
    
}

extension NYTBooks {
    
    var title: String {
        return bookDetails[0].title
    }
    
    var shortDescription: String {
        return bookDetails[0].description
    }
    
    var author: String {
        return bookDetails[0].author
    }
    
    var contributor: String {
        return bookDetails[0].contributor
    }
    
    var publisher: String {
        return bookDetails[0].publisher
    }
    
    var review: String {
        return reviews[0].bookReviewLink
    }
}

struct NYTBookDetails: Codable {
    let title: String
    let description: String
    let author: String
    let contributor: String
    let publisher: String
    
    enum CodingKeys: String, CodingKey {
        case title
        case description
        case author
        case contributor
        case publisher
    }
    
}

struct BookReviews: Codable {
    
    let bookReviewLink: String
    let firstChapterLink: String
    let sundayReviewLink: String
    let articleChapterLink: String
    
    enum CodingKeys: String, CodingKey {
        case bookReviewLink = "book_review_link"
        case firstChapterLink = "first_chapter_link"
        case sundayReviewLink = "sunday_review_link"
        case articleChapterLink = "article_chapter_link"
    }
    
}
