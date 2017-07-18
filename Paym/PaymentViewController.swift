//
//  PaymentViewController.swift
//  Paym
//
//  Created by 1amageek on 2017/07/14.
//  Copyright © 2017年 Stamp Inc. All rights reserved.
//

import UIKit
import Stripe

class PaymentViewController: UIViewController, STPPaymentCardTextFieldDelegate, CardIOViewDelegate {

    enum InputMode {
        case camera
        case manual

        func layout() {
            switch self {
            case .camera: return
            case .manual: return
            }
        }
    }

    private(set) lazy var paymentTextField: STPPaymentCardTextField = {
        let textField: STPPaymentCardTextField = STPPaymentCardTextField()
        textField.delegate = self
        return textField
    }()

    private(set) lazy var blurView: UIVisualEffectView = {
        let view: UIVisualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: UIBlurEffectStyle.dark))
        view.frame = self.view.bounds
        return view
    }()

    private(set) lazy var cardIOView: CardIOView = {
        let view: CardIOView = CardIOView(frame: self.view.bounds)
        view.delegate = self
        view.guideColor = UIColor.lightGray
        view.hideCardIOLogo = true
        view.useCardIOLogo = true
        return view
    }()

    private(set) lazy var manualInputButton: UIButton = {
        let button: UIButton = UIButton(type: .plain)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.setTitle("カード番号を手入力する", for: .normal)
        button.sizeToFit()
        button.addTarget(self, action: #selector(setupManualInput), for: .touchUpInside)
        return button
    }()

    private(set) lazy var cameraInputButton: UIButton = {
        let button: UIButton = UIButton(type: .plain)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.setTitle("カード番号をカメラで入力する", for: .normal)
        button.sizeToFit()
        button.addTarget(self, action: #selector(setupManualInput), for: .touchUpInside)
        return button
    }()

    override func loadView() {
        super.loadView()
        self.view.backgroundColor = .black
        self.view.addSubview(cardIOView)
        self.view.addSubview(manualInputButton)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        if !CardIOUtilities.canReadCardWithCamera() {
            self.setupManualInput()
        } else {
            // スキャンの遅延防止のためにCardIO SDKのリソースをあらかじめ読み込む
            CardIOUtilities.preloadCardIO()
        }
    }

    @objc func setupManualInput() {
        self.view.addSubview(blurView)
        self.view.addSubview(paymentTextField)
        let padding: CGFloat = 15
        paymentTextField.frame = CGRect(x: padding, y: 100, width: self.view.bounds.width - padding * 2, height: 44)
    }

    override func viewDidLayoutSubviews() {
        self.manualInputButton.center = CGPoint(x: self.view.bounds.width / 2, y: self.view.bounds.height - 40)
    }

    // MARK: -

    func cardIOView(_ cardIOView: CardIOView!, didScanCard cardInfo: CardIOCreditCardInfo!) {
        print(cardInfo)
    }

}
