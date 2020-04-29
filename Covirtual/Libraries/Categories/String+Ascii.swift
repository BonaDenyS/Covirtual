//
//  String+Ascii.swift
//  Covirtual
//
//  Created by Bona Deny S on 19/04/20.
//  Copyright © 2020 Bona Deny S. All rights reserved.
//

extension StringProtocol {
    var ascii: [UInt32] {
        return compactMap { $0.ascii }
    }
    var string:String{
        var source = self
        var result = ""

        while source.count >= 2 {
            let digitsPerCharacter = source.hasPrefix("1") ? 3 : 2
            let charBytes = source.prefix(digitsPerCharacter)
            source = String(source.dropFirst(digitsPerCharacter)) as! Self
            let number = Int(charBytes)!
            let character = UnicodeScalar(number)!
            result += String(character)
        }

        return result
    }
}
