import Combine

public protocol NewsUseCase {
  var news: (NewsEntity.TopHeadlines.Request) -> AnyPublisher<
    NewsEntity.TopHeadlines.Response,
    CompositeErrorRepository
  > { get }
}
