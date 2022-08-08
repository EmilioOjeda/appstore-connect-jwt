import JWTKit
import Foundation

/// It provides an easy-to-use interface for generating valid **JSON web tokens** (a.k.a. `JWTs`) that can be used for the **AppStore Connect API**.
public struct AppStoreTokenGenerator {
    /// The `KeyID` of the active key to use.
    public let keyId: String
    /// The data of the auth key (.p8) that is related to the `KeyID` - `AuthKey_{:KeyID}.p8`.
    public let authKey: Data
    /// The `IssuerID` of the creator of the authentication token.
    public let issuerId: String
    /// The interval - in minutes - between the token creation date and its expiration.
    let expirationTime: Int
    /// A function for setting the timestamp of the token creation.
    let nowDateGenerator: () -> Date

    /// Generator that produces a **JSON web token** (a.k.a. `JWT`) that can be used for the AppStore Connect API.
    /// - Parameters:
    ///   - keyId: The `KeyID` of the active key to use.
    ///   - authKey: The data of the auth key (.p8) that is related to the `KeyID` - `AuthKey_{:KeyID}.p8`.
    ///   - issuerId: The `IssuerID` of the creator of the authentication token.
    ///   - expirationTime: The interval - in minutes - between the token creation date and its expiration.
    ///   It is set to **20 minutes** by default, which is the maximum expiration time allowed.
    ///   - nowDateGenerator: A function for setting the timestamp of the token creation - `Date()` is set by default.
    ///   The expiration time (`expirationTime`) will be calculated from any date produced by this function.
    public init(
        keyId: String,
        authKey: Data,
        issuerId: String,
        expirationTime: Int = 20,
        nowDateGenerator: @escaping () -> Date = Date.init) {
            self.keyId = keyId
            self.authKey = authKey
            self.issuerId = issuerId
            self.expirationTime = expirationTime
            self.nowDateGenerator = nowDateGenerator
        }

    /// It produces a **JWT** from the data given to the generator.
    ///
    /// An error is thrown when the token cannot be generated successfully.
    /// - Returns: A **JSON web token** (a.k.a. `JWT`) that can be used for the AppStore Connect API.
    public func jwt() throws -> String {
        let signer = try JWTSigner.es256(key: .private(pem: authKey))

        let minutes = max(1, min(expirationTime, 20))
        let expirationDate = Date(
            timeInterval: TimeInterval(minutes) * 60,
            since: nowDateGenerator())

        let payload = Payload(iss: issuerId, exp: expirationDate)

        try payload.verify(using: signer)

        return try signer.sign(payload, kid: JWKIdentifier(string: keyId))
    }
}
