import Combine
import Domain
import Foundation

// MARK: - NewsUseCasePlatform

public struct NewsUseCasePlatform {
  let baseURL: String

  public init(baseURL: String = "https://newsapi.org/v2/top-headlines") {
    self.baseURL = baseURL
  }
}

// MARK: NewsUseCase

extension NewsUseCasePlatform: NewsUseCase {
  public var general: (NewsEntity.TopHeadlines.General.Request) -> AnyPublisher<
    NewsEntity.TopHeadlines.General.Response,
    CompositeErrorRepository
  > {
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
