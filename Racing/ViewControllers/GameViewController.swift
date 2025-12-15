
import Foundation
import UIKit

class GameViewController: UIViewController {
    
    private var gameTimer = Timer()
    private var carTimer = Timer()
    private var roadTimer = Timer()
    private var carStepSlowX: CGFloat = 30
    private var carStep: CGFloat = 5
    
    private var stepForRoad: CGFloat = 5.0
    
    private let buttonBack: UIButton = {
        let button = UIButton()
        button.setTitle("Back", for: .normal)
        button.setTitleColor(.red, for: .normal)
        return button
    }()
    
    private let roadImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    private let roadImageSecond: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.isUserInteractionEnabled = true
        return image
    }()
    
    private let labelContainerView: UIView = {
        let uiView = UIView()
        //        uiView.backgroundColor = .yellow
        return uiView
    }()
    
    private let numberOfScore: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.textColor = .white
        label.text = "0"
        return label
    }()
    
    private let numberOfTime: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.text = "0"
        return label
    }()
    
    
    private let labelTime: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.text = "TIME"
        label.dropShadow()
        label.layer.shadowColor = UIColor(.black).cgColor
        return label
    }()
    private let labelScore: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.text = "SCORE"
        return label
    }()
    
    private let buttonContainerView: UIView = {
        let view = UIView()
        view.isUserInteractionEnabled = true
        return view
    }()
    
    private let buttonLeft: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("←", for: .normal)
        button.setTitleColor(.yellow, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 40, weight: .bold)
        return button
    }()
    
    
    private let buttonRight: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("→", for: .normal)
        button.setTitleColor(.yellow, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 40, weight: .bold)
        return button
    }()
    
    
    private let carImageView: UIImageView = {
        let uiView = UIImageView()
        uiView.image = UIImage(named: "CarCamaroNewSnadow")
        uiView.dropShadow()
        uiView.layer.shadowColor = UIColor(.black).cgColor
        uiView.contentMode = .scaleAspectFit
        return uiView
    }()
    
    private let markImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "mark100")
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    private let binImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "bin")
        return view
    }()
    
    private let leftContainer: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.alpha = 0.3
        return view
    }()
    
    
    private let rightContainer: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.alpha = 0.3
        return view
    }()
    
    private let mainConteiner: UIView = {
        let view = UIView()
        //        view.backgroundColor = .white
        //        view.alpha = 0.1
        view.isUserInteractionEnabled = true
        return view
    }()
    
    private let startTimeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        //        label.backgroundColor = .lightGray
        label.font = .systemFont(ofSize: 100, weight: .bold)
        label.textAlignment = .center
        return label
    }()
    
    private let saveManager = SaveLoadManager()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cofigureUI()
        leftLongPressed()
        rightLongPressed()
        moveAnimationForRoad()
        startTimeCount()
    }
    
    // MARK: - Configure UI
    
    private func cofigureUI() {
        view.backgroundColor = .systemBackground
        
        let settings = saveManager.loadSettings()
        let playerName = settings?.name ?? "Player"
        
        //MARK: - Road
        view.addSubview(roadImage)
        roadImage.image = UIImage(named: "road2")
        roadImage.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.right.equalToSuperview()
            make.height.equalToSuperview()
        }
        
        view.addSubview(roadImageSecond)
        roadImageSecond.image = UIImage(named: "road2")
        roadImageSecond.snp.makeConstraints { make in
            make.top.equalTo(roadImage.snp.bottom)
            make.right.left.equalToSuperview()
            make.height.equalToSuperview()
        }
        
        view.addSubview(mainConteiner)
        mainConteiner.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        mainConteiner.addSubview(startTimeLabel)
        startTimeLabel.snp.makeConstraints { make in
            make.centerX.centerY.equalTo(mainConteiner)
            make.width.height.equalTo(80)
        }
        
        
        mainConteiner.addSubview(leftContainer)
        leftContainer.snp.makeConstraints { make in
            make.top.bottom.left.equalTo(mainConteiner)
            make.width.equalTo(mainConteiner).multipliedBy(1.0/6.0)
        }
        
        mainConteiner.addSubview(rightContainer)
        rightContainer.snp.makeConstraints { make in
            make.top.bottom.right.equalTo(mainConteiner)
            make.width.equalTo(mainConteiner).multipliedBy(1.0/6.0)
        }
        
        rightContainer.addSubview(markImageView)
        markImageView.snp.makeConstraints { make in
            make.top.equalTo(rightContainer).offset(300)
            make.centerX.equalTo(rightContainer)
            make.width.equalTo(60)
            make.height.equalTo(160)
        }
        
        leftContainer.addSubview(binImageView)
        binImageView.snp.makeConstraints { make in
            make.top.equalTo(leftContainer).offset(100)
            make.centerX.equalTo(leftContainer)
            make.width.equalTo(60)
            make.height.equalTo(120)
        }
        
        
        
        view.addSubview(buttonBack)
        buttonBack.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.top.equalToSuperview().offset(50)
            make.height.equalTo(40)
        }
        
        let buttonBackAction = UIAction { _ in
            self.buttonBackPressed()
        }
        
        buttonBack.addAction(buttonBackAction, for: .touchUpInside)
        
        //MARK: - Container buttons
        mainConteiner.addSubview(buttonContainerView)
        buttonContainerView.snp.makeConstraints { make in
            make.left.right.equalTo(mainConteiner).inset(60)
            make.bottom.equalTo(mainConteiner).inset(20)
            make.height.equalTo(60)
        }
        
        
        buttonContainerView.addSubview(buttonLeft)
        buttonLeft.snp.makeConstraints { make in
            make.left.equalTo(buttonContainerView.snp.left)
            make.top.bottom.equalTo(buttonContainerView)
        }
        
        buttonContainerView.addSubview(buttonRight)
        buttonRight.snp.makeConstraints { make in
            make.right.equalTo(buttonContainerView.snp.right)
            make.bottom.top.equalTo(buttonContainerView)
            //
        }
        
        
        mainConteiner.addSubview(carImageView)
        carImageView.snp.makeConstraints { make in
            make.bottom.equalTo(buttonContainerView.snp.top).offset(-20)
            make.centerX.equalTo(mainConteiner)
            make.width.equalTo(120)
            make.height.equalTo(140)
        }
        
        
        
        mainConteiner.addSubview(labelContainerView)
        labelContainerView.snp.makeConstraints { make in
            make.top.equalTo(mainConteiner).offset(20)
            make.right.equalTo(mainConteiner).inset(16)
            make.height.width.equalTo(100)
        }
        
        labelContainerView.addSubview(labelScore)
        labelScore.snp.makeConstraints { make in
            make.bottom.equalTo(labelContainerView.snp.bottom)
            make.left.equalTo(labelContainerView)
        }
        
        labelContainerView.addSubview(numberOfScore)
        numberOfScore.snp.makeConstraints { make in
            make.bottom.equalTo(labelContainerView.snp.bottom)
            make.right.equalTo(labelContainerView)
        }
        
        
        labelContainerView.addSubview(labelTime)
        labelTime.snp.makeConstraints { make in
            make.bottom.equalTo(numberOfScore.snp.top)
            make.left.equalTo(labelContainerView)
        }
        
        labelContainerView.addSubview(numberOfTime)
        numberOfTime.snp.makeConstraints { make in
            make.bottom.equalTo(numberOfScore.snp.top)
            make.right.equalTo(labelContainerView)
        }
        
        
    }
    
    // - MARK: Control car
    
    func buttonBackPressed() {
        //        self.gameTimer.invalidate()
        navigationController?.popViewController(animated: true)
    }
    
    private func moveAnimationForRoad() {
        roadTimer = Timer.scheduledTimer(withTimeInterval: 1.0/60.0, repeats: true) {
            timer in
            self.moveRoad()
            
        }
    }
    
    
    
    func moveRoad() {
        // Двигаем
        roadImage.frame.origin.y += stepForRoad
        roadImageSecond.frame.origin.y += stepForRoad
        
        // Если верхний край первой картинки достиг низа экрана
        if roadImage.frame.origin.y >= view.frame.height {
            // Ставим ее под второй картинкой
            roadImage.frame.origin.y = roadImageSecond.frame.origin.y - view.frame.height
        }
        
        // Если верхний край второй картинки достиг низа экрана
        if roadImageSecond.frame.origin.y >= view.frame.height {
            // Ставим ее под первой картинкой
            roadImageSecond.frame.origin.y = roadImage.frame.origin.y - view.frame.height
        }
    }
    
    func leftLongPressed() {  //  Button left
        let action = UIAction { _ in
            self.leftMove()
        }
        buttonLeft.addAction(action, for: .touchUpInside)
        let recognizer = UILongPressGestureRecognizer(target: self, action: #selector(recognizerLongTapLeft))
        recognizer.minimumPressDuration = 0.5
        buttonLeft.addGestureRecognizer(recognizer)
        
    }
    
    func leftMove() {                                             // Просто смещение ввлево
        let newX = carImageView.center.x - carStep
        if newX <= mainConteiner.frame.minX + 30 {
            gameTimer.invalidate()
            self.saveRaceRecord()
            self.showAlert(title: "ФИАСКО БРАТАН", message: "Хочешь перезагрузить игру?", onOK: { self.restGame()})
            return
        }
        carImageView.image = UIImage(named: "CarCamaroNewLeft")
        UIView.animate(withDuration: 0.3) {
            self.carImageView.center.x = newX
        } completion: { _ in
            self.carImageView.image = UIImage(named: "CarCamaroNewSnadow") // назад возврат тачки
        }
        
    }
    
    func carMoveLeftActionLine() {
        carTimer = Timer.scheduledTimer(withTimeInterval: 0.3, repeats: true) { _ in
            let newX = self.carImageView.center.x - self.carStepSlowX
            if newX <= self.mainConteiner.frame.minX + 30 {
                self.gameTimer.invalidate()
                self.saveRaceRecord()
                self.showAlert(title: "ФИАСКО БРАТАН", message: "Хочешь перезагрузить игру?", onOK: {self.restGame()})
                return
            }
            UIView.animate(withDuration: 0.3, delay: 0, options: .curveLinear) {
                self.carImageView.center.x = newX
            }
            self.view.layoutIfNeeded()
            
        }
        carTimer.fire()
    }
    
    @objc func recognizerLongTapLeft(_ gesture: UILongPressGestureRecognizer) {
        switch gesture.state {
        case.began:
            self.carMoveLeftActionLine()
            carImageView.image = UIImage(named: "CarCamaroNewLeft")
        case .ended, .cancelled, .failed, .changed:
            self.carStop()
            self.carImageView.image = UIImage(named: "CarCamaroNewSnadow")
        default:
            break
        }
    }
    
    func rightLongPressed() {              // buuton right
        let action = UIAction { _ in
            self.rightMove()
        }
        buttonRight.addAction(action, for: .touchUpInside)
        let recognizer = UILongPressGestureRecognizer(target: self, action: #selector(recognizerLongTapRight))
        recognizer.minimumPressDuration = 0.5
        buttonRight.addGestureRecognizer(recognizer)
    }
    
    func rightMove() {
        let newX = carImageView.center.x + carStep
        if newX >= mainConteiner.frame.maxX - 30 {
            self.gameTimer.invalidate()
            self.saveRaceRecord()
            self.showAlert(title: "ФИАСКО БРАТАН", message: "Хочешь перезагрузить игру?", onOK: {self.restGame()})
            return
        }
        carImageView.image = UIImage(named: "CarCamaroNewRight")
        UIView.animate(withDuration: 0.3) {
            self.carImageView.center.x = newX
        } completion: { _ in
            self.carImageView.image = UIImage(named: "CarCamaroNewSnadow")
        }
    }
    
    func carMoveRightActionLine() {
        carTimer = Timer.scheduledTimer(withTimeInterval: 0.3, repeats: true) { _ in
            let newX = self.carImageView.center.x + self.carStepSlowX
            if newX >= self.mainConteiner.frame.maxX - 30 {
                self.gameTimer.invalidate()
                self.saveRaceRecord()
                self.showAlert(title: "ФИАСКО БРАТАН", message: "Хочешь перезагрузить игру?", onOK: {self.restGame()})
                return
            }
            UIView.animate(withDuration: 0.3, delay: 0, options: .curveLinear) {
                self.carImageView.center.x = newX
            }
            self.view.layoutIfNeeded()
        }
        carTimer.fire()
    }
    
    @objc func recognizerLongTapRight(_ gesture: UILongPressGestureRecognizer) {  // обработчик
        switch gesture.state {
        case .began:
            self.carMoveRightActionLine()
            carImageView.image = UIImage(named: "CarCamaroNewRight")
        case .ended, .cancelled, .failed, .changed:
            self.carStop()
            self.carImageView.image = UIImage(named: "CarCamaroNewSnadow")
        default:
            break
        }
    }
    
    func carStop() {
        self.carTimer.invalidate()
        self.carImageView.center.x += 0
    }
    // - MARK: Restart game
    func restGame() {
        carImageView.center.x = mainConteiner.center.x
        numberOfTime.text = "0"
        numberOfScore.text = "0"
        startTimeCount()
    }
    
    // MARK: Timer
    
    func mainTimeCount() {
        gameTimer.invalidate()
        numberOfTime.text = "0"
        var second = 0
        
        let timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
            second += 1
            self.numberOfTime.text = "\(second)"
        }
        
        timer.fire()
        
        self.gameTimer = timer
    }
    
    func startTimeCount() {
        startTimeLabel.text = "4"
        startTimeLabel.isHidden = false
        var second = 4
        
        let timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
            second -= 1
            self.startTimeLabel.pulseAnimation()
            self.startTimeLabel.text = "\(second)"
            
            if second <= 0 {
                timer.invalidate()
                self.startTimeLabel.isHidden = true
                self.mainTimeCount()
            }
        }
        
        timer.fire()
    }
    
   
    private func saveRaceRecord() {
        let time  = Int(numberOfTime.text ?? "0") ?? 0
        
        let settings = saveManager.loadSettings()
        let playerName = settings?.name ?? "Player"
        
        let newRecord = RaceRecord(playerName: playerName, time: time)
        
        var records = saveManager.loadRecords() // загрузка сохраненных к нему добавляем новый рекорд и сортируем по убыванию
        records.append(newRecord)
        records.sort { $0.time > $1.time}  // нужно ли вторая тут сортировка 
        
        saveManager.saveRecords(records)
    }
    
    
    
}
