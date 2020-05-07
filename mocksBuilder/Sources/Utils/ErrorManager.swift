//
//  AlertManager.swift
//  mocksBuilder
//
//  Created by Wagner Sales on 06/05/20.
//  Copyright © 2020 Wagner Sales. All rights reserved.
//

import Foundation

struct AlertManager {
	let message: String

	init(message: String) {
		self.message = message
		self.printError()
	}

	private func printError() {
		print("========================")
		print(self.message)
		print("========================")
		print("")
	}
}
