//
//  LoadingDisplayable.swift
//  UserList7Apps
//
//  Created by Murat Ceyhun Korpeoglu on 4.03.2025.
//

import UIKit

protocol LoadingDisplayable {
    func showLoading()
    func hideLoading()
}

extension LoadingDisplayable {
    
    private var loadingViewTag: Int { return 999 }
    
    func showLoading() {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let window = windowScene.windows.first else {
            return
        }
        
        if window.viewWithTag(loadingViewTag) != nil {
            return
        }
        
        let circularLoadingView = CircularLoadingView(frame: window.bounds)
        circularLoadingView.tag = loadingViewTag
        circularLoadingView.translatesAutoresizingMaskIntoConstraints = false
        
        window.addSubview(circularLoadingView)
        
        NSLayoutConstraint.activate([
            circularLoadingView.leadingAnchor.constraint(equalTo: window.leadingAnchor),
            circularLoadingView.trailingAnchor.constraint(equalTo: window.trailingAnchor),
            circularLoadingView.topAnchor.constraint(equalTo: window.topAnchor),
            circularLoadingView.bottomAnchor.constraint(equalTo: window.bottomAnchor)
        ])
        
        circularLoadingView.startLoading()
    }
    
    func hideLoading() {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let window = windowScene.windows.first else {
            return
        }
        
        if let loadingView = window.viewWithTag(loadingViewTag) as? CircularLoadingView {
            loadingView.stopLoading()
            loadingView.removeFromSuperview()
        }
    }
}

final class CircularLoadingView: UIView {
    
    private let circleLayer = CAShapeLayer()
    private let blurEffectView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .systemThickMaterialDark)
        let view = UIVisualEffectView(effect: blurEffect)
        view.alpha = 0.5
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupBlurBackground()
        setupCircleLayer()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupBlurBackground()
        setupCircleLayer()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        circleLayer.frame = bounds
        setupCirclePath()
    }
    
    private func setupBlurBackground() {
        addSubview(blurEffectView)
        
        NSLayoutConstraint.activate([
            blurEffectView.leadingAnchor.constraint(equalTo: leadingAnchor),
            blurEffectView.trailingAnchor.constraint(equalTo: trailingAnchor),
            blurEffectView.topAnchor.constraint(equalTo: topAnchor),
            blurEffectView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    private func setupCircleLayer() {
        let radius: CGFloat = 20
        let circularPath = UIBezierPath(
            arcCenter: CGPoint(x: bounds.midX, y: bounds.midY),
            radius: radius,
            startAngle: 0,
            endAngle: .pi * 2,
            clockwise: true
        )
        
        circleLayer.path = circularPath.cgPath
        circleLayer.strokeColor = UIColor.systemRed.cgColor
        circleLayer.lineWidth = 4.0
        circleLayer.fillColor = UIColor.clear.cgColor
        circleLayer.lineCap = .round
        circleLayer.strokeEnd = 0.0
        
        layer.addSublayer(circleLayer)
    }
    
    private func setupCirclePath() {
        let radius: CGFloat = 20
        let circularPath = UIBezierPath(
            arcCenter: CGPoint(x: bounds.midX, y: bounds.midY),
            radius: radius,
            startAngle: 0,
            endAngle: .pi * 2,
            clockwise: true
        )
        circleLayer.path = circularPath.cgPath
    }
    
    func startLoading() {
        animateLoading()
    }
    
    func stopLoading() {
        circleLayer.removeAllAnimations()
    }
    
    private func animateLoading() {
        let strokeAnimation = CABasicAnimation(keyPath: "strokeEnd")
        strokeAnimation.fromValue = 0.0
        strokeAnimation.toValue = 1.0
        strokeAnimation.duration = 1.0
        strokeAnimation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        
        let rotateAnimation = CABasicAnimation(keyPath: "transform.rotation")
        rotateAnimation.fromValue = 0.0
        rotateAnimation.toValue = CGFloat.pi * 2
        rotateAnimation.duration = 1.0
        rotateAnimation.repeatCount = .infinity
        
        let groupAnimation = CAAnimationGroup()
        groupAnimation.animations = [strokeAnimation, rotateAnimation]
        groupAnimation.duration = 1.0
        groupAnimation.repeatCount = .infinity
        
        circleLayer.add(groupAnimation, forKey: "loadingAnimation")
    }
}
