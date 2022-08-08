# appstore-connect-jwt

An interface for creating JSON web tokens (JWTs) for the App Store Connect API with ease.

## Usage

Creating a **JWT** for the **App Store Connect API** is as easy as:

```swift
import AppStoreConnectToken

let tokenGenerator = AppStoreTokenGenerator(
    keyId: keyId, // The `KeyID` of the active key to use.
    authKey: authKey, // The data of the auth key (.p8) that is related to the `KeyID` - `AuthKey_{:KeyID}.p8`.
    issuerId: issuerId // The `IssuerID` of the creator of the authentication token.
)
let jwt = try tokenGenerator.jwt()
```

...and that's it!.
