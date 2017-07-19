//
//  Paymentable.swift
//  Paym
//
//  Created by 1amageek on 2017/07/10.
//  Copyright © 2017年 Stamp Inc. All rights reserved.
//

import UIKit

struct Dimension {
    let width: CGFloat
    let height: CGFloat
    let depth: CGFloat
}

protocol Paymentable {

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
}
