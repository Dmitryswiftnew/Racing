
import Foundation
import UIKit
import SnapKit

class SettingsViewController: UIViewController {
    
    let screenHeight = UIScreen.main.bounds.height
    
    
    private let backButton: UIButton = {
        let button = UIButton(type: .system)
        let backImage = UIImage(systemName: "chevron.left")
        button.tintColor = UIColor(red: 225 / 255, green: 169 / 255, blue: 58 / 255, alpha: 1)
        button.titleLabel?.font = UIFont(name: "Montserrat-Regular", size: 20)
        button.setTitleColor(UIColor(red: 225 / 255, green: 169 / 255, blue: 58 / 255, alpha: 1), for: .normal)
        button.setImage(backImage, for: .normal)
        button.setTitle("MENU", for: .normal)
        
        return button
    }()
    
    private let mainContainerView: UIView = {
        let view = UIView()
//        view.backgroundColor = .lightGray
//        view.alpha = 0.3
        view.isUserInteractionEnabled = true
        return view
    }()
    
    private let mainImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "Settings")
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    
    private let carImage: UIImageView = {
        let image = UIImageView()
        image.backgroundColor = .brown
        return image
    }()
    
    private let buttonCarLeft: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("←", for: .normal)
        button.setTitleColor(.yellow, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 40, weight: .bold)
        return button
    }()
    
    private let buttonCarRight: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("→", for: .normal)
        button.setTitleColor(.yellow, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 40, weight: .bold)
        return button
    }()
    
    private let imageObject: UIImageView = {
        let image = UIImageView()
        image.backgroundColor = .yellow
        return image
    }()
    
    private let buttonObjectLeft: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("←", for: .normal)
        button.setTitleColor(.yellow, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 40, weight: .bold)
        return button
    }()
    
    private let buttonObjectRight: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("→", for: .normal)
        button.setTitleColor(.yellow, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 40, weight: .bold)
        return button
    }()
    
    private let profileConteiner: UIView = {
        let view = UIView()
//        view.backgroundColor = .clear
//        view.alpha = 0.3
        return view
    }()
    
    private let carConteiner: UIView = {
        let view = UIView()
        view.backgroundColor = .red
        view.alpha = 0.3
        return view
    }()
    
    private let roadObjectContainer: UIView = {
        let view = UIView()
        view.backgroundColor = .green
        view.alpha = 0.3
        return view
    }()
    
    private let photoImage: UIImageView = {
        let view = UIImageView()
        view.backgroundColor = .blue
        view.alpha = 1
        view.layer.masksToBounds = true
        return view
    }()
    
    private let nameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "name"
        
        textField.backgroundColor = .white.withAlphaComponent(0.5)
        textField.layer.borderColor = UIColor.orange.cgColor
        textField.layer.borderWidth = 2
        textField.layer.cornerRadius = 12
        textField.textAlignment = .center
        textField.textColor = .black
//        textField.returnKeyType = .done
        
        textField.isUserInteractionEnabled = true
        return textField
    }()
    
    private let manager = SaveLoadManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
         configureUI()
         loadText()

        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        photoImage.layer.cornerRadius = photoImage.frame.height / 2
    }
    
    private func configureUI() {
        view.backgroundColor = .systemBackground
        
        
        
        view.addSubview(mainImage)
        mainImage.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        let tapGesure = UITapGestureRecognizer(target: self, action: #selector(hideKeboard))
        mainContainerView.addGestureRecognizer(tapGesure)
        
        
        
        
        view.addSubview(mainContainerView)
        mainContainerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        
        
        
        view.addSubview(backButton)
        backButton.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.top.equalToSuperview().offset(50)
            make.height.equalTo(40)
        }
        
        let backButtonAction = UIAction { _ in
            self.backButtonPressed()
        }
        backButton.addAction(backButtonAction, for: .touchUpInside)
        
        
        
        mainContainerView.addSubview(profileConteiner)
        profileConteiner.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(screenHeight / 6)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().inset(16)
            make.height.equalTo(screenHeight / 4)
        }
        
        
       
        profileConteiner.addSubview(photoImage)
        photoImage.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
            make.height.width.equalTo(120)
        }

        
        profileConteiner.addSubview(nameTextField)
        nameTextField.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.left.right.equalToSuperview()
            make.height.equalTo(profileConteiner).multipliedBy(1.0 / 4.0)
        }
     
        
        mainContainerView.addSubview(carConteiner)
        carConteiner.snp.makeConstraints { make in
            make.top.equalTo(profileConteiner.snp.bottom)
            make.left.equalTo(profileConteiner)
            make.right.equalTo(profileConteiner)
            make.height.equalTo(profileConteiner)
        }
        
        mainContainerView.addSubview(roadObjectContainer)
        roadObjectContainer.snp.makeConstraints { make in
            make.top.equalTo(carConteiner.snp.bottom)
            make.right.equalTo(carConteiner)
            make.left.equalTo(carConteiner)
            make.height.equalTo(carConteiner)
        }
        
  
        carConteiner.addSubview(carImage)
        carImage.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(1.0 / 3.0)
            make.height.equalTo(130)
        
        }
        
        carConteiner.addSubview(buttonCarLeft)
        buttonCarLeft.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview()
        }
        
        
        carConteiner.addSubview(buttonCarRight)
        buttonCarRight.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview()
        }
        
        roadObjectContainer.addSubview(imageObject)
        imageObject.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(1.0 / 3.0)
            make.height.equalTo(130)
        }
        
        roadObjectContainer.addSubview(buttonObjectLeft)
        buttonObjectLeft.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview()
        }
        
        
        roadObjectContainer.addSubview(buttonObjectRight)
        buttonObjectRight.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview()
        }
        
    }
    

    
    
    func backButtonPressed() {
        navigationController?.popViewController(animated: true)
        self.savePressed()
    }
    
    
    @objc func hideKeboard(_ gesture: UITapGestureRecognizer) {
        
        let location = gesture.location(in: profileConteiner)
        
        guard nameTextField.frame.contains(location) else { // исключаем textField
            view.endEditing(true)
            self.savePressed()
            return
        }
        
     
    }
    
    
    
    
    func savePressed() {
        if let text = nameTextField.text {
            manager.saveText(text)
        }
    }
    
    
    func loadText() {
        if let text = manager.loadText(for: Keys.namePlayer),
            text.isEmpty == false {
            nameTextField.text = text
        } else {
            nameTextField.text = "Player" // новые изменения 
        }
    }
    
    
}
