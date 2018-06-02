struct TokenResponse: Codable {
    struct App: Codable {
        let id: String
        let link: String
        let name: String
    }

    struct Storage: Codable {
        let available: Int
        let total: Int
    }

    let app: App
    let scopes: [String]
    let user: UserResponse
    let storage: Storage
}
