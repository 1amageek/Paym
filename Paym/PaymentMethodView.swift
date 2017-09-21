//
//  PaymentMethodView.swift
//  Paym
//
//  Created by 1amageek on 2017/07/10.
//  Copyright © 2017年 Stamp Inc. All rights reserved.
//

import UIKit

class PaymentMethodView: UIView {

    var height: CGFloat = 56 {
        didSet {
            self.setNeedsUpdateConstraints()
        }
    }

    var otherPaymentBlock: (() -> Void)?

    var applePayBlock: (() -> Void)?

    let contentInset: UIEdgeInsets = UIEdgeInsets(top: 6, left: 12, bottom: 6, right: 12)

    private(set) lazy var stackView: UIStackView = {
        let view: UIStackView = UIStackView(frame: self.bounds)
        view.axis = .horizontal
        view.translatesAutoresizingMaskIntoConstraints = false
        view.distribution = .fillEqually
        view.spacing = 8
        return view
    }()

    let otherPaymentButton: UIButton = {
        let button: UIButton = UIButton(type: .system)
        button.setTitle("Buy with other \npayment options", for: .normal)
        button.titleLabel?.numberOfLines = 0
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.backgroundColor = .white
        button.layer.borderColor = button.tintColor.cgColor
        button.layer.borderWidth = 0.5
        button.addTarget(self, action: #selector(didSelectButton(_:)), for: .touchUpInside)
        return button
    }()

    let applePayButton: UIButton = {
        let button: UIButton = UIButton(type: .system)
        button.setTitle("Pay", for: .normal)
        button.backgroundColor = .black
        button.tintColor = .white
        button.titleLabel?.numberOfLines = 0
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.font = UIFont.systemFont(ofSize: 28)
        button.addTarget(self, action: #selector(didSelectButton(_:)), for: .touchUpInside)
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(stackView)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = .white
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowRadius = 2
        self.layer.shadowOffset = CGSize(width: 0, height: 0)
        self.layer.shadowOpacity = 0.25
        stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: contentInset.left).isActive = true
        stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -contentInset.right).isActive = true
        stackView.topAnchor.constraint(equalTo: self.topAnchor, constant: contentInset.top).isActive = true
        stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -contentInset.bottom).isActive = true
        stackView.addArrangedSubview(otherPaymentButton)
        stackView.addArrangedSubview(applePayButton)
    }

    convenience init() {
        self.init(frame: .zero)
    }

    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private var heightConstraint: NSLayoutConstraint?

    private var leadingConstraint: NSLayoutConstraint?

    private var trailingConstraint: NSLayoutConstraint?

    private var bottomConstraint: NSLayoutConstraint?

    public override func updateConstraints() {
        self.removeConstraints([self.heightConstraint,
                                self.leadingConstraint,
                                self.trailingConstraint,
                                self.bottomConstraint
            ].flatMap({ return $0 }))
        self.heightConstraint = self.heightAnchor.constraint(greaterThanOrEqualToConstant: self.height)
        self.heightConstraint?.isActive = true
        self.leadingConstraint = self.leadingAnchor.constraint(equalTo: self.superview!.leadingAnchor)
        self.trailingConstraint = self.trailingAnchor.constraint(equalTo: self.superview!.trailingAnchor)
        self.leadingConstraint?.isActive = true
        self.trailingConstraint?.isActive = true
        self.bottomConstraint = self.bottomAnchor.constraint(equalTo: self.superview!.bottomAnchor, constant: 0)
        self.bottomConstraint?.isActive = true
        super.updateConstraints()
    }

    @objc func didSelectButton(_ button: UIButton) {
        if button == self.applePayButton {
            self.applePayBlock?()
        } else {
            self.otherPaymentBlock?()
        }
    }

}
