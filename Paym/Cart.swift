//
//  Cart.swift
//  Paym
//
//  Created by 1amageek on 2017/09/21.
//  Copyright © 2017年 Stamp Inc. All rights reserved.
//

import Foundation

public class Cart {

    public class Window: UIWindow {

    }

    public let window: Window = Window(frame: UIScreen.main.bounds)

    public let summaryView: SummaryView = SummaryView()

    public let paymentMethodView: PaymentMethodView = PaymentMethodView()

    public var items: [ItemProtocol] = []

    public func add<T: ItemProtocol>(_ item: T) {
        self.items.append(item)
    }

    public func remove(at index: Int) {
        self.items.remove(at: index)
    }

    public init(_ items: [ItemProtocol] = [], view: UIView) {
        self.items = items

        

    }

    public func layoutSummaryView() {
        summaryView.sizeToFit()
        let contentSize: CGSize = summaryView.bounds.size
        summaryView.frame = CGRect(x: 0, y: 0, width: contentSize.width, height: contentSize.height)
    }

}
