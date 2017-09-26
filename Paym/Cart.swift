//
//  Cart.swift
//  Paym
//
//  Created by 1amageek on 2017/09/21.
//  Copyright © 2017年 Stamp Inc. All rights reserved.
//

import Foundation

public class Cart {

    typealias T = ItemProtocol

    var items: [T] = []

    public func add<T: ItemProtocol>(_ item: T) {
        self.items.append(item)
    }

    public func remove(at index: Int) {
        self.items.remove(at: index)
    }
}
