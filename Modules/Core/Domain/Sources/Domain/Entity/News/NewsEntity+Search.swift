import Foundation

// MARK: - NewsEntity.Search

extension NewsEntity {
  public enum Search { }
}

extension NewsEntity.Search {
  public struct Request: Equatable, Sendable, Codable {

    // MARK: Lifecycle

    public init(
      query: String ,
      apiKey: String = "5a2ec50f09d14922ad3ca1bdb0a43425",
      from: String,
      page: Int = 1,
      perPage: Int)
    {
      self.query = query
      self.apiKey = apiKey
      self.from = from
      self.page = page
      self.perPage = perPage
    }

    // MARK: Public

    public let query: String
    public let apiKey: String
    public let from: String
    public let page: Int
    public let perPage: Int

    // MARK: Private

    private enum CodingKeys: String, CodingKey {
      case query = "q"
      case apiKey
      case from
      case page
      case perPage = "pageSize"
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

// MARK: - NewsEntity.Search.Composite

extension NewsEntity.Search {
  public struct Composite: Equatable, Sendable {
    public let request: NewsEntity.Search.Request
    public let response: NewsEntity.Search.Response

    public init(
      request: NewsEntity.Search.Request,
      response: NewsEntity.Search.Response)
    {
      self.request = request
      self.response = response
    }
  }
}
