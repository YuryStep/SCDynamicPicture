//
//  ViewController.swift
//  SCDynamicPicture
//
//  Created by Юрий Степанчук on 19.11.2023.
//

import UIKit

final class ViewController: UIViewController {
    private enum Constants {
        static let height: CGFloat = 300
        static let scrollableLength: CGFloat = 600
    }

    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.contentInsetAdjustmentBehavior = .never
        scrollView.delegate = self
        return scrollView
    }()

    private lazy var imageView: UIImageView = {
        let imageView = UIImageView(image: .pappy)
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private lazy var container: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var scrollableContentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray5
        setupView()
    }

    private func setupView() {
        view.addSubview(scrollView)
        scrollView.addSubview(container)
        scrollView.addSubview(imageView)
        scrollView.addSubview(scrollableContentView)

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            container.topAnchor.constraint(equalTo: scrollView.topAnchor),
            container.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            container.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            container.heightAnchor.constraint(equalToConstant: Constants.height),

            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: container.bottomAnchor),
            imageView.heightAnchor.constraint(greaterThanOrEqualToConstant: Constants.height),

            scrollableContentView.topAnchor.constraint(equalTo: imageView.bottomAnchor),
            scrollableContentView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollableContentView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollableContentView.heightAnchor.constraint(equalToConstant: Constants.scrollableLength),
            scrollableContentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor)
        ])

        let fixedImageTop = imageView.topAnchor.constraint(equalTo: view.topAnchor)
        fixedImageTop.priority = .defaultHigh
        fixedImageTop.isActive = true
    }
}

extension ViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y < 0 {
            let newInsets = UIEdgeInsets(top: 238 - scrollView.contentOffset.y,
                                         left: 0,
                                         bottom: view.safeAreaInsets.bottom,
                                         right: 0)
            scrollView.scrollIndicatorInsets = newInsets
        }
    }
}
