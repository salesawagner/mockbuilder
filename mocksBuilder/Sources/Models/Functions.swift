//
//  Functions.swift
//  mocksBuilder
//
//  Created by Wagner Sales on 06/05/20.
//  Copyright © 2020 Wagner Sales. All rights reserved.
//

import Foundation

class Functions {

    let fullName: String
    var name: String = ""

    init(_ fullName: String) {
        self.fullName = fullName + ")"
        self.getnName()
    }

    private func getnName() {
        self.fullName.match(end: "\\(").forEach {
            self.name = $0
        }
    }

    func variable() -> String {
        return "    var " + self.name + "Called: Bool = false"
    }

    func function() -> String {
        var str = "\n"
        str += "    function " + self.fullName + " {"
        str += "\n"
        str += "        self." + self.name + "Called = true"
        str += "\n"
        str += "    }"
        return str
    }
}

extension Functions {
    class func fromString(_ str: String, protocolName: String) -> [Functions] {
        var functions: [Functions] = []
        str.matches(start: protocolName, end: "\\}", includeEnd: false).forEach { // All Functions
            $0.matches(start: "func", end: "\\)", includeEnd: false).forEach {
                functions.append(Functions($0))
            }
        }

        return functions
    }
}
