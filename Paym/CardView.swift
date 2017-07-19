//
//  CardView.swift
//  Paym
//
//  Created by 1amageek on 2017/07/19.
//  Copyright © 2017年 Stamp Inc. All rights reserved.
//

import UIKit
import Stripe

class CardView: UIView, STPPaymentCardTextFieldDelegate {

    var completion: ((STPCardParams) -> Void)?

    let contentInset: UIEdgeInsets = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)

    private(set) lazy var paymentTextField: STPPaymentCardTextField = {
        let textField: STPPaymentCardTextField = STPPaymentCardTextField()
        textField.delegate = self
        return textField
    }()

    private(set) lazy var completeButton: UIButton = {
        let button: UIButton = UIButton(type: UIButtonType.plain)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
        button.setTitle("完了", for: .normal)
        button.addTarget(self, action: #selector(completed), for: .touchUpInside)
        button.isEnabled = false
        button.sizeToFit()
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(paymentTextField)
        self.addSubview(completeButton)
        self.layer.cornerRadius = 12
        self.backgroundColor = .white
    }

    convenience init() {
        self.init(frame: .zero)
        let width: CGFloat = UIScreen.main.bounds.width - self.contentInset.left - self.contentInset.right
        let height: CGFloat = width / 1.618
        self.frame = CGRect(x: self.contentInset.left, y: 0, width: width, height: height)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        let padding: CGFloat = 15
        self.paymentTextField.frame = CGRect(x: padding, y: self.bounds.height / 2 - 22, width: self.bounds.width - padding * 2, height: 44)
        self.completeButton.center = CGPoint(x: self.bounds.width / 2, y: self.bounds.height - 44)
    }

    @objc func completed() {
        self.completion?(self.paymentTextField.cardParams)
    }

    // MARK: -

    func paymentCardTextFieldDidChange(_ textField: STPPaymentCardTextField) {
        self.completeButton.isEnabled = textField.isValid
    }
}
