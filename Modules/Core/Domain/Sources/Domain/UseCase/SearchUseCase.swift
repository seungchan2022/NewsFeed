import Combine

public protocol SearchUseCase {
  var search: (NewsEntity.Search.Request) -> AnyPublisher<NewsEntity.Search.Response, CompositeErrorRepository> { get }
}
