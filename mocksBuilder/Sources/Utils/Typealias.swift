//
//  Typealias.swift
//  mocksBuilder
//
//  Created by Wagner Sales on 06/05/20.
//  Copyright © 2020 Wagner Sales. All rights reserved.
//

import Foundation

typealias CompletionDirectory = (_ directoryPath: URL?) -> Void
typealias CompletionResult = (Result) -> Void

enum Result {
    case Success
	case Failure
}
