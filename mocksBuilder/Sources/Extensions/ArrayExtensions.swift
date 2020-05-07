//
//  ArrayExtensions.swift
//  mocksBuilder
//
//  Created by Wagner Sales on 07/05/20.
//  Copyright © 2020 Wagner Sales. All rights reserved.
//

import Foundation

extension Array where Element: Protocols {

    var fileString: String {
        var str = ""
        self.forEach {
            str += $0.classString
            str += "\n"
            str += "\n"
        }
        return str
    }

    func names() {
        self.forEach {
            print($0.name)
        }
    }
}
