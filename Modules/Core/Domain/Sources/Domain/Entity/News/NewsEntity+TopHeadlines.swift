import Foundation

// MARK: - NewsEntity.TopHeadlines

extension NewsEntity {
  public enum TopHeadlines { }
}

extension NewsEntity.TopHeadlines {
  public struct Request: Equatable, Sendable, Codable {

    // MARK: Lifecycle

    public init(
      country: String = "kr",
      apiKey: String = "5a2ec50f09d14922ad3ca1bdb0a43425",
      category: String,
      page: Int = 1)
    {
      self.country = country
      self.apiKey = apiKey
      self.category = category
      self.page = page
    }

    // MARK: Public

    public let country: String
    public let apiKey: String
    public let category: String
    public let page: Int

    // MARK: Private

    private enum CodingKeys: String, CodingKey {
      case country
      case apiKey
      case category
      case page
    }
  }

  public struct Response: Equatable, Sendable, Codable {
    public let status: String
    public let totalResultCount: Int?
    public let itemList: [Item]

    private enum CodingKeys: String, CodingKey {
      case status
      case totalResultCount = "totalResults"
      case itemList = "articles"
    }
  }

  public struct Item: Equatable, Sendable, Codable {
    public let source: SourceItem
    public let author: String?
    public let title: String?
    public let description: String?
    public let url: String
    public let urlToImage: String?
    public let publishedAt: String

    private enum CodingKeys: String, CodingKey {
      case source
      case author
      case title
      case description
      case url
      case urlToImage
      case publishedAt
    }
  }

  public struct SourceItem: Equatable, Sendable, Codable {
    public let id: String?
    public let name: String?

    private enum CodingKeys: String, CodingKey {
      case id
      case name
    }
  }
}
