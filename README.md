![Swift Version](https://img.shields.io/badge/Swift-5.0-orange.svg)
[![SwiftPM compatible](https://img.shields.io/badge/SwiftPM-compatible-brightgreen.svg)](https://github.com/apple/swift-package-manager)
![Platform](https://img.shields.io/badge/platform-osx-lightgrey.svg)

## SwiftJWTSample

Sample for generating a JSON Web Token with <https://github.com/IBM-Swift/Swift-JWT.git>

## Usage:

`swift run generateToken <team-id> <key-id> path_to_keys/AuthKey.p8`


## Sample invocation:

	SwiftJWTSample$ swift run generateToken JJXPCWBWAJ G7HMGM8QA mykeys/AuthKey_G7HMGM8QA.p8

	JSON Web Token:
	"eyJ0eXAiOiJKV1QiLCJhbGciOiJFUzI1NiIsImtpZCI6Ikc3SE1HTThRQSJ9.eyJpc3MiOiJKSlhQQ1dCV0FKIiwiaWF0IjoxNTYwNzY5MDg4LCJleHAiOjE1NjU5NTMwODh9.ychIfPAv9zEl3ko-SHSIq0ngbh6qwAoS6K7e4wwUT9iPY7f2lXlnsXjbs3a5UuUb16V3y1vcKE_hPvfm5-CJQg"
	
	Header:
	{"typ":"JWT","alg":"ES256","kid":"G7HMGM8QA"}
	Payload:
	{"iss":"JJXPCWBWAJ","iat":1560769088,"exp":1565953088}
	Signature:
	ychIfPAv9zEl3ko-SHSIq0ngbh6qwAoS6K7e4wwUT9iPY7f2lXlnsXjbs3a5UuUb16V3y1vcKE_hPvfm5-CJQg

## Code

It's more or less only an invocation of the SwiftJWT API:

	struct MyClaims: Claims {
		let iss: String
		let iat: Int
		let exp: Int
	}

	let myHeader = Header(kid: keyId)
	let myClaims = MyClaims(iss: teamId, iat: Date(), exp: Date() +  24 * 60 * 60)
	var myJWT = SwiftJWT.JWT(header: myHeader, claims: myClaims)

	let token = try! myJWT.sign(using: .es256(privateKey: try! String(contentsOf: keyFileUrl).data(using: .utf8)!))


## Reference
* JWT spec: <https://tools.ietf.org/html/rfc7519>
* JWT debugger / libraries: <http://jwt.io>
* Apple: <https://developer.apple.com/documentation/applemusicapi/getting_keys_and_creating_tokens>

	> 	After you create the token, sign it with your MusicKit private key. Then encrypt the token using the Elliptic Curve Digital Signature Algorithm (ECDSA) with the P-256 curve and the SHA-256 hash algorithm. Specify the value ES256 in the algorithm header key (alg).

