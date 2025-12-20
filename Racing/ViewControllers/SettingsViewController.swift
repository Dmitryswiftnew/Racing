
import Foundation
import UIKit
import SnapKit

class SettingsViewController: UIViewController {
    
    let screenHeight = UIScreen.main.bounds.height
    private let availableCars = ["CarCamaro", "Mustang", "P"]
    private let availableObjects = ["bin", "mark100"]
    
    private var currentCarIndex = 0
    private var currentObjectIndex = 0
    
    
    private let backButton: UIButton = {
        let button = UIButton(type: .system)
        let backImage = UIImage(systemName: "chevron.left")
        button.tintColor = UIColor(red: 225 / 255, green: 169 / 255, blue: 58 / 255, alpha: 1)
        button.titleLabel?.font = UIFont(name: "Montserrat-Regular", size: 20)
        button.setTitleColor(UIColor(red: 225 / 255, green: 169 / 255, blue: 58 / 255, alpha: 1), for: .normal)
        button.setImage(backImage, for: .normal)
        button.setTitle("", for: .normal)
        
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
        image.contentMode = .scaleAspectFit
//        image.backgroundColor = .brown
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
    
    private let objectImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
//        image.backgroundColor = .yellow
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
//                view.backgroundColor = .white
//                view.alpha = 0.3
        return view
    }()
    
    private let carConteiner: UIView = {
        let view = UIView()
//        view.backgroundColor = .red
//        view.alpha = 0.3
        return view
    }()
    
    private let roadObjectContainer: UIView = {
        let view = UIView()
//        view.backgroundColor = .green
//        view.alpha = 0.3
        return view
    }()
    
    private let photoImage: UIImageView = {
        let view = UIImageView()
        let backImage = UIImage(systemName: "person.crop.circle.fill.badge.plus")
        view.image = backImage
        view.tintColor = .white
        view.backgroundColor = .lightGray
        view.contentMode = .scaleAspectFill
        //        view.alpha = 1
        view.layer.masksToBounds = true
        view.isUserInteractionEnabled = true
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
    
    private let saveManager = SaveLoadManager()
    private var playerSettings = PlayerSettings(name: "Player", carName: "CarCamaro", objectName: "bin")
    //    private var playerSettings: PlayerSettings? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        //        loadText()
        loadSettings()
        loadImageProfile()
        
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
        
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard)) // запихнуть в отдельную функцию
        mainContainerView.addGestureRecognizer(tapGesture)
        
        profileConteiner.addSubview(photoImage)
        photoImage.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
            make.height.width.equalTo(120)
        }
        
        
        
        let tapImageGesture = UITapGestureRecognizer(target: self, action: #selector(photoImageTapped))
        photoImage.addGestureRecognizer(tapImageGesture)
        
        
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
        
        let actionCarLeft = UIAction { _ in
            self.leftCarButtonPressed()
        }
        buttonCarLeft.addAction(actionCarLeft, for: .touchUpInside)
        
        carConteiner.addSubview(buttonCarRight)
        buttonCarRight.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview()
        }
        
        let actionCarRight = UIAction { _ in
            self.rightCarButtonPressed()
        }
        buttonCarRight.addAction(actionCarRight, for: .touchUpInside)
        
        roadObjectContainer.addSubview(objectImage)
        objectImage.snp.makeConstraints { make in
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
        
        
        let actionObjectLeft = UIAction { _ in
            self.leftObjectButtonPressed()
        }
        buttonObjectLeft.addAction(actionObjectLeft, for: .touchUpInside)
        
        roadObjectContainer.addSubview(buttonObjectRight)
        buttonObjectRight.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview()
        }
        
        let actionObjectRight = UIAction { _ in
            self.rightObjectButtonPressed()
        }
        buttonObjectRight.addAction(actionObjectRight, for: .touchUpInside)
        
        
    }
    
    func backButtonPressed() {
    
        
        if let text = nameTextField.text,
           text.isEmpty {
            nameTextField.text = "Player"
        }
        navigationController?.popViewController(animated: true)
        //        self.savePressed()
        self.saveCurrentSettings()
//        guard let text = saveManager.loadSettings() else { return }
//        print(text.name)
        
    }
    
    
    @objc func hideKeyboard(_ gesture: UITapGestureRecognizer) {
        
        //        let location = gesture.location(in: profileConteiner)
        
        view.endEditing(true) // просто добавить остальное в этом коде убрать
        //        guard nameTextField.frame.contains(location) else { // исключаем textField
        //            view.endEditing(true)
        //            self.savePressed()
        //            return
        //        }
        
    }
    
    
    //    func savePressed() {
    //        if let text = nameTextField.text {
    //            manager.saveText(text)
    //        }
    //    }
    //
    //
    //    func loadText() {
    //        if let text = manager.loadText(for: Keys.namePlayer), // проверка через запятую
    //            text.isEmpty == false {
    //            nameTextField.text = text
    //        } else {
    //            nameTextField.text = "Player" // новые изменения
    //        }
    //    }
    
    
    
    func loadSettings() {
        
        
        if let settings = saveManager.loadSettings() {
            self.playerSettings = settings
            nameTextField.text = settings.name
            
            
            carImage.image = UIImage(named: settings.carName)
            objectImage.image = UIImage(named: settings.objectName)
            
            currentCarIndex = availableCars.firstIndex(of: settings.carName) ?? 0
            currentObjectIndex = availableObjects.firstIndex(of: settings.objectName) ?? 0
            
            
        } else {
            
            let defaultSettings = PlayerSettings(name: "Player", carName: "CarCamaro", objectName: "bin")
            self.playerSettings = defaultSettings
            nameTextField.text = defaultSettings.name
            carImage.image = UIImage(named: defaultSettings.carName)
            objectImage.image = UIImage(named: defaultSettings.objectName)
        }
        
    }
    
    
    func saveCurrentSettings() {
        let name = nameTextField.text ?? "Player"
        
        let carName = playerSettings.carName
        let objectName = playerSettings.objectName
        
        let settings = PlayerSettings(name: name, carName: carName, objectName: objectName)
        saveManager.saveSettings(settings)
        self.playerSettings = settings
    }
    
    
    private func showImagePickerAlert() {
        let alert = UIAlertController(
            title: "Chose media source",
            message: nil,
            preferredStyle: .actionSheet
        )
        
        let cameraAction = UIAlertAction(title: "Camera", style: .default) { [weak self] _ in
            self?.showPicker(.camera)
        }
        alert.addAction(cameraAction)
        
        let libraryAction = UIAlertAction(title: "Photo Library", style: .default) { [weak self] _ in
            self?.showPicker(.photoLibrary)
        }
        alert.addAction(libraryAction)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        alert.addAction(cancelAction)
        
        present(alert, animated: true)
    }
    
    
    
    @objc func photoImageTapped() {
        print("Жмем на наш имадж")
        showImagePickerAlert()
    }
    
    
    
    private func showPicker(_ sourceType: UIImagePickerController.SourceType) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = sourceType
        present(imagePicker, animated: true)
    }
    
    
    private func loadImageProfile() {
        if let imageName = saveManager.loadImageName(),
           let image = saveManager.loadImage(name: imageName) {
            photoImage.image = image
        }
    }
    
    // - MARK: shuffle buttons
    func leftCarButtonPressed() {
        currentCarIndex = (currentCarIndex - 1 + availableCars.count) % availableCars.count
        playerSettings.carName = availableCars[currentCarIndex]
        carImage.image = UIImage(named: playerSettings.carName)
        
    }
    
    func rightCarButtonPressed() {
        currentCarIndex = (currentCarIndex + 1) % availableCars.count
        playerSettings.carName = availableCars[currentCarIndex]
        carImage.image = UIImage(named: playerSettings.carName)
    }
    
    
    func leftObjectButtonPressed() {
        currentObjectIndex = (currentObjectIndex - 1 + availableObjects.count) % availableObjects.count
        playerSettings.objectName = availableObjects[currentObjectIndex]
        objectImage.image = UIImage(named: playerSettings.objectName)
    }
    
    func rightObjectButtonPressed() {
        currentObjectIndex = (currentObjectIndex + 1) % availableObjects.count
        playerSettings.objectName = availableObjects[currentObjectIndex]
        objectImage.image = UIImage(named: playerSettings.objectName)
    }
    
    
    
}






extension SettingsViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else { return }
        self.photoImage.image = image
        if let imageName = saveManager.saveImage(image: image) {
            saveManager.saveImageName(imageName)
            
        }
        
        
        picker.dismiss(animated: true)
    }
    
    func imagePickerControllerDidCancel (_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
    
}
