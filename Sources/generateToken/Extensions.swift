//

import Foundation

extension Data {
	@inlinable public init?(base64Encoded_fill base64String: __shared String, options: Data.Base64DecodingOptions = []) {
		let alignmentCount = base64String.count % 4
		if alignmentCount == 0 {
			self.init(base64Encoded: base64String, options: options)
		} else {
			self.init(base64Encoded: base64String + String(repeating: "=", count: 4 - alignmentCount), options: options)
		}
	}
}
