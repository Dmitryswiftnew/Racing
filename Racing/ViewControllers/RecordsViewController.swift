
import Foundation
import UIKit


class RecordsViewController: UIViewController {
    
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
    
    
    private let mainContainer: UIView = {
        let view = UIView()
//        view.backgroundColor = .yellow
//        view.alpha = 0.3
        return view
    }()
    
    private let boardContainer: UIView = {
        let view = UIView()
//        view.backgroundColor = .red
//        view.alpha = 0.5
        return view
    }()
    
    private let numberLabel: UILabel = {
        let label = UILabel()
        label.text = "№"
        label.font = UIFont(name: "Montserrat-Regular", size: 30)
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()
    
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "NAME"
        label.font = UIFont(name: "Montserrat-Regular", size: 30)
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()
    
    private let timeLabel: UILabel = {
        let label = UILabel()
        label.text = "TIME"
        label.font = UIFont(name: "Montserrat-Regular", size: 30)
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()
    
    
    private let numberOneLabel: UILabel = {
        let label = UILabel()
        label.text = "1"
        label.font = UIFont(name: "Montserrat-Regular", size: 30)
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()
    
    private let numberTwoLabel: UILabel = {
        let label = UILabel()
        label.text = "2"
        label.font = UIFont(name: "Montserrat-Regular", size: 30)
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()
    
    
    private let nameOneLabel: UILabel = {
        let label = UILabel()
        label.text = "name"
        label.font = UIFont(name: "Montserrat-Regular", size: 30)
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()
    
    private let nameTwoLabel: UILabel = {
        let label = UILabel()
        label.text = "name2"
        label.font = UIFont(name: "Montserrat-Regular", size: 30)
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()
    
    
    
    
    private let timeOneLabel: UILabel = {
        let label = UILabel()
        label.text = "0"
        label.font = UIFont(name: "Montserrat-Regular", size: 30)
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()
    
    private let timeTwoLabel: UILabel = {
        let label = UILabel()
        label.text = "0"
        label.font = UIFont(name: "Montserrat-Regular", size: 30)
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()
    
    private let manager = SaveLoadManager()
    private var records: [RaceRecord] = []
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        loadAndDisplayRecords()
    }
    
    // MARK: - конфигурируем UI
    private func configureUI() {
        view.backgroundColor = .systemBackground
        
        view.addSubview(mainImage)
        mainImage.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        mainImage.addSubview(mainContainer)
        mainContainer.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        mainContainer.addSubview(boardContainer)
        boardContainer.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(100)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().inset(16)
            make.bottom.equalToSuperview().inset(100)
            
        }
        
        
        boardContainer.addSubview(numberLabel)
        numberLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalToSuperview()
            make.height.equalTo(30)
        }
        
        
        boardContainer.addSubview(nameLabel)
        nameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
            make.height.equalTo(numberLabel)
        }
        
        boardContainer.addSubview(timeLabel)
        timeLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.right.equalToSuperview()
            make.height.equalTo(30)
        }
        
        boardContainer.addSubview(numberOneLabel)
        numberOneLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(80)
            make.left.equalToSuperview()
            make.height.width.equalTo(30)
        }
        
        boardContainer.addSubview(numberTwoLabel)
        numberTwoLabel.snp.makeConstraints { make in
            make.top.centerY.equalToSuperview()
            make.left.equalToSuperview()
            make.height.width.equalTo(30)
        }
        
        boardContainer.addSubview(nameOneLabel)
        nameOneLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(80)
            make.centerX.equalToSuperview()
            make.width.height.equalTo(nameOneLabel)
        }
        
        boardContainer.addSubview(nameTwoLabel)
        nameTwoLabel.snp.makeConstraints { make in
            make.centerY.centerX.equalToSuperview()
            make.height.width.equalTo(nameOneLabel)
        }
        
        
        boardContainer.addSubview(timeOneLabel)
        timeOneLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(80)
            make.right.equalToSuperview()
            make.width.height.equalTo(numberOneLabel)
        }
        
        boardContainer.addSubview(timeTwoLabel)
        timeTwoLabel.snp.makeConstraints { make in
            make.top.centerY.equalToSuperview()
            make.right.equalToSuperview()
            make.height.width.equalTo(30)
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
    
    
    
    
    func loadAndDisplayRecords() {
        records = manager.loadRecords()
        records.sort { $0.time > $1.time }
        
        if records.count > 0 {
            let first = records[0]
            nameOneLabel.text = first.playerName
            timeOneLabel.text = "\(first.time)"
        }
        
        if records.count > 1 {
            let second = records[1]
            nameTwoLabel.text = second.playerName
            timeTwoLabel.text = "\(second.time)"
        }
        
    }
    
}

