//
//  PaymentViewController.swift
//  Paym
//
//  Created by 1amageek on 2017/07/14.
//  Copyright © 2017年 Stamp Inc. All rights reserved.
//

import UIKit
import Stripe

protocol PaymentDelegate: class {
    func payment(_ payment: PaymentViewController, card: Card)
}

class PaymentViewController: UIViewController, CardIOViewDelegate, UIScrollViewDelegate {

    enum InputMode {
        case camera
        case manual
    }

    var inputMode: InputMode = .camera {
        didSet {
            switch inputMode {
            case .camera: self.setupCameraInput()
            case .manual: self.setupManualInput()
            }
        }
    }

    weak var delegate: PaymentDelegate?

    var dismiss: (() -> Void)?

    @objc private func changeInputMode() {
        switch self.inputMode {
        case .camera: self.inputMode = .manual
        case .manual: self.inputMode = .camera
        }
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }

    private(set) lazy var cardIOView: CardIOView = {
        let view: CardIOView = CardIOView(frame: self.view.bounds)
        view.delegate = self
        view.guideColor = UIColor.lightGray
        view.hideCardIOLogo = true
        view.useCardIOLogo = true
        return view
    }()

    private(set) lazy var blurView: UIVisualEffectView = {
        let view: UIVisualEffectView = UIVisualEffectView(effect: nil)
        view.frame = self.view.bounds
        return view
    }()

    private(set) lazy var scrollView: UIScrollView = {
        let view: UIScrollView = UIScrollView(frame: self.view.bounds)
        view.delegate = self
        view.alwaysBounceVertical = true
        view.alwaysBounceHorizontal = false
        let gestureRecognizer: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapGesture(_:)))
        view.addGestureRecognizer(gestureRecognizer)
        return view
    }()

    private(set) lazy var cardView: CardView = {
        let view: CardView = CardView()
        view.completion = { [weak self] card in
            guard let strongSelf: PaymentViewController = self else {
                return
            }
            strongSelf.completed(card: card)
        }
        return view
    }()

    private(set) lazy var manualInputButton: UIButton = {
        let button: UIButton = UIButton(type: .system)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.setTitle("カード番号を手入力する", for: .normal)
        button.sizeToFit()
        button.addTarget(self, action: #selector(changeInputMode), for: .touchUpInside)
        return button
    }()

    private(set) lazy var cancelButton: UIButton = {
        let button: UIButton = UIButton(type: .system)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.setTitle("キャンセル", for: .normal)
        button.sizeToFit()
        button.addTarget(self, action: #selector(cancel), for: .touchUpInside)
        return button
    }()

    override func loadView() {
        super.loadView()
        self.view.backgroundColor = .black
        self.view.addSubview(cardIOView)
        self.view.addSubview(cancelButton)
        self.view.addSubview(manualInputButton)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        if !CardIOUtilities.canReadCardWithCamera() {
            self.inputMode = .manual
        } else {
            // スキャンの遅延防止のためにCardIO SDKのリソースをあらかじめ読み込む
            CardIOUtilities.preloadCardIO()
        }
    }

    override func viewDidLayoutSubviews() {
        self.manualInputButton.frame = CGRect(x: self.view.bounds.width - 12 - self.manualInputButton.bounds.width, y: self.view.bounds.height - 40, width: self.manualInputButton.bounds.width, height: self.manualInputButton.bounds.height)
        self.cancelButton.frame = CGRect(x: 12, y: self.view.bounds.height - 40, width: self.cancelButton.bounds.width, height: self.cancelButton.bounds.height)
    }

    func setupManualInput() {
        self.view.addSubview(self.blurView)
        self.view.addSubview(self.scrollView)
        self.scrollView.addSubview(self.cardView)
        self.cardView.transform = CGAffineTransform(translationX: 0, y: -self.cardView.bounds.height)
        let blurAnimatinor: UIViewPropertyAnimator = UIViewPropertyAnimator(duration: 0.33, dampingRatio: 1) {
            self.blurView.effect = UIBlurEffect(style: .dark)
            self.cardView.transform = CGAffineTransform(translationX: 0, y: 16)
        }
        blurAnimatinor.addCompletion { _ in
            self.view.setNeedsLayout()
            self.cardView.paymentTextField.becomeFirstResponder()
        }
        blurAnimatinor.startAnimation()
    }

    func setupCameraInput() {
        let blurAnimatinor: UIViewPropertyAnimator = UIViewPropertyAnimator(duration: 0.33, dampingRatio: 1) {
            self.blurView.effect = nil
            self.cardView.alpha = 0
        }
        blurAnimatinor.addCompletion { _ in
            self.scrollView.removeFromSuperview()
            self.blurView.removeFromSuperview()
            self.cardView.removeFromSuperview()
            self.cardView.alpha = 1
        }
        blurAnimatinor.startAnimation()
    }

    @objc func tapGesture(_ recognizer: UITapGestureRecognizer) {
        self.inputMode = .camera
    }

    func completed(card: Card) {
        self.delegate?.payment(self, card: card)
        self.dismiss?()
    }

    @objc func cancel() {
        self.dismiss?()
    }

    // MARK: -

    func cardIOView(_ cardIOView: CardIOView!, didScanCard cardInfo: CardIOCreditCardInfo!) {
        guard self.inputMode == .camera else {
            return
        }
        let card: Card = Card(number: cardInfo.cardNumber,
                              expirationMonth: String(cardInfo.expiryMonth),
                              expirationYear: String(cardInfo.expiryYear),
                              cvc: cardInfo.cvv)
        self.completed(card: card)
    }

}
