//
//  PaymentViewController.swift
//  Paym
//
//  Created by 1amageek on 2017/07/14.
//  Copyright © 2017年 Stamp Inc. All rights reserved.
//

import UIKit
import Stripe

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

    @objc private func changeInputMode() {
        switch self.inputMode {
        case .camera: self.inputMode = .manual
        case .manual: self.inputMode = .camera
        }
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
        view.completion = { cardParams in

        }
        return view
    }()

    private(set) lazy var manualInputButton: UIButton = {
        let button: UIButton = UIButton(type: .plain)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.setTitle("カード番号を手入力する", for: .normal)
        button.sizeToFit()
        button.addTarget(self, action: #selector(changeInputMode), for: .touchUpInside)
        return button
    }()

    private(set) lazy var cameraInputButton: UIButton = {
        let button: UIButton = UIButton(type: .plain)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.setTitle("カード番号をカメラで入力する", for: .normal)
        button.sizeToFit()
        button.addTarget(self, action: #selector(changeInputMode), for: .touchUpInside)
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
            self.inputMode = .manual
        } else {
            // スキャンの遅延防止のためにCardIO SDKのリソースをあらかじめ読み込む
            CardIOUtilities.preloadCardIO()
        }
    }

    override func viewDidLayoutSubviews() {
        self.manualInputButton.center = CGPoint(x: self.view.bounds.width / 2, y: self.view.bounds.height - 40)
    }

    func setupManualInput() {
        self.view.addSubview(blurView)
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

    // MARK: -

    func cardIOView(_ cardIOView: CardIOView!, didScanCard cardInfo: CardIOCreditCardInfo!) {
        print(cardInfo)
    }

}
