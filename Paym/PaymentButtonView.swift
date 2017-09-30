//
//  PaymentButtonView.swift
//  Paym
//
//  Created by 1amageek on 2017/07/19.
//  Copyright © 2017年 Stamp Inc. All rights reserved.
//

import UIKit

class PaymentButtonView: UIView {

    var paymentBlock: (() -> Void)?

    let paymentButton: UIButton = {
        let button: UIButton = UIButton(type: .system)
        button.setTitle("注文を確定する", for: .normal)
        button.titleLabel?.numberOfLines = 0
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        button.backgroundColor = button.tintColor
        button.tintColor = .white
        button.addTarget(self, action: #selector(didSelectButton(_:)), for: .touchUpInside)
        return button
    }()

    public convenience init() {
        self.init(frame: .zero)
    }

    public override init(frame: CGRect) {
        super.init(frame: frame)
        _init()
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        _init()
    }

    private func _init() {
        self.translatesAutoresizingMaskIntoConstraints = false
//        self.addSubview(paymentButton)
////        self.centerXAnchor.constraint(equalTo: paymentButton.centerXAnchor, constant: 0).isActive = true
////        self.centerYAnchor.constraint(equalTo: paymentButton.centerYAnchor, constant: 0).isActive = true
    }

    override var intrinsicContentSize: CGSize {
        return CGSize(width: UIViewNoIntrinsicMetric, height: 32)
    }

    @objc func didSelectButton(_ button: UIButton) {
        self.paymentBlock?()
    }
}
