import Foundation
import OAuthSwift
import APIKit

public protocol API: Request where Response: Codable {
    var credential: OAuthSwiftCredential { get }
}

public extension API {
    var credential: OAuthSwiftCredential {
        do {
            return try APITokenManager.shared.credential()
        } catch let e {
            print(e)
            fatalError()
        }
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

    var bodyParameters: BodyParameters? {
        guard let parameters = parameters as? [String: Any], !method.prefersQueryParameters else {
            return nil
        }

        return FormURLEncodedBodyParameters(formObject: parameters)
    }

    func response(from object: Any, urlResponse: HTTPURLResponse) throws -> Response {
        let data = try JSONSerialization.data(withJSONObject: object, options: [])
        let decoder = JSONDecoder()

        decoder.keyDecodingStrategy = .convertFromSnakeCase
        decoder.dateDecodingStrategy = .iso8601

        if let _ = try? decoder.decode(Response.self, from: data) {
        } else if let value = String(data: data, encoding: .utf8) {
            print(value)
        }

        return try decoder.decode(Response.self, from: data)
    }

    func request(success: ((Self.Response) -> Void)? = nil, failure: ((SessionTaskError) -> Void)? = nil) {
        Session.send(self) { result in
            switch result {
            case .success(let response):
                if let success = success {
                    success(response)
                } else {
                    let encoder = JSONEncoder()
                    encoder.outputFormatting = .prettyPrinted
                    let encoded = try! encoder.encode(response)
                    print(String(data: encoded, encoding: .utf8)!)
                }
            case .failure(let error):
                if let failure = failure {
                    failure(error)
                } else {
                    print(self.baseURL.absoluteString + self.path)
                    print(error)
                }
            }
        }
    }
}

public extension API where Self: Encodable {
    var parameters: Any? {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        let encoded = try! encoder.encode(self)
        return (try? JSONSerialization.jsonObject(with: encoded, options: .allowFragments)).flatMap { $0 as? [String: Any] }
    }
}
