////
////  ViewController.swift
////  Related Animation
////
////  Created by Зулейха on 07.07.2023.
////
//
import UIKit
//
class ViewController: UIViewController {
    private let viewContainer  = UIView()
    
    let square: UIView = {
        let view = UIView()
        view.backgroundColor = .blue
        view.layer.cornerRadius = 12
        
        return view
    }()
    
    private lazy var slider: UISlider = {
        let view = UISlider()
        
        view.addTarget(self, action: #selector(rotation), for: .valueChanged)
        view.addTarget(self, action: #selector(end), for: [.touchUpInside, .touchUpOutside])
        
        view.maximumValue = 0
        view.maximumValue = 1
        
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    private func setupView() {
        view.addSubview(viewContainer)
        view.addSubview(slider)
        viewContainer.addSubview(square)
        
        viewContainer.translatesAutoresizingMaskIntoConstraints = false
        square.translatesAutoresizingMaskIntoConstraints = false
        slider.translatesAutoresizingMaskIntoConstraints = false

        
        view.layoutMargins = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        square.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        
        square.translatesAutoresizingMaskIntoConstraints = false
        viewContainer.translatesAutoresizingMaskIntoConstraints = false
        slider.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            viewContainer.leftAnchor.constraint(equalTo:view.layoutMarginsGuide.leftAnchor),
            viewContainer.rightAnchor.constraint (equalTo: view.layoutMarginsGuide .rightAnchor) ,
            viewContainer.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 70),
            viewContainer.heightAnchor.constraint(equalToConstant: 200)
        ])
        NSLayoutConstraint.activate([
        slider.leftAnchor.constraint(equalTo: view.layoutMarginsGuide.leftAnchor),
        slider.rightAnchor.constraint(equalTo:view.layoutMarginsGuide.rightAnchor),
        slider.topAnchor.constraint(equalTo: viewContainer.bottomAnchor,constant: 50)
    ])
        square.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        
    }

    private func gestures (sliderValue: Float) {
        let newX = CGFloat(sliderValue) * (viewContainer.frame.width - square.frame.width) + square.frame.width / 2
        square.center.x = newX
    }

    private func changeView(sliderValue: Float) {
        let scale = 1 + CGFloat(sliderValue / 2)
        square.transform = CGAffineTransformRotate(
            CGAffineTransform(scaleX: scale, y: scale),
            CGFloat(sliderValue) * CGFloat.pi / 2
        )
    }
    
        @objc
        private func rotation(_ slider: UISlider) {
            changeView(sliderValue:slider.value)
            gestures(sliderValue: slider.value)
        }
    
        @objc
        private func end(_ slider: UISlider) {
            let maximumValue = slider.maximumValue
    
            UIView.animate(withDuration: TimeInterval(1 - slider.value)) {
                self.changeView(sliderValue: maximumValue)
    
                self.gestures(sliderValue: maximumValue)
                self.slider.setValue (maximumValue, animated: true)
            }
        }
    }
    
