import UIKit

class MainViewController: UIViewController {
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(MainCell.self, forCellReuseIdentifier: "\(MainCell.self)")
        tableView.separatorStyle = .none
        return tableView
    }()
    
    private var dataSource: [MainCellTypes] = [.hapticButtons]

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        configureUI()
    }

    private func configureUI() {
        arrangeSubviews()
        setupConstraints()
    }
    
    private func arrangeSubviews() {
        self.view.addSubview(tableView)
    }
    
    private func setupConstraints() {
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(self.view.safeAreaLayoutGuide)
        }
    }

}

extension MainViewController: UITableViewDelegate {
    
}

extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: "\(MainCell.self)",
            for: indexPath
        ) as? MainCell else {
            return UITableViewCell()
        }
        cell.configureCell(cellType: dataSource[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cellType = dataSource[indexPath.row]
        switch cellType {
        case .hapticButtons:
            let vc = HapticFeedbackViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
}
