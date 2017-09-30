//
//  NavigationController.swift
//  AutoLayout
//
//  Created by 1amageek on 2017/09/28.
//  Copyright © 2017年 Stamp Inc. All rights reserved.
//

import UIKit

class NavigationController: UINavigationController {

    override func loadView() {
        super.loadView()
        self.view.translatesAutoresizingMaskIntoConstraints = false
    }

    override func viewDidAppear(_ animated: Bool) {
        if let transitionView = self.view.subviews.first {
            transitionView.translatesAutoresizingMaskIntoConstraints = false
            self.view.topAnchor.constraint(equalTo: transitionView.topAnchor, constant: 0).isActive = true
            self.view.bottomAnchor.constraint(equalTo: transitionView.bottomAnchor, constant: 0).isActive = true
            self.view.leadingAnchor.constraint(equalTo: transitionView.leadingAnchor, constant: 0).isActive = true
            self.view.trailingAnchor.constraint(equalTo: transitionView.trailingAnchor, constant: 0).isActive = true
            if let wrapperView = transitionView.subviews.first {
                wrapperView.translatesAutoresizingMaskIntoConstraints = false
                wrapperView.constraints.forEach { (constraint) in
                    constraint.isActive = false
                }
                wrapperView.topAnchor.constraint(equalTo: transitionView.topAnchor, constant: 0).isActive = true
                wrapperView.bottomAnchor.constraint(equalTo: transitionView.bottomAnchor, constant: 0).isActive = true
                wrapperView.leadingAnchor.constraint(equalTo: transitionView.leadingAnchor, constant: 0).isActive = true
                wrapperView.trailingAnchor.constraint(equalTo: transitionView.trailingAnchor, constant: 0).isActive = true
            }
        }
        super.viewDidAppear(animated)

        // Window
        self.view.window?.constraints.forEach { (constraint) in
            constraint.isActive = false
        }
        guard let window = self.view.window else { return }
//        self.view.topAnchor.constraint(equalTo: window.topAnchor, constant: 0).isActive = true
        self.view.bottomAnchor.constraint(equalTo: window.bottomAnchor, constant: 0).isActive = true
        self.view.leadingAnchor.constraint(equalTo: window.leadingAnchor, constant: 0).isActive = true
        self.view.trailingAnchor.constraint(equalTo: window.trailingAnchor, constant: 0).isActive = true
    }
}
