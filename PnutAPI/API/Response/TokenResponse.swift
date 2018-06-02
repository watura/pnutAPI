public struct TokenResponse: Codable {
    public struct App: Codable {
        public let id: String
        public let link: String
        public let name: String
    }

    public struct Storage: Codable {
        public let available: Int
        public let total: Int
    }

    public let app: App
    public let scopes: [String]
    public let user: UserResponse
    public let storage: Storage
}
