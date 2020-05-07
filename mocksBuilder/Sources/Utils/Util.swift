//
//  Util.swift
//  mocksBuilder
//
//  Created by Wagner Sales on 06/05/20.
//  Copyright © 2020 Wagner Sales. All rights reserved.
//

import Cocoa

class Util: NSObject {

	class func chooseDestinationDirectory(window: NSWindow?, completion: @escaping CompletionDirectory ) {
		guard let window = window else {
			return
		}

		let panel = NSOpenPanel()
		panel.canChooseFiles = false
		panel.canChooseDirectories = true
		panel.allowsMultipleSelection = false

		panel.beginSheetModal(for: window) { result in
			guard result == NSApplication.ModalResponse.OK else {
				completion(nil)
				return
			}
			completion(panel.urls[0])
		}
	}

	class func readFile(withPath path: URL) -> String? {
		do {
			return try String(contentsOf: path)
		} catch let error as NSError {
			_ = AlertManager(message: "Não foi ler o arquivo: \(error)")
			return nil
		}
	}

	class func writeFile(withPath path: URL, content: String) -> Bool {
		do {
			try content.write(to: path, atomically: false, encoding: .utf8)
			return true
		} catch let error as NSError {
			_ = AlertManager(message: "Erro ao criar arquivo: \(error.description)")
			return false
		}
	}

	class func createDirectory(withPath path: URL) -> Bool {

		let manager = FileManager.default
		let directory = path
		var isDirectory: ObjCBool = true

		guard !manager.fileExists(atPath: directory.path, isDirectory: &isDirectory) else {
			_ = AlertManager(message: "A pasta já existe: \(directory.path)")
			return false
		}

		do {
			try manager.createDirectory(at: directory, withIntermediateDirectories: false, attributes: nil)
			_ = AlertManager(message: "pasta criada com sucesso: \(directory.path)")
			return true
		} catch let error as NSError {
			_ = AlertManager(message: "Erro ao criar pasta: \(error.description)")
			return false
		}

	}
}
