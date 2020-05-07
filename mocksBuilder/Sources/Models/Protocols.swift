//
//  Protocols.swift
//  mocksBuilder
//
//  Created by Wagner Sales on 06/05/20.
//  Copyright © 2020 Wagner Sales. All rights reserved.
//

import Foundation

class Protocols {

    let name: String
    let functions: [Functions]

    var classString: String {
        var str = ""
        str += "class " + name + "Mock {"

        str += "\n"
        str += "\n"

        functions.forEach {
            str += $0.variable()
            str += "\n"
        }

        str += "\n"

        functions.forEach {
            str += $0.function()
            str += "\n"
            str += "\n"
        }

        str += "}"
        return str
    }

    init(name: String, functions: [Functions]) {
        self.name = name
        self.functions = functions
    }

    class func readFromString(_ str: String) -> [Protocols] {
        var mocks: [Protocols] = []
        str.matches(start: "protocol", end: "\\{", includeEnd: true).forEach {
            let protocolName = $0
            let functions = Functions.fromString(str, protocolName: protocolName)
            mocks.append(Protocols(name: protocolName, functions: functions))
        }

        return mocks
    }
}
