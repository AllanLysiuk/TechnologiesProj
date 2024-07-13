import UIKit

final class TransitionsController: UIViewController {
    
    private let transition = BottomPanelTransition()
    
    private var button: UIButton = {
        let btn = UIButton()
        btn.setTitle("Test", for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.backgroundColor = .placeholderText
        btn.addTarget(self, action: #selector(buttonDidTap), for: .touchUpInside)
        return btn
    }()
    
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
        self.view.addSubview(button)
    }
    
    private func setupConstraints() {
        button.snp.makeConstraints { make in
            make.leading.trailing.top.equalTo(self.view.safeAreaLayoutGuide).inset(16)
            make.height.equalTo(60)
        }
    }
    
    private func setupNavigationItems() {
        navigationItem.title = "Transition Controllers"
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "arrow.left"),
            style: .plain,
            target: self,
            action: #selector(backButtonDidTap)
        )
        navigationItem.leftBarButtonItem?.tintColor = .black
    }
    
    @objc private func backButtonDidTap() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc private func buttonDidTap() {
        let vc = BottomTransitionViewController()
        vc.modalPresentationStyle = .custom
        vc.transitioningDelegate = transition
        self.navigationController?.present(vc, animated: true)
    }
}


