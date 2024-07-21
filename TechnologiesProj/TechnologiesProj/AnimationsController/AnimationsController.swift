import UIKit
import SnapKit

final class AnimationsController: UIViewController {
    
    private var continueButton: UIButton = {
        let btn = UIButton()
        btn.layer.cornerRadius = 20
        btn.backgroundColor = .red
        btn.setTitleColor(.white, for: .normal)
        btn.setTitle("Continue", for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
        btn.addTarget(self, action: #selector(continueButtonDidTap), for: .touchUpInside)
        return btn
    }()
    
    private var backgroundShadowView: UIView = {
        let view = UIView()
        view.backgroundColor = .black.withAlphaComponent(0.2)
        view.alpha = 0
        return view
    }()
    
    private var containerView: ContinueButtonInfoView = {
        let view = ContinueButtonInfoView()
        view.layer.cornerRadius = 20
        return view
    }()
    
    private var containerViewHeightConstraint = NSLayoutConstraint()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    private func configureUI() {
        self.view.backgroundColor = .white
        arrangeSubviews()
        setupConstraints()
    }
    
    private func arrangeSubviews() {
        self.view.addSubview(continueButton)
        self.view.addSubview(backgroundShadowView)
        self.view.addSubview(containerView)
    }
    
    private func setupConstraints() {
        
        backgroundShadowView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        containerViewHeightConstraint = NSLayoutConstraint(item: containerView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 0)
        containerViewHeightConstraint.isActive = true
        containerView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(24)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom).offset(-8)
        }
        
        continueButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(40)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom).offset(-8)
            make.height.equalTo(50)
        }
    }
    
    @objc private func continueButtonDidTap() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(backgroundShadowViewDidTap))
        tapGesture.cancelsTouchesInView = false
        backgroundShadowView.addGestureRecognizer(tapGesture)
        
        UIView.animateKeyframes(withDuration: 0.3, delay: 0) {
            UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.3) {
                self.backgroundShadowView.alpha = 1
                self.containerViewHeightConstraint.isActive = false
            }
            
            self.containerView.startAnimation()
            
            self.view.layoutIfNeeded()
        }
        
    }
    
    @objc private func backgroundShadowViewDidTap() {
        backgroundShadowView.gestureRecognizers?.removeAll()
        
        UIView.animateKeyframes(withDuration: 0.5, delay: 0, options: [], animations: {
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.4) {
                self.backgroundShadowView.alpha = 0
            }
            
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.4) {
                self.containerViewHeightConstraint.constant = 66
                self.view.layoutIfNeeded()
            }
            
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.1) {
                self.containerView.cancelButton.alpha = 0
            }
            
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.2) {
                self.containerView.crossButton.alpha = 0
                self.containerView.titleLabel.alpha = 0
                self.containerView.infoTextLabel.alpha = 0
            }
            
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.3) {
                self.containerView.continueButton.snp.remakeConstraints { make in
                    make.trailing.leading.equalToSuperview().inset(16)
                    make.height.equalTo(50)
                    make.bottom.equalToSuperview()
                }
                
                self.containerView.cancelButton.snp.remakeConstraints { make in
                    make.leading.equalToSuperview().offset(16)
                    make.height.equalTo(50)
                    make.width.equalTo(0)
                    make.bottom.equalToSuperview().offset(-16)
                }
                self.view.layoutIfNeeded()
            }
            
            UIView.addKeyframe(withRelativeStartTime: 0.2, relativeDuration: 0.3) {
                self.containerView.continueButton.alpha = 0
            }
            
            UIView.addKeyframe(withRelativeStartTime: 0.4, relativeDuration: 0.1) {
                self.containerView.alpha = 0
            }
        }, completion: nil)
    }
    
}
