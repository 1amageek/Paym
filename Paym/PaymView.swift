//
//  PaymView.swift
//  Paym
//
//  Created by 1amageek on 2017/09/26.
//  Copyright © 2017年 Stamp Inc. All rights reserved.
//

import UIKit

public class PaymView: UIView {

    public let summaryView: SummaryView = SummaryView()

    public let cart: Cart

    private(set) lazy var paymentMethodView: PaymentMethodView = {
        let view: PaymentMethodView = PaymentMethodView()
        view.applePayBlock = {

        }
        view.otherPaymentBlock = {
            self.rootView?.isUserInteractionEnabled = false
            let viewController: OrderViewController = OrderViewController()
            let navigationController: NavigationController = NavigationController(rootViewController: viewController)
            self.orderWindow = UIWindow(frame: UIScreen.main.bounds)
            self.orderWindow?.rootViewController = navigationController
            self.orderWindow?.makeKeyAndVisible()
            self.orderWindow?.transform = CGAffineTransform(translationX: 0, y: UIScreen.main.bounds.height)
            // Cancel
            viewController.cancelBlock = { [weak self] in
                guard let `self` = self else { return }
                guard let animator: UIViewPropertyAnimator = self.hideOtherPaymentAnimator() else { return }
                animator.addAnimations {
                    self.orderWindow?.transform = CGAffineTransform(translationX: 0, y: navigationController.view.bounds.height)
                }
                animator.addCompletion({ _ in
                    self.orderWindow = nil
                    self.rootView?.isUserInteractionEnabled = true
                    self.window?.makeKey()
                })
                animator.startAnimation()
            }

            guard let animator: UIViewPropertyAnimator = self.showOtherPaymentAnimator() else { return }
            animator.addAnimations {
                self.orderWindow?.transform = .identity
            }
            animator.startAnimation()

        }
        return view
    }()

    public weak var rootView: UIView?

    private var orderWindow: UIWindow?

    public let blurView: UIVisualEffectView = {
        let view: UIVisualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .extraLight))
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        view.layer.cornerRadius = 16
        return view
    }()

    public let stackView: UIStackView = {
        let view: UIStackView = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .vertical
        view.distribution = .fillProportionally
        view.spacing = 16
        return view
    }()

    public init(rootView: UIView? = nil, cart: Cart) {
        self.cart = cart
        self.rootView = rootView
        super.init(frame: .zero)
        _init()
    }

    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func _init() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(blurView)
        self.blurView.contentView.addSubview(stackView)
        blurView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0).isActive = true
        blurView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0).isActive = true
        blurView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
        blurView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
        stackView.leadingAnchor.constraint(equalTo: blurView.leadingAnchor, constant: 10).isActive = true
        stackView.trailingAnchor.constraint(equalTo: blurView.trailingAnchor, constant: -10).isActive = true
        stackView.topAnchor.constraint(equalTo: blurView.topAnchor, constant: 12).isActive = true
        stackView.bottomAnchor.constraint(equalTo: blurView.bottomAnchor, constant: -12).isActive = true
        stackView.addArrangedSubview(summaryView)
        stackView.addArrangedSubview(paymentMethodView)
    }

    public override func didMoveToSuperview() {
        super.didMoveToSuperview()
        if !self.translatesAutoresizingMaskIntoConstraints {
            guard let superView: UIView = self.superview else { return }
            superView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: -16).isActive = true
            superView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 16).isActive = true
            superView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 24).isActive = true
        }
    }

    private func showOtherPaymentAnimator() -> UIViewPropertyAnimator? {
        guard let view: UIView = self.rootView else { return nil }
        let animator: UIViewPropertyAnimator = UIViewPropertyAnimator(duration: 0.43, dampingRatio: 0.75) {
            view.window?.transform = CGAffineTransform(scaleX: 0.92, y: 0.92)
            view.window?.alpha = 0.8
        }
        return animator
    }

    private func hideOtherPaymentAnimator() -> UIViewPropertyAnimator? {
        guard let view: UIView = self.rootView else { return nil }
        let animator: UIViewPropertyAnimator = UIViewPropertyAnimator(duration: 0.43, dampingRatio: 0.75) {
            view.window?.transform = .identity
            view.window?.alpha = 1
        }
        return animator
    }
}
