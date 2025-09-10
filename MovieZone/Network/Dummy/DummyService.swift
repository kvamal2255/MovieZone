//
//  DummyService.swift
//  MovieZone
//
//  Created by Amal K V on 9/10/25.
//

import Foundation

public protocol DummyServiceDataSource: AnyObject {
    var networker: NetworkerProtocol { get }

    func getMovieList() async -> Result<[MovieDetailData], NetworkError>
}

public final class DummyService: DummyServiceDataSource {
    
    public var networker: NetworkerProtocol
    
    public init(networker: NetworkerProtocol = APIManager.shared) {
        self.networker = networker
    }
    
    public func getMovieList() async -> Result<[MovieDetailData], NetworkError> {
        if let url = URL(string: "https://dummyapi.io/data/v1/movies") {
            return await networker.get(type: [MovieDetailData].self,
                                 url: url,
                                       headers: [ : ])
        }
        return .failure(.apiError(.init(title: "error", message: "Api Link not working")))
    }
    
}

final class MockDummyService: DummyServiceDataSource {

    var movieStateSub: Result<[MovieDetailData], NetworkError>!
    var networker: NetworkerProtocol
    
    init() {
        networker = APIManager.shared
    }
    
    func getMovieList() -> Result<[MovieDetailData], NetworkError> {
        movieStateSub
    }
}


extension Endpoint {

    static var movies: Self {
        return Endpoint(path: "/movies")
    }
}
