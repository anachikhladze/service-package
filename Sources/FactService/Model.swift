//
//  File.swift
//  
//
//  Created by Anna Sumire on 20.11.23.
//

import Foundation

public struct FactModel: Decodable {
    public let data: [Fact]
}

public struct Fact: Decodable {
    public let fact: String
}
