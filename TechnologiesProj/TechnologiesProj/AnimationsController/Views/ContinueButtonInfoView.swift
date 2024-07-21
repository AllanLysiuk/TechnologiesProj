import UIKit
import SnapKit

final class ContinueButtonInfoView: UIView {
    
     var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.textColor = .black
        label.text = "Are you sure?"
        label.alpha = 0
        return label
    }()
    
     var crossButton: UIButton = {
        let btn = UIButton()
        btn.alpha = 0
        let largeTitle = UIImage.SymbolConfiguration(textStyle: .largeTitle)
        let black = UIImage.SymbolConfiguration(weight: .black)
        let combined = largeTitle.applying(black)
        let image = UIImage(systemName: "xmark", withConfiguration: combined)?.withTintColor(.gray, renderingMode: .alwaysOriginal)
        btn.setImage(image, for: .normal)
        btn.addTarget(self, action: #selector(hideViewDidTap), for: .touchUpInside)
        return btn
    }()
    
     var infoTextLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .bold)
        label.textColor = .lightGray.withAlphaComponent(0.4)
        label.text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce eleifend justo id varius suscipit. Phasellus tempor ipsum pulvinar massa ullamcorper, eget fringilla justo consectetur. Nulla molestie vestibulum urna eget aliquam. Mauris quam libero, volutpat at lorem sit amet, molestie imperdiet risus."
        label.numberOfLines = 0
        label.alpha = 0
        return label
    }()
    
     var continueButton: UIButton = {
        let btn = UIButton()
        btn.alpha = 0
        btn.layer.cornerRadius = 20
        btn.backgroundColor = .red
        btn.setTitleColor(.white, for: .normal)
        btn.setTitle("Continue", for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
        btn.addTarget(self, action: #selector(continueButtonDidTap), for: .touchUpInside)
        return btn
    }()
    
     var cancelButton: UIButton = {
        let btn = UIButton()
        btn.alpha = 0
        btn.layer.cornerRadius = 20
        btn.backgroundColor = .lightGray.withAlphaComponent(0.5)
        btn.setTitleColor(.black, for: .normal)
        btn.setTitle("Cancel", for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
        btn.addTarget(self, action: #selector(hideViewDidTap), for: .touchUpInside)
        return btn
    }()
    
    private var continueButtonBottomConstraint = NSLayoutConstraint()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        self.backgroundColor = .white
        arrangeSubviews()
        setupConstraints()
    }
    
    private func arrangeSubviews() {
        self.addSubview(titleLabel)
        self.addSubview(crossButton)
        self.addSubview(infoTextLabel)
        self.addSubview(continueButton)
        self.addSubview(cancelButton)
    }
    
    private func setupConstraints() {
        
        titleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(16)
            make.top.equalToSuperview().inset(24)
        }
        
        crossButton.snp.makeConstraints { make in
            make.top.trailing.equalToSuperview().inset(16)
            make.size.equalTo(20)
        }
        
        infoTextLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.top.equalTo(titleLabel.snp.bottom).offset(16)
        }

        continueButton.snp.makeConstraints { make in
            make.trailing.leading.equalToSuperview().inset(16)
            make.height.equalTo(50)
            make.centerY.equalTo(self.cancelButton)
            make.bottom.equalToSuperview()
        }
        
        cancelButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.height.equalTo(50)
            make.width.equalTo(0)
            make.bottom.equalToSuperview()
            make.top.equalToSuperview()
        }
    }
    
    @objc private func continueButtonDidTap() {

    }
    
    @objc private func hideViewDidTap() {

    }
    
//    func startAnimation() {
//        continueButton.alpha = 1
//        closeButton.alpha = 1
//        crossButton.alpha = 1
//        titleLabel.alpha = 1
//        infoTextLabel.alpha = 1
//            self.continueButton.snp.remakeConstraints { make in
//                make.trailing.equalToSuperview().offset(-16)
//                make.leading.equalTo(self.closeButton.snp.trailing).offset(16)
//                make.bottom.equalToSuperview().offset(-16)
//                make.height.equalTo(50)
//                make.centerY.equalTo(self.closeButton)
//            }
//            
//            self.closeButton.snp.remakeConstraints { make in
//                make.leading.equalToSuperview().offset(16)
//                make.width.equalTo(self.continueButton)
//                make.bottom.equalToSuperview().offset(-16)
//                make.height.equalTo(50)
//                make.top.equalTo(self.infoTextLabel.snp.bottom).offset(24)
//            }
//    }
//    
//    func hideView() {
//            self.continueButton.snp.remakeConstraints { make in
//                make.trailing.leading.equalToSuperview().inset(16)
//                make.height.equalTo(50)
//                make.bottom.equalToSuperview()
//            }
//            
//            self.closeButton.snp.remakeConstraints { make in
//                make.leading.equalToSuperview().offset(16)
//                make.width.equalTo(150)
//                make.height.equalTo(50)
//                make.bottom.equalToSuperview().offset(-16)
//                make.top.equalTo(self.infoTextLabel.snp.bottom).offset(24)
//            }
//        continueButton.alpha = 0
//        closeButton.alpha = 0
//        crossButton.alpha = 0
//        infoTextLabel.alpha = 0
//        titleLabel.alpha = 0
//    }
    
    func startAnimation() {
        UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.1) {
            self.continueButton.alpha = 1
            self.alpha = 1
        }
        UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.3) {
            self.continueButton.snp.remakeConstraints { make in
                make.trailing.equalToSuperview().offset(-16)
                make.leading.equalTo(self.cancelButton.snp.trailing).offset(16)
                make.bottom.equalToSuperview().offset(-16)
                make.height.equalTo(50)
                make.centerY.equalTo(self.cancelButton)
            }
            
            self.cancelButton.snp.remakeConstraints { make in
                make.leading.equalToSuperview().offset(16)
                make.width.equalTo(self.continueButton)
                make.bottom.equalToSuperview().offset(-16)
                make.height.equalTo(50)
                make.top.equalTo(self.infoTextLabel.snp.bottom).offset(24)
            }
            
        }
        
        UIView.addKeyframe(withRelativeStartTime: 0.2, relativeDuration: 0.1) {
            self.cancelButton.alpha = 1
            self.crossButton.alpha = 1
            self.titleLabel.alpha = 1
            self.infoTextLabel.alpha = 1
        }
            
    }
    
//    func hideView() {
//        UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.1) {
//            self.cancelButton.alpha = 0
//        }
//        
//        UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.3) {
//            self.crossButton.alpha = 0
//            self.titleLabel.alpha = 0
//            self.infoTextLabel.alpha = 0
//        }
//        
//        UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.2) {
//            self.continueButton.snp.remakeConstraints { make in
//                make.trailing.leading.equalToSuperview().inset(16)
//                make.height.equalTo(50)
//                make.bottom.equalToSuperview()
//            }
//            
//            self.cancelButton.snp.remakeConstraints { make in
//                make.leading.equalToSuperview().offset(16)
//                make.height.equalTo(50)
//                make.width.equalTo(0)
//                make.bottom.equalToSuperview().offset(-16)
//            }
//            
//        }
//        
//        UIView.addKeyframe(withRelativeStartTime: 0.2, relativeDuration: 0.3) {
//            self.continueButton.alpha = 0
//        }
//        
//        UIView.addKeyframe(withRelativeStartTime: 0.4, relativeDuration: 0.1) {
//            self.alpha = 0
//        }
//        
//    }
    
//    func hideView() {
//        UIView.animateKeyframes(withDuration: 0.5, delay: 0) {
//            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.1) {
//                self.cancelButton.alpha = 0
//            }
//            
//            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.3) {
//                self.crossButton.alpha = 0
//                self.titleLabel.alpha = 0
//                self.infoTextLabel.alpha = 0
//            }
//            
//            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.2) {
//                self.continueButton.snp.remakeConstraints { make in
//                    make.trailing.leading.equalToSuperview().inset(16)
//                    make.height.equalTo(50)
//                    make.bottom.equalToSuperview()
//                }
//                
//                self.cancelButton.snp.remakeConstraints { make in
//                    make.leading.equalToSuperview().offset(16)
//                    make.height.equalTo(50)
//                    make.width.equalTo(0)
//                    make.bottom.equalToSuperview().offset(-16)
//                }
//            }
//            
//            UIView.addKeyframe(withRelativeStartTime: 0.2, relativeDuration: 0.3) {
//                self.continueButton.alpha = 0
//            }
//            
//            UIView.addKeyframe(withRelativeStartTime: 0.4, relativeDuration: 0.1) {
//                self.alpha = 0
//            }
//            
//            self.layoutIfNeeded()
//        }
//    }
}
