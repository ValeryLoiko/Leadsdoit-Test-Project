//
//  FullScreenImageViewController.swift
//  Leadsdoit-Test-Project
//
//  Created by Diana on 03/02/2024.
//

import UIKit
import SDWebImage
import SnapKit

class FullScreenImageViewController: UIViewController {
    var viewModel = FullScreenImageViewModel()

    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    private let exitButton: UIButton = {
        let button = UIButton.setupAction(type: .whiteExit)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .black
        view.addSubview(imageView)
        view.addSubview(exitButton)

        imageView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.width.equalToSuperview()
            $0.height.equalToSuperview()
        }

        exitButton.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(68)
            $0.left.equalTo(view.safeAreaLayoutGuide.snp.left).offset(20)
            $0.width.height.equalTo(44)
        }

        exitButton.addTarget(self, action: #selector(exitButtonTapped), for: .touchUpInside)

        viewModel.loadImage { [weak self] (image) in
            DispatchQueue.main.async {
                self?.imageView.image = image
            }
        }
    }

    @objc private func exitButtonTapped() {
        dismiss(animated: true, completion: nil)
    }
}
