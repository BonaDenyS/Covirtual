//
//  Case.swift
//  Covirtual
//
//  Created by Bona Deny S on 19/04/20.
//  Copyright © 2020 Bona Deny S. All rights reserved.
//

import Foundation

// MARK: - Case
class Case: Codable {
    let attributes: Attributes
    let geometry: Geometry

    init(attributes: Attributes, geometry: Geometry) {
        self.attributes = attributes
        self.geometry = geometry
    }
}

// MARK: Case convenience initializers and mutators

extension Case {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(Case.self, from: data)
        self.init(attributes: me.attributes, geometry: me.geometry)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        attributes: Attributes? = nil,
        geometry: Geometry? = nil
    ) -> Case {
        return Case(
            attributes: attributes ?? self.attributes,
            geometry: geometry ?? self.geometry
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Attributes
class Attributes: Codable {
    let fid, kodeProvi: Int
    let provinsi: String
    let kasusPosi, kasusSemb, kasusMeni: Int

    enum CodingKeys: String, CodingKey {
        case fid = "FID"
        case kodeProvi = "Kode_Provi"
        case provinsi = "Provinsi"
        case kasusPosi = "Kasus_Posi"
        case kasusSemb = "Kasus_Semb"
        case kasusMeni = "Kasus_Meni"
    }

    init(fid: Int, kodeProvi: Int, provinsi: String, kasusPosi: Int, kasusSemb: Int, kasusMeni: Int) {
        self.fid = fid
        self.kodeProvi = kodeProvi
        self.provinsi = provinsi
        self.kasusPosi = kasusPosi
        self.kasusSemb = kasusSemb
        self.kasusMeni = kasusMeni
    }
}

// MARK: Attributes convenience initializers and mutators

extension Attributes {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(Attributes.self, from: data)
        self.init(fid: me.fid, kodeProvi: me.kodeProvi, provinsi: me.provinsi, kasusPosi: me.kasusPosi, kasusSemb: me.kasusSemb, kasusMeni: me.kasusMeni)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        fid: Int? = nil,
        kodeProvi: Int? = nil,
        provinsi: String? = nil,
        kasusPosi: Int? = nil,
        kasusSemb: Int? = nil,
        kasusMeni: Int? = nil
    ) -> Attributes {
        return Attributes(
            fid: fid ?? self.fid,
            kodeProvi: kodeProvi ?? self.kodeProvi,
            provinsi: provinsi ?? self.provinsi,
            kasusPosi: kasusPosi ?? self.kasusPosi,
            kasusSemb: kasusSemb ?? self.kasusSemb,
            kasusMeni: kasusMeni ?? self.kasusMeni
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Geometry
class Geometry: Codable {
    let x, y: Double

    init(x: Double, y: Double) {
        self.x = x
        self.y = y
    }
}

// MARK: Geometry convenience initializers and mutators

extension Geometry {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(Geometry.self, from: data)
        self.init(x: me.x, y: me.y)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        x: Double? = nil,
        y: Double? = nil
    ) -> Geometry {
        return Geometry(
            x: x ?? self.x,
            y: y ?? self.y
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Helper functions for creating encoders and decoders

func newJSONDecoder() -> JSONDecoder {
    let decoder = JSONDecoder()
    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
        decoder.dateDecodingStrategy = .iso8601
    }
    return decoder
}

func newJSONEncoder() -> JSONEncoder {
    let encoder = JSONEncoder()
    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
        encoder.dateEncodingStrategy = .iso8601
    }
    return encoder
}
