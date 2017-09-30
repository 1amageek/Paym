//
//  PaymItemProtocol.swift
//  Paym
//
//  Created by 1amageek on 2017/09/21.
//  Copyright © 2017年 Stamp Inc. All rights reserved.
//

import Foundation

public struct Dimension {
    let width: CGFloat
    let height: CGFloat
    let depth: CGFloat
}

public protocol ItemProtocol {

    var id: String { get }

    var status: Bool { get }

    var image: URL? { get }

    var name: String? { get }

    var caption: String? { get }

    var desc: String? { get }

    var tax: Float { get }

    var price: Float { get }

    var url: URL? { get }

    var dimensions: Dimension? { get }

    var weight: CGFloat? { get }

    var quantity: Int { get set }
}

extension ItemProtocol {
    
    var image: URL? { return nil }

    var name: String? { return nil }

    var caption: String? { return nil }

    var desc: String? { return nil }

    var url: URL? { return nil }

    var dimensions: Dimension? { return nil }

    var weight: CGFloat? { return nil }
}

extension ItemProtocol {
    
    var hashValue: Int {
        return self.id.hash
    }

    static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.id == rhs.id
    }

    mutating func add() {
        self.quantity += 1
    }

    mutating func remove() {
        self.quantity -= 1
    }
}
