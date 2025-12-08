
import UIKit
import SnapKit

class MainViewController: UIViewController {
    
    let screenHeight = UIScreen.main.bounds.height
    
    private let buttonsView: UIView = {
        let view = UIView()
        //        view.backgroundColor = .white
        //        view.alpha = 0.3
        view.isUserInteractionEnabled = true
        return view
    }()
    
    private let label: UILabel = {
        let label = UILabel()
        label.text = "0"
        label.backgroundColor = .clear
        return label
    }()
    
    private let startGameButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("START", for: .normal)
        button.titleLabel?.font = UIFont(name: "Montserrat-Regular", size: 25)
//        button.titleLabel?.font = .boldSystemFont(ofSize: 24)
        button.setTitleColor(UIColor(red: 225 / 255, green: 169 / 255, blue: 58 / 255, alpha: 1), for: .normal)
        button.layer.cornerRadius = 10
        button.backgroundColor = .clear // Важно: делаем фон прозрачным для градиента
        return button
    }()
    
    private let recordsButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("RECORDS", for: .normal)
        button.titleLabel?.font = UIFont(name: "Montserrat-Regular", size: 25)
//        button.titleLabel?.font = .boldSystemFont(ofSize: 24)
        button.setTitleColor(UIColor(red: 225 / 255, green: 169 / 255, blue: 58 / 255, alpha: 1), for: .normal)
        button.layer.cornerRadius = 10
        button.backgroundColor = .clear
        return button
    }()
    
    private let settingsButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("SETTINGS", for: .normal)
        button.titleLabel?.font = UIFont(name: "Montserrat-Regular", size: 25)
        button.setTitleColor(UIColor(red: 225 / 255, green: 169 / 255, blue: 58 / 255, alpha: 1), for: .normal)
        button.layer.cornerRadius = 10
        button.backgroundColor = .clear
        return button
    }()
    
    private let mainImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "mainPicture")
        image.isUserInteractionEnabled = true
        return image
    }()
   
    private let manager = SaveLoadManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        startGameButtonCreate()
        recordsButtonCreate()
        settingsButtonCreate()
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        startGameButton.dropShadow()
        startGameButton.addGradient()
        startGameButton.pulseAnimation()
        
        recordsButton.dropShadow()
        recordsButton.addGradient()
        
        settingsButton.dropShadow()
        settingsButton.addGradient()
    }
    
    private func configureUI() {
        view.backgroundColor = .lightGray
        
        view.addSubview(mainImage)
        mainImage.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    
        mainImage.addSubview(buttonsView)
        buttonsView.snp.makeConstraints { make in
            make.top.equalTo(mainImage).inset(screenHeight / 4)
            make.left.equalTo(mainImage).offset(16)
            make.right.equalTo(mainImage).inset(16)
            make.height.equalTo(150)
        }
        
        mainImage.addSubview(label)
        label.snp.makeConstraints { make in
            make.bottom.equalTo(mainImage.snp.bottom).inset(16)
            make.centerX.equalTo(mainImage)
            make.height.equalTo(30)
        }
        
        //MARK: attributes
        
        let firstWorld = "Designed by Apple"
        let secondWorld = " & "
        let thirdWorld = "D.Vasil'ev"
        
        let shadow = NSShadow()
        shadow.shadowColor = UIColor.orange.withAlphaComponent(0.5)
        shadow.shadowOffset = CGSize(width: 2, height: 2)
        shadow.shadowBlurRadius = 5
        
        let firstAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.orange,
            .font: UIFont(name: "Montserrat-Regular", size: 14) ?? UIFont.systemFont(ofSize: 14),
            .strokeColor: UIColor.white,
            .strokeWidth: -0.8,
            .shadow: shadow
        ]
        
        let secondAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.orange,
            .font: UIFont(name: "Montserrat-Regular", size: 14) ?? UIFont.systemFont(ofSize: 14),
            .shadow: shadow
        ]
        
        let thirdAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.orange,
            .font: UIFont(name: "Montserrat-Regular", size: 14) ?? UIFont.systemFont(ofSize: 14),
            .obliqueness: 0.2,
            .underlineStyle: NSUnderlineStyle.single.rawValue,
            .strikethroughColor: UIColor.blue,
            .shadow: shadow
        ]
        
        let attributeString = NSMutableAttributedString(string: firstWorld, attributes: firstAttributes)
        let attributesMark = NSAttributedString(string: secondWorld, attributes: secondAttributes)
        let attributesName = NSAttributedString(string: thirdWorld, attributes: thirdAttributes)
        
        
        attributeString.append(attributesMark)
        attributeString.append(attributesName)
        
        label.attributedText = attributeString
        
        
        
//        for family in UIFont.familyNames {
//            print(family)
//            for name in UIFont.fontNames(forFamilyName: family) {
//                print("---\(name)")
//            }
//        }
    
        
        
    }
    
    
    func startGameButtonCreate() {
        buttonsView.addSubview(startGameButton)
        startGameButton.snp.makeConstraints { make in
            make.top.equalTo(buttonsView)
            make.centerX.equalTo(buttonsView)
            make.width.equalTo(140)
            make.height.equalTo(50)
        }
        
        let actionStartGame = UIAction { _ in
            self.startGameButtonPressed()
        }
        startGameButton.addAction(actionStartGame, for: .touchUpInside)
    }
    
    func recordsButtonCreate() {
        buttonsView.addSubview(recordsButton)
        recordsButton.snp.makeConstraints { make in
            make.centerY.equalTo(buttonsView)
            make.centerX.equalTo(buttonsView)
        }
        
        let actionRecords = UIAction { _ in
            self.recordsButtonPressed()
        }
        recordsButton.addAction(actionRecords, for: .touchUpInside)
    }
    
    func settingsButtonCreate() {
        buttonsView.addSubview(settingsButton)
        settingsButton.snp.makeConstraints { make in
            make.bottom.equalTo(buttonsView.snp.bottom)
            make.centerX.equalTo(buttonsView)
        }
        let actionSettings = UIAction { _ in
            self.settingsButtonPressed()
        }
        settingsButton.addAction(actionSettings, for: .touchUpInside)
    }
    
    func startGameButtonPressed() {
        let controller = GameViewController()
        navigationController?.pushViewController(controller, animated: true)
        
    }
    
    func recordsButtonPressed() {
        let controller = RecordsViewController()
        navigationController?.pushViewController(controller, animated: true)
        
    }
    
    func settingsButtonPressed() {
        let controller = SettingsViewController()
        navigationController?.pushViewController(controller, animated: true)
    
    }

    
 
    
}

