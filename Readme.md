# Pnut API Library
Yet another swift pnut api client.

# Installation
use carthage.

# Usage
see PnutAPIClient.

## Secrets.swift
You need to make Secrets.swift for using PnutAPIClient.

Secrets.swift should be looks like

```swift
public struct Secrets: HasSecrets {
    public static var accessKey: String {
        return "YOUR_ACCESS_KEY"
    }

    public static var secretKey: String {
        return "YOUR_SECRET_KEY"
    }
}
```
And, stored in `PnutAPIClient/Secrets/`

Make sure not to upload Secrets.swift to the github.

# Supported APIs
- [x] PUT /users/me
- [x] PATCH /users/me
- [ ] POST /users/me/avatar
- [ ] GET /users/{user_id}/avatar
- [ ] GET /users/{user_id}/cover
- [ ] POST /users/me/cover
- [x] GET /users/{user_id}
- [x] GET /users
- [ ] GET /apps/me/users/ids
- [ ] GET /apps/me/users/tokens
