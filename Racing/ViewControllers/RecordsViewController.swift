
import Foundation
import UIKit
import SnapKit

final class RecordsViewController: UIViewController {
    
    private let buttonBack: UIButton = {
        let button = UIButton(type: .system)
        let backImage = UIImage(systemName: "chevron.left")
        button.tintColor = UIColor(red: 225 / 255, green: 169 / 255, blue: 58 / 255, alpha: 1)
        button.titleLabel?.font = UIFont(name: "Montserrat-Regular", size: 20)
        button.setTitleColor(UIColor(red: 225 / 255, green: 169 / 255, blue: 58 / 255, alpha: 1), for: .normal)
        button.setImage(backImage, for: .normal)
        return button
    }()
    
    private let mainImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "Records")
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(RecordsViewCell.self, forCellReuseIdentifier: RecordsViewCell.identifier)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        return tableView
    }()
    
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "🏆 Records"
        label.font = UIFont(name: "Montserrat-Regular", size: 30)
        label.textColor = UIColor(red: 225/255, green: 169/255, blue: 58/255, alpha: 1)
        return label
    }()
    
    private let manager = SaveLoadManager()
    private var records: [RaceRecord] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        loadRecords()
    }
    
    // MARK: - конфигурируем UI
    private func configureUI() {
        
        
        view.addSubview(mainImage)
        mainImage.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(60)
            make.centerX.equalToSuperview()
        }
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(40)
            make.left.right.equalToSuperview().inset(16)
            make.bottom.equalToSuperview().inset(40)
        }
        
        view.addSubview(buttonBack)
        buttonBack.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.top.equalToSuperview().offset(50)
            make.height.equalTo(40)
        }
        
        let backButtonAction = UIAction { _ in
            self.backButtonPressed()
        }
        buttonBack.addAction(backButtonAction, for: .touchUpInside)
        
    }
    
    
    func backButtonPressed() {
        navigationController?.popViewController(animated: true)
    }
  
    
    private func loadRecords() {
        records = manager.loadRecords()
        records.sort { $0.time < $1.time }
        tableView.reloadData()
    }
}

extension RecordsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        records.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: RecordsViewCell.identifier, for: indexPath) as? RecordsViewCell else { return RecordsViewCell() }
        let record = records[indexPath.row]
        let position = indexPath.row + 1
        cell.configure(with: record, position: position)
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
