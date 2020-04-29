//
//  Character+Ascii.swift
//  Covirtual
//
//  Created by Bona Deny S on 19/04/20.
//  Copyright © 2020 Bona Deny S. All rights reserved.
//

extension Character {
    var isAscii: Bool {
        return unicodeScalars.allSatisfy { $0.isASCII }
    }
    var ascii: UInt32? {
        return isAscii ? unicodeScalars.first?.value : nil
    }
}
