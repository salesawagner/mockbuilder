//
//  StringExtensions.swift
//  mocksBuilder
//
//  Created by Wagner Sales on 06/05/20.
//  Copyright © 2020 Wagner Sales. All rights reserved.
//

import Foundation

extension String {

    func clean() -> String {
        var str = String(self.filter { !" \n\t\r".contains($0) })
        str = str.replacingOccurrences(of: ":class", with: "")
        return str
    }

    func match(end: String)  -> [String] {
        let regex = "^(.*?)(?=\(end))"
        return self.matches(regex: regex)
    }

    func matches(start: String, end: String, includeEnd: Bool) -> [String] {
        let regex = "(?<=\(start))(.*?)(?=\(end))"
        return self.matches(regex: regex)
    }

    func matches(regex: String) -> [String] {
        let cleaned = self.clean()
        do {
            let regex = try NSRegularExpression(pattern: regex)
            let results = regex.matches(in: cleaned,
                                        range: NSRange(cleaned.startIndex..., in: cleaned))
            return results.map {
                String(cleaned[Range($0.range, in: cleaned)!])
            }
        } catch let error {
            print("💥💥💥 invalid regex: \(error.localizedDescription) 💥💥💥")
            return []
        }
    }
}
