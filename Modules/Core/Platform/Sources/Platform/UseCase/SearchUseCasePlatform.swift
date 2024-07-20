import Combine
import Domain
import Foundation

// MARK: - SearchUseCasePlatform

public struct SearchUseCasePlatform {
  let baseURL: String

  public init(baseURL: String = "https://newsapi.org/v2/everything") {
    self.baseURL = baseURL
  }
}

// MARK: SearchUseCase

extension SearchUseCasePlatform: SearchUseCase {
  public var search: (NewsEntity.Search.Request) -> AnyPublisher<NewsEntity.Search.Response, CompositeErrorRepository> {
    {
      Endpoint(
        baseURL: baseURL,
        pathList: [],
        httpMethod: .get,
        content: .queryItemPath($0))
        .fetch(isDebug: true)
    }
  }
}
