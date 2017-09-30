//
//  CartViewController.swift
//  Paym
//
//  Created by 1amageek on 2017/07/09.
//  Copyright © 2017年 Stamp Inc. All rights reserved.
//

import UIKit

class CartViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    private(set) lazy var tableView: UITableView = {
        let view: UITableView = UITableView(frame: self.view.bounds, style: .plain)
        view.dataSource = self
        view.delegate = self
        view.register(UINib(nibName: "CartViewCell", bundle: nil), forCellReuseIdentifier: "CartViewCell")
        return view
    }()

    private(set) lazy var summaryView: SummaryView = {
        let view: SummaryView = SummaryView()
        return view
    }()

    private var window: UIWindow?

    private(set) lazy var paymentMethodView: PaymentMethodView = {
        let view: PaymentMethodView = PaymentMethodView()
        view.applePayBlock = {

        }
//        view.otherPaymentBlock = {
//            self.tableView.isUserInteractionEnabled = false
//            let viewController: OrderViewController = OrderViewController()
//            let navigationController: OrderNavigationController = OrderNavigationController(rootViewController: viewController)
//            let contentSize: CGSize = viewController.calculateSize()
//            let targetHeight: CGFloat = self.view.bounds.height - contentSize.height
//            self.window = UIWindow(frame: CGRect(x: 0, y: targetHeight, width: contentSize.width, height: contentSize.height))
//            self.window?.rootViewController = navigationController
//            navigationController.view.frame = self.window!.bounds
//            self.window?.makeKeyAndVisible()
//            // Cancel
//            viewController.cancelBlock = { [weak self] in
//                guard let `self` = self else { return }
//                let animator: UIViewPropertyAnimator = self.hideOtherPaymentAnimator()
//                animator.addAnimations {
//                    self.window?.transform = CGAffineTransform(translationX: 0, y: contentSize.height)
//                }
//                animator.addCompletion({ _ in
//                    self.window = nil
//                    self.tableView.isUserInteractionEnabled = true
//                    self.view.window?.makeKey()
//                })
//                animator.startAnimation()
//            }
//
//            // Animation
//            self.window?.transform = CGAffineTransform(translationX: 0, y: contentSize.height)
//            let animator: UIViewPropertyAnimator = self.showOtherPaymentAnimator()
//            animator.addAnimations {
//                self.window?.transform = .identity
//            }
//            animator.startAnimation()
//        }
        return view
    }()

    func showOtherPaymentAnimator() -> UIViewPropertyAnimator {
        let animator: UIViewPropertyAnimator = UIViewPropertyAnimator(duration: 0.33, dampingRatio: 1) {
            self.view.window?.transform = CGAffineTransform(scaleX: 0.93, y: 0.93)
            self.view.window?.alpha = 0.8
        }
        return animator
    }

    func hideOtherPaymentAnimator() -> UIViewPropertyAnimator {
        let animator: UIViewPropertyAnimator = UIViewPropertyAnimator(duration: 0.33, dampingRatio: 1) {
            self.view.window?.transform = .identity
            self.view.window?.alpha = 1
        }
        return animator
    }

    override func loadView() {
        super.loadView()
        self.view.addSubview(tableView)
        self.view.addSubview(summaryView)
        self.view.addSubview(paymentMethodView)
        self.view.backgroundColor = .black
    }

    func layoutSummaryView() {
        summaryView.sizeToFit()
        let contentSize: CGSize = summaryView.bounds.size
//        summaryView.frame = CGRect(x: 0, y: self.view.bounds.height - contentSize.height - self.paymentMethodView.height, width: contentSize.width, height: contentSize.height)
    }

    override func viewWillLayoutSubviews() {
        self.layoutSummaryView()
    }
    
    // MARK: -

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }

    internal func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: CartViewCell = tableView.dequeueReusableCell(withIdentifier: "CartViewCell", for: indexPath) as! CartViewCell
        return cell
    }

}
