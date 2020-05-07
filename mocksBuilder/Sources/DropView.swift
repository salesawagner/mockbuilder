//
//  DropView.swift
//  mocksBuilder
//
//  Created by Wagner Sales on 06/05/20.
//  Copyright © 2020 Wagner Sales. All rights reserved.
//

import Cocoa

class DropView: NSView {

    var filePath: String?
    let expectedExt = ["swift"]  //file extensions allowed for Drag&Drop (example: "jpg","png","docx", etc..)

    required init?(coder: NSCoder) {
        super.init(coder: coder)

        self.wantsLayer = true
        self.layer?.backgroundColor = NSColor.gray.cgColor

        registerForDraggedTypes([NSPasteboard.PasteboardType.URL, NSPasteboard.PasteboardType.fileURL])
    }

    override func draggingEntered(_ sender: NSDraggingInfo) -> NSDragOperation {
        if checkExtension(sender) == true {
            self.layer?.backgroundColor = NSColor.blue.cgColor
            return .copy
        } else {
            return NSDragOperation()
        }
    }

    fileprivate func checkExtension(_ drag: NSDraggingInfo) -> Bool {
        guard let board = drag.draggingPasteboard.propertyList(forType: NSPasteboard.PasteboardType(rawValue: "NSFilenamesPboardType")) as? NSArray,
            let path = board[0] as? String
            else { return false }

        let suffix = URL(fileURLWithPath: path).pathExtension
        for ext in self.expectedExt {
            if ext.lowercased() == suffix {
                return true
            }
        }
        return false
    }

    override func draggingExited(_ sender: NSDraggingInfo?) {
        self.layer?.backgroundColor = NSColor.gray.cgColor
    }

    override func draggingEnded(_ sender: NSDraggingInfo) {
        self.layer?.backgroundColor = NSColor.gray.cgColor
    }

    override func performDragOperation(_ sender: NSDraggingInfo) -> Bool {
        guard let pasteboard = sender.draggingPasteboard.propertyList(forType: NSPasteboard.PasteboardType(rawValue: "NSFilenamesPboardType")) as? NSArray,
            let path = pasteboard[0] as? String
            else { return false }
        self.filePath = path
        self.readFile()

        return true
    }

    func readFile() {
        guard let filePath = self.filePath else {
            return
        }

        let path = URL(fileURLWithPath: filePath)
        let text = try? String(contentsOf: path)
        let protocols = Protocols.readFromString(text ?? "")

        Util.chooseDestinationDirectory(window: self.window) { directoryDestinationPath in
            guard let directoryDestinationPath = directoryDestinationPath else {
                _ = AlertManager(message: "Não foi possivel selecionar o diretório de destino")
                return
            }

            let destinationPath = directoryDestinationPath.appendingPathComponent("Mocks.swift")
            _ = Util.writeFile(withPath: destinationPath, content: protocols.fileString)
            NSWorkspace.shared.selectFile(nil, inFileViewerRootedAtPath: directoryDestinationPath.absoluteString)
        }
    }
}
