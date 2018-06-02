import Foundation
import OAuthSwift
import APIKit

protocol API: Request where Response: Codable {
    var credential: OAuthSwiftCredential { get }
}

extension API {
    var credential: OAuthSwiftCredential {
        return APITokenManager().credential
    }

    var baseURL: URL {
        guard let url = URL(string: "https://api.pnut.io/v0/") else { fatalError() }
        return url
    }

    func intercept(urlRequest: URLRequest) throws -> URLRequest {
        let url = self.baseURL.absoluteString + self.path

        let header = credential.makeHeaders(URL(string: url)!,
                                            method: OAuthSwiftHTTPRequest.Method(rawValue: urlRequest.httpMethod!)!,
                                            parameters: self.parameters as? [String: Any] ?? [:])

        var mutableRequest = urlRequest
        for (field, value) in header {
            mutableRequest.setValue(value, forHTTPHeaderField: field)
        }
        return mutableRequest
    }

    func response(from object: Any, urlResponse: HTTPURLResponse) throws -> Response {
        let data = try JSONSerialization.data(withJSONObject: object, options: [])
        let decoder = JSONDecoder()

        decoder.keyDecodingStrategy = .convertFromSnakeCase
        decoder.dateDecodingStrategy = .iso8601

        return try decoder.decode(Response.self, from: data)
    }

    func request(success: @escaping (Self.Response) -> Void, failure: @escaping (SessionTaskError) -> Void) {
        Session.send(self) { result in
            switch result {
            case .success(let response):
                success(response)
            case .failure(let error):
                failure(error)
            }
        }
    }
}
