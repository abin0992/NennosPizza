//
//  Loadable.swift
//  NennosPizza
//
//  Created by Abin Baby on 12.07.23.
//

import UIKit

private var containerView: UIView!

protocol Loadable {
    func showLoadingView()
    func dismissLoadingView()
}

extension Loadable where Self: UIViewController {

    func showLoadingView() {
        containerView = UIView(frame: view.bounds)
        view.addSubview(containerView)

        containerView.backgroundColor = .systemBackground
        containerView.alpha = 0

        UIView.animate(withDuration: 0.25) { containerView.alpha = 0.8 }

        let activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView(style: .large)
        containerView.addSubview(activityIndicator)

        activityIndicator.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            activityIndicator.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            activityIndicator.centerXAnchor.constraint(equalTo: containerView.centerXAnchor)
        ])

        activityIndicator.startAnimating()
    }

    func dismissLoadingView() {
        DispatchQueue.main.async {
            containerView?.removeFromSuperview()
            containerView = nil
        }
    }

    func showAlertWithRetry(
        title: String = Alert.errorTitle,
        message: String = Alert.unknownErrorTitle ,
        retryAction: @escaping () -> Void
    ) {
        let alertController = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
        )
        
        let retryAction = UIAlertAction(
            title: Alert.retryButtonLabel,
            style: .default
        ) { _ in
            retryAction()
        }
        
        alertController.addAction(retryAction)
        
        present(alertController, animated: true, completion: nil)
    }
}

