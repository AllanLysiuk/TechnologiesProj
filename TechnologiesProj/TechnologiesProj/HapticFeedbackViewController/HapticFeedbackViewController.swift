import UIKit
import SnapKit

final class HapticFeedbackViewController: UIViewController {
    
    private var buttonsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.distribution = .equalCentering
        return stackView
    }()
    
    private var hapticButtonTypes: [HapticButtonType] = [
        .error,
        .success,
        .heavy,
        .light,
        .medium,
        .selectionChanged,
        .warning,
        .customVibration,
        .customDatePicker
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        configureUI()
    }
    
    private func configureUI() {
        arrangeSubviews()
        setupConstraints()
        setupNavigationItems()
    }
    
    private func arrangeSubviews() {
        self.view.addSubview(buttonsStackView)
        
        hapticButtonTypes.forEach { hapticButtonType in
            let btn = HapticButton(hapticButtonType: hapticButtonType)
            btn.addTarget(self, action: #selector(hapticButtonDidTap), for: .touchUpInside)
            btn.snp.makeConstraints { make in
                make.height.equalTo(60)
            }
            buttonsStackView.addArrangedSubview(btn)
        }
    }
    
    private func setupConstraints() {
        buttonsStackView.snp.makeConstraints { make in
            make.leading.trailing.top.equalTo(self.view.safeAreaLayoutGuide).inset(16)
        }
    }
    
    private func setupNavigationItems() {
        navigationItem.title = "Haptic buttons"
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "arrow.left"),
            style: .plain,
            target: self,
            action: #selector(backButtonDidTap)
        )
        navigationItem.leftBarButtonItem?.tintColor = .black
    }
    
    @objc private func hapticButtonDidTap(_ sender: HapticButton) {
        sender.isSelected.toggle()
        switch sender.hapticButtonType {
        case .error:
            let generator = UINotificationFeedbackGenerator()
            generator.notificationOccurred(.error)
        case .success:
            let generator = UINotificationFeedbackGenerator()
            generator.notificationOccurred(.success)
        case .warning:
            let generator = UINotificationFeedbackGenerator()
            generator.notificationOccurred(.warning)
        case .light:
            let generator = UIImpactFeedbackGenerator(style: .light)
            generator.impactOccurred()
        case .medium:
            let generator = UIImpactFeedbackGenerator(style: .medium)
            generator.impactOccurred()
        case .heavy:
            let generator = UIImpactFeedbackGenerator(style: .heavy)
            generator.impactOccurred()
        case .selectionChanged:
            let generator = UISelectionFeedbackGenerator()
            generator.selectionChanged()
        case .customVibration:
            HapticFeedbackGenerator.shared.customVibrationFeedback()
        case .customDatePicker:
            HapticFeedbackGenerator.shared.datePickerFeedback()
        }
    }
    
    @objc private func backButtonDidTap() {
        self.navigationController?.popViewController(animated: true)
    }
}
