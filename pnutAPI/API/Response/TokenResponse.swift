struct TokenResponse: Decodable {
    struct App: Decodable {
        let id: String
        let link: String
        let name: String
    }

    struct Storage: Decodable {
        let available: Int
        let total: Int
    }

    let app: App
    let scopes: [String]
    let user: UserResponse
    let storage: Storage
}
