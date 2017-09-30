//
//  PaymentMethodView.swift
//  Paym
//
//  Created by 1amageek on 2017/07/10.
//  Copyright © 2017年 Stamp Inc. All rights reserved.
//

import UIKit

public class PaymentMethodView: UIView {

    public var otherPaymentBlock: (() -> Void)?

    public var applePayBlock: (() -> Void)?

    public let contentInset: UIEdgeInsets = UIEdgeInsets(top: 6, left: 12, bottom: 6, right: 12)

    private(set) lazy var stackView: UIStackView = {
        let view: UIStackView = UIStackView(frame: self.bounds)
        view.axis = .horizontal
        view.translatesAutoresizingMaskIntoConstraints = false
        view.distribution = .fillEqually
        view.spacing = 8
        return view
    }()

    public let otherPaymentButton: UIButton = {
        let button: UIButton = UIButton(type: .system)
        button.setTitle("Buy with other \npayment options", for: .normal)
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        button.titleLabel?.numberOfLines = 0
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.backgroundColor = .white
        button.layer.borderColor = button.tintColor.cgColor
        button.layer.borderWidth = 0.5
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(didSelectButton(_:)), for: .touchUpInside)
        return button
    }()

    public let applePayButton: UIButton = {
        let button: UIButton = UIButton(type: .system)
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        button.setTitle("Pay", for: .normal)
        button.backgroundColor = .black
        button.tintColor = .white
        button.titleLabel?.numberOfLines = 0
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.font = UIFont.systemFont(ofSize: 28)
        button.translatesAutoresizingMaskIntoConstraints = false
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
        self.addSubview(stackView)
        self.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 0).isActive = true
        self.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: 0).isActive = true
        self.topAnchor.constraint(equalTo: stackView.topAnchor, constant: 0).isActive = true
        self.bottomAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 0).isActive = true
        stackView.addArrangedSubview(otherPaymentButton)
        stackView.addArrangedSubview(applePayButton)
    }

    public override var intrinsicContentSize: CGSize {
        return CGSize(width: UIViewNoIntrinsicMetric, height: 48)
    }

    @objc public func didSelectButton(_ button: UIButton) {
        if button == self.applePayButton {
            self.applePayBlock?()
        } else {
            self.otherPaymentBlock?()
        }
    }
}
