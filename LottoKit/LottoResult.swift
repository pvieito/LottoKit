//
//  LottoResult.swift
//  LottoKit
//
//  Created by Pedro José Pereira Vieito on 30/12/2017.
//  Copyright © 2017 Pedro José Pereira Vieito. All rights reserved.
//

import Foundation

public struct LottoResult: Decodable {
    public let number: Int
    public let prize: Double
    private let timestamp: Date
    private let status: Int
    private let error: Int
    
    private enum CodingKeys: String, CodingKey {
        case number = "numero"
        case prize = "premio"
        case timestamp
        case status
        case error
    }
}

extension LottoResult: CustomStringConvertible {
    public var description: String {
        return "\(String(format: "%05d", self.number)): \(self.prize)€"
    }
}
