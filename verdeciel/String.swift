//  Created by Devine Lu Linvega on 2015-09-21.
//  Copyright (c) 2016 XXIIVV. All rights reserved.

import Foundation

extension String
{
	func subString( _ start: Int, length: Int) -> String
	{
		var length = length
		var start = start
		if start+length > self.characters.count { length = self.characters.count - start }
		if start > self.characters.count { start = self.characters.count ; length = 0 }
		let range = self.characters.index(self.startIndex, offsetBy: start) ..< self.characters.index(self.startIndex, offsetBy: start + length)
		return self.substring(with: range)
	}
}
