//
//  StringExtensions.swift
//  writezi
//
//  Created by James Ryan Chen on 21/11/21.
//

import Foundation

public extension String {
    var pinyin: String {
        let stringReference = NSMutableString(string: self) as CFMutableString
        CFStringTransform(stringReference, nil, kCFStringTransformToLatin, false)

        return stringReference as String
    }
}
