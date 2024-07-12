import UIKit
import SnapKit

final class MainCell: UITableViewCell {
    
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemBlue
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        return label
    }()
    
    private var backgroundCellView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.hexStringToUIColor(hex: "#FFFFFA")
        view.layer.cornerRadius = 10
        view.layer.shadowColor = UIColor.black.withAlphaComponent(0.5).cgColor // цвет
        view.layer.shadowOpacity = 0.2 // прозрачность, где 1 не прозрачная
        view.layer.shadowRadius = 6 // радиус/ распыление/ хорошее со всех сторон при 0,0
        view.layer.masksToBounds = false // выход за границы
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCell(cellType: MainCellTypes) {
        titleLabel.text = cellType.rawValue
    }
    
    private func configureUI() {
        self.selectionStyle = .none
        arrangeSubviews()
        setupConstraints()
    }
    
    private func arrangeSubviews() {
        self.contentView.addSubview(backgroundCellView)
        backgroundCellView.addSubview(titleLabel)
    }
    
    private func setupConstraints() {
        
        backgroundCellView.snp.makeConstraints { make in
            make.leading.trailing.top.bottom.equalToSuperview().inset(16)
            make.height.equalTo(150)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.center.equalToSuperview()
        }
    }
}
