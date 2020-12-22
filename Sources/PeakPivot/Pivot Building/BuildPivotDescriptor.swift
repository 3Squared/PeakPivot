//
//  BuildPivotDescriptor.swift
//  Bugfender Stats
//
//  Created by Luke Stringer on 27/05/2020.
//  Copyright © 2020 Luke Stringer. All rights reserved.
//

import Foundation

/// Describes how to sort a pivot table
enum BuildPivotDescriptor: Equatable, CaseIterable {
    case byTitle(ascending: Bool = true)
    case byValue(ascending: Bool = true)
    
    static var allCases: [BuildPivotDescriptor] {
        return [
            .byTitle(ascending: true),
            .byTitle(ascending: false),
            .byValue(ascending: true),
            .byValue(ascending: false)
        ]
    }
}

extension BuildPivotDescriptor: Codable {
    enum CodingKeys: String, CodingKey {
       case byTitle, byValue
     }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        if let boolValue = try container.decodeIfPresent(Bool.self, forKey: .byTitle) {
            self = .byTitle(ascending: boolValue)
        }
        else if let boolValue = try container.decodeIfPresent(Bool.self, forKey: .byValue) {
            self = .byValue(ascending: boolValue)
        }
        else {
            throw BuildPivotDescriptorDecodingError.unknownKey
        }
       
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        switch self {
        case .byTitle(let ascending):
            try container.encode(ascending, forKey: .byTitle)
        case .byValue(let ascending):
        try container.encode(ascending, forKey: .byValue)
        }
    }
}

enum BuildPivotDescriptorDecodingError: Error {
    case unknownKey
}
