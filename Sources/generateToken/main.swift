//

import Foundation
import SwiftJWT

func printTokenContent(_ token: String) {
	let comps = token.components(separatedBy: ".")
	let header = String(data: Data(base64Encoded_fill: comps[0]) ?? Data(), encoding: .utf8)!
	let payload = String(data: Data(base64Encoded_fill: comps[1]) ?? Data(), encoding: .utf8)!
	let signatureBase64 = comps[2]

	print("""
	Header:
	\t\(header)
	Payload:
	\t\(payload)
	Signature:
	\t\(signatureBase64)
	""")
}

func generateToken(teamId: String, keyId: String, keyFileUrl: URL, expiryDuration: Int = 60 * 60 * 24) throws -> String {

	let nowDate = Int(Date().timeIntervalSince1970.rounded())
	let myHeader = Header(kid: keyId)

	struct MyClaims: Claims {
		let iss: String
		let iat: Int
		let exp: Int
	}

	let myClaims = MyClaims(iss: teamId, iat: nowDate, exp: nowDate + expiryDuration * 60)
	var myJWT = SwiftJWT.JWT(header: myHeader, claims: myClaims)

	let token = try myJWT.sign(using: .es256(privateKey: try String(contentsOf: keyFileUrl).data(using: .utf8)!))
	return token
}

guard CommandLine.arguments.count == 4 else {
	print("Usage: generateToken team-id key-id path-to-key-p8")
	exit(-1)
}

do {
	let token = try generateToken(teamId: CommandLine.arguments[1], keyId: CommandLine.arguments[2], keyFileUrl: URL(fileURLWithPath: CommandLine.arguments[3]))

	print("JSON Web Token:")
	print("\"\(token)\"")
	print("")
	printTokenContent(token)


} catch {
	fatalError("\(error)")
}
