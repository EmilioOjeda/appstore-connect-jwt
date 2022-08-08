import JWTKit
import Foundation

extension AppStoreTokenGenerator {
    struct Payload: JWTPayload {
        let iss: IssuerClaim
        let aud: AudienceClaim
        let exp: ExpirationClaim

        init(iss: String, exp: Date, aud: String = "appstoreconnect-v1") {
            self.iss = IssuerClaim(value: iss)
            self.exp = ExpirationClaim(value: exp)
            self.aud = AudienceClaim(value: aud)
        }

        func verify(using signer: JWTSigner) throws {
            try exp.verifyNotExpired()
        }
    }
}
