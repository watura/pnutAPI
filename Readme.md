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