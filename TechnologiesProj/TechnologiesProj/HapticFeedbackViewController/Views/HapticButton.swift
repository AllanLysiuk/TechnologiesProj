import UIKit

final class HapticButton: UIButton {
    
    private(set) var hapticButtonType: HapticButtonType
    
    init(hapticButtonType: HapticButtonType) {
        self.hapticButtonType = hapticButtonType
        super.init(frame: .zero)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        self.isSelected = false
        self.setTitle(hapticButtonType.rawValue, for: .normal)
        self.setTitle(hapticButtonType.rawValue, for: .selected)
        self.setTitleColor(.systemBlue, for: .normal)
        self.setTitleColor(.systemRed, for: .selected)
        self.titleLabel?.font = .systemFont(ofSize: 16, weight: .semibold)
        self.backgroundColor = UIColor.hexStringToUIColor(hex: "#FFFFFA")
        self.layer.cornerRadius = 10
        self.layer.shadowColor = UIColor.black.withAlphaComponent(0.5).cgColor // цвет
        self.layer.shadowOpacity = 0.2 // прозрачность, где 1 не прозрачная
        self.layer.shadowRadius = 4 // радиус/ распыление/ хорошее со всех сторон при 0,0
        self.layer.shadowOffset = CGSize(width: 0, height: 0)
        self.layer.masksToBounds = false // выход за границы
    }
}
