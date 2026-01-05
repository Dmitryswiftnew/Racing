
import Foundation
import UIKit
import SnapKit

class GameViewController: UIViewController {
    
    private var gameTimer = Timer()
    private var carTimer = Timer()
//    private var roadTimer = Timer()
    private var carStepSlowX: CGFloat = 30
    private var carStep: CGFloat = 5
//    private var stepForRoad: CGFloat = 5.0
    
    

//    private var roadAnimationTimer: Timer?
    private var isGamePaused = false
//    private var roadImageY1: CGFloat = 0  // позиция первой дороги
//    private var roadImageY2: CGFloat = -UIScreen.main.bounds.height  // позиция второй дороги
    
    private var displayLink: CADisplayLink?
    private var roadImageY1: CGFloat = 0
    private var roadImageY2: CGFloat = 0
    
    private var carBaseName: String = "CaCarCamaroNewSnadow"
    private var hasAnimation: Bool = true
    
    
    private let buttonBack: UIButton = {
        let button = UIButton()
        button.setTitle("Back", for: .normal)
        button.setTitleColor(.red, for: .normal)
        return button
    }()
    
    private let roadImage: UIImageView = {
        let imageView = UIImageView()
//        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    private let roadImageSecond: UIImageView = {
        let image = UIImageView()
//        image.contentMode = .scaleAspectFit
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
        label.font = .systemFont(ofSize: 20, weight: .regular)
        label.textColor = .white
        label.text = "0"
        return label
    }()
    
    private let numberOfTime: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 20, weight: .regular)
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
        let view = UIImageView()
        view.image = UIImage(named: "CarCamaroNewSnadow")
        view.dropShadow()
        view.layer.shadowColor = UIColor(.black).cgColor
        view.contentMode = .scaleAspectFill
        return view
    }()
    
    private let markImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "mark100")
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        return view
    }()
    
    private let binImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "bin")
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        return view
    }()
    
    private let objectImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "Truck")
        view.contentMode = .scaleAspectFill
        return view
    }()
    
    private let leftContainer: UIView = {
        let view = UIView()
//        view.backgroundColor = .red
//        view.alpha = 0.4
        return view
    }()
    
    
    private let rightContainer: UIView = {
        let view = UIView()
//        view.backgroundColor = .red
//        view.alpha = 0.4
    
        return view
    }()
    
    private let mainConteiner: UIView = {
        let view = UIView()
        //        view.backgroundColor = .white
        //        view.alpha = 0.1
        view.isUserInteractionEnabled = true
        return view
    }()
    
    private let roadContainer: UIView = {
        let view = UIView()
//        view.backgroundColor = .red
//        view.alpha = 0.1
        view.isUserInteractionEnabled = true
        return view
    }()
    
    private let startTimeLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(red: 225 / 255, green: 169 / 255, blue: 58 / 255, alpha: 1)
        label.font = UIFont(name: "Montserrat-Regular", size: 100)
//        label.font = .systemFont(ofSize: 80, weight: .bold)
        label.textAlignment = .center
        return label
    }()
    
    private var fireImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "fire")
        view.contentMode = .scaleAspectFit
        view.alpha = 0
        return view
    }()
    
    private let saveManager = SaveLoadManager()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cofigureUI()
        loadGameSettings()
        leftLongPressed()
        rightLongPressed()
        startTimeCount()
        
    }
    
    // MARK: - Configure UI
    
    private func cofigureUI() {
        view.backgroundColor = .systemBackground
        
                
        let settings = saveManager.loadSettings()
        let playerName = settings?.name ?? "Player"
        
        //MARK: - Road

        view.addSubview(roadImage)
        roadImage.image = UIImage(named: "roadE")
        roadImage.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)

        view.addSubview(roadImageSecond)
        roadImageSecond.image = UIImage(named: "roadE")
        roadImageSecond.frame = CGRect(x: 0, y: -view.frame.height, width: view.frame.width, height: view.frame.height)
        
        view.addSubview(mainConteiner)
        mainConteiner.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
   
        mainConteiner.addSubview(startTimeLabel)
        startTimeLabel.snp.makeConstraints { make in
            make.centerX.centerY.equalTo(mainConteiner)
            make.width.height.equalTo(200)
        }
        
        
        mainConteiner.addSubview(leftContainer)
        leftContainer.snp.makeConstraints { make in
            make.top.bottom.left.equalTo(mainConteiner)
            make.width.equalTo(mainConteiner).multipliedBy(1.0/6.0)
        }
        
        markImageView.backgroundColor = .red ///
        binImageView.backgroundColor = .red
        objectImageView.backgroundColor = .red
        carImageView.backgroundColor = .red
        
        mainConteiner.addSubview(rightContainer)
        rightContainer.snp.makeConstraints { make in
            make.top.bottom.right.equalTo(mainConteiner)
            make.width.equalTo(mainConteiner).multipliedBy(1.0/6.0)
        }
        
        view.layoutIfNeeded()
        
        mainConteiner.addSubview(markImageView) // mainContainer
        
        markImageView.frame = CGRect(x: rightContainer.frame.minX + 5, y: -300, width: 45, height: 110)
        
        leftContainer.addSubview(binImageView)
        binImageView.frame = CGRect(x: 10, y: -200, width: 50, height: 90)
        
        roadContainer.addSubview(objectImageView)  //   к mainConteiner
        objectImageView.frame = CGRect(x: 0, y: -400, width: 80, height: 140)
 
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
        mainConteiner.addSubview(roadContainer)
        roadContainer.snp.makeConstraints { make in
            make.top.bottom.equalTo(mainConteiner)
            make.left.equalTo(leftContainer.snp.right)
            make.right.equalTo(rightContainer.snp.left)
            
        }
        
        roadContainer.addSubview(buttonContainerView)
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
            
        }
     
        mainConteiner.addSubview(carImageView)
        carImageView.snp.makeConstraints { make in
            make.bottom.equalTo(buttonContainerView.snp.top).offset(-20)
            make.centerX.equalTo(mainConteiner)
            make.width.equalTo(70)
            make.height.equalTo(90)
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
        
        mainConteiner.addSubview(fireImageView)
        fireImageView.snp.makeConstraints { make in
            make.width.height.equalTo(160)
        }
        
        
        
//        fitFrameToImage2(carImageView, maxWidth: 100, maxHeight: 130)
//        fitFrameToImage2(binImageView, maxWidth: 80, maxHeight: 100)
       
    }
    
    
 
    
    
    
    func buttonBackPressed() {
        //        self.gameTimer.invalidate()
        navigationController?.popViewController(animated: true)
    }
    

// - MARK: Road control
    
    
    func startRoadAnimation() {
        displayLink?.invalidate()
        
        roadImageY1 = 0
        roadImageY2 = -view.frame.height
        updateRoadPositions()
        
        // CADisplayLink = ТОЧНО 120 FPS, синхронно с экраном
        displayLink = CADisplayLink(target: self, selector: #selector(displayLinkDidFire))
        displayLink?.add(to: .main, forMode: .default)
    }
    
    @objc private func displayLinkDidFire(_ displayLink: CADisplayLink) {
        guard !isGamePaused else { return }
        
        let settings = saveManager.loadSettings()
        let speed: CGFloat = settings?.speedGame ?? 5.0
        
        roadImageY1 += speed
        roadImageY2 += speed
        
        if roadImageY1 >= view.frame.height {
            roadImageY1 = roadImageY2 - view.frame.height
        }
        if roadImageY2 >= view.frame.height {
            roadImageY2 = roadImageY1 - view.frame.height
        }
        
        updateRoadPositions()
        
        binImageView.frame.origin.y += speed
        markImageView.frame.origin.y += speed
        objectImageView.frame.origin.y += speed
        
        if binImageView.frame.origin.y >= leftContainer.frame.height + 100 {
            binImageView.frame.origin.y = CGFloat.random(in: -400 ... -20)
        }
        if markImageView.frame.origin.y >= rightContainer.frame.height + 100 {
            markImageView.frame.origin.y = CGFloat.random(in: -300 ... -10)
        }
        if objectImageView.frame.origin.y >= roadContainer.frame.height + 100 {
            objectImageView.frame.origin.y = CGFloat.random(in: -500 ... -5)
            objectImageView.frame.origin.x = CGFloat.random(in: 0 ... roadContainer.frame.width - objectImageView.frame.width)
        }
        
        
        checkIntersects()
    }
    
    
    
    private func updateRoadPositions() {
        roadImage.frame.origin.y = roadImageY1
        roadImageSecond.frame.origin.y = roadImageY2
    }
    
    // - MARK: Stop animation
    
    private func recursivelyStopAnimations(_ view: UIView) {
        view.layer.removeAllAnimations()
        for subview in view.subviews {
            recursivelyStopAnimations(subview)
        }
    }
    

    // - MARK: Control car
    
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
            self.crashGame()
            return
        }
        
        if hasAnimation {
            carImageView.image = UIImage(named: "\(carBaseName.dropLast(6))Left")
        }
        
        UIView.animate(withDuration: 0.3) {
            self.carImageView.center.x = newX
        } completion: { _ in
            self.carImageView.image = UIImage(named: self.carBaseName) // назад возврат тачки
        }
        
    }
    
    func carMoveLeftActionLine() {
        carTimer = Timer.scheduledTimer(withTimeInterval: 0.3, repeats: true) { _ in
            let newX = self.carImageView.center.x - self.carStepSlowX
            if newX <= self.mainConteiner.frame.minX + 30 {
                self.crashGame()
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
            if hasAnimation {
                carImageView.image = UIImage(named: "\(carBaseName.dropLast(6))Left")
            }
        case .ended, .cancelled, .failed, .changed:
            self.carStopForControl()
            self.carImageView.image = UIImage(named: carBaseName)
        default:
            break
        }
    }
    
    func rightLongPressed() {              // buton right
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
            self.crashGame()
            return
        }
        
        if hasAnimation {
            carImageView.image = UIImage(named: "\(carBaseName.dropLast(6))Right")
        }
        
        UIView.animate(withDuration: 0.3) {
            self.carImageView.center.x = newX
        } completion: { _ in
            self.carImageView.image = UIImage(named: self.carBaseName)
        }
    }
    
    func carMoveRightActionLine() {
        carTimer = Timer.scheduledTimer(withTimeInterval: 0.3, repeats: true) { _ in
            let newX = self.carImageView.center.x + self.carStepSlowX
            if newX >= self.mainConteiner.frame.maxX - 30 {
                self.crashGame()
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
            if hasAnimation {
                carImageView.image = UIImage(named: "\(carBaseName.dropLast(6))Right")
            }
        case .ended, .cancelled, .failed, .changed:
            self.carStopForControl()
            self.carImageView.image = UIImage(named: carBaseName)
        default:
            break
        }
    }
    
    func carStopForControl() {
        self.carTimer.invalidate()
        self.carImageView.center.x += 0
    }
    
    
    
    
    private func checkIntersects() {
        
        guard let carPresentation = carImageView.layer.presentation()?.frame,
              let markPresentation = markImageView.layer.presentation()?.frame,
              let binPresentation = binImageView.layer.presentation()?.frame,
              let objectPresentation = objectImageView.layer.presentation()?.frame else {
            return
        }
  
        if carPresentation.intersects(binPresentation) {
            print("BIN")
            showFire(at: intersectionPoint(carPresentation, binPresentation))
            crashGame()
            return
        }
        if carPresentation.intersects(markPresentation) {
            print("MARK")
            showFire(at: intersectionPoint(carPresentation, markPresentation))
            crashGame()
            return
        }
        let objectGlobalFrame = roadContainer.convert(objectPresentation, to: mainConteiner)
        if carPresentation.intersects(objectPresentation) {
            print("OBJECT")
            showFire(at: intersectionPoint(carPresentation, objectGlobalFrame))
            crashGame()
            return
        }
        
    }
        
    
    private func showFire(at point: CGPoint) {
        fireImageView.center = point
        fireImageView.alpha = 1
    }
    
 
    private func intersectionPoint(_ rect1: CGRect, _ rect2: CGRect) -> CGPoint {
        let intersection = rect1.intersection(rect2)
        
        return CGPoint(
            x: intersection.midX,
            y: intersection.midY
            )
    }
    
    
    private func crashGame() {
        isGamePaused = true
        displayLink?.invalidate()
        gameTimer.invalidate()
        carTimer.invalidate()
        recursivelyStopAnimations(view)
        saveRaceRecord()
        showAlert(title: "💥 ФИАСКО БРАТАН!",
                     message: "Хочешь перезагрузить игру?",
                     onOK: { self.restGame() })
    }

    // - MARK: Pause & restart game
    
    func pauseGame() {
        isGamePaused = true
        displayLink?.invalidate()  // мгновенная остановка!
        gameTimer.invalidate()
        carTimer.invalidate()
        saveRaceRecord()
        recursivelyStopAnimations(view)
    }
    
    
    func restGame() {
       isGamePaused = false
        // Сброс позиции машины и счётчиков
        carImageView.center.x = mainConteiner.center.x
        carImageView.image = UIImage(named: carBaseName)
        
        numberOfTime.text = "0"
        numberOfScore.text = "0"
        fireImageView.alpha = 0

        
        binImageView.frame.origin.y = -200
        markImageView.frame.origin.y = -300
        objectImageView.frame.origin.y = -400
        objectImageView.frame.origin.x = 0
        
        roadImageY1 = 0
        roadImageY2 = -view.frame.height
        updateRoadPositions()
        
        startTimeLabel.isHidden = false
        startTimeCount()
    }
    
    
    
    // - MARK: ImageConfigure
    
//    private func fitImageViewToImage(_ imageView: UIImageView) {
//        guard let image = imageView.image else { return }
//        
//        let imageAspect = image.size.width / image.size.height
//        let viewAspect = imageView.frame.width / imageView.frame.height
//        
//        var newFrame = imageView.frame
//        
//        if imageAspect > viewAspect {
//            let newHeight = imageView.frame.width / imageAspect
//            newFrame.size.height = newHeight
//        } else {
//            let newWidth = imageView.frame.height * imageAspect
//            newFrame.size.width = newWidth
//        }
//        
//        imageView.frame = newFrame
//        imageView.contentMode = .scaleAspectFit
//        
//    }
//    
//    
//    
//    private func fitFrameToImage2(_ imageView: UIImageView, maxWidth: CGFloat, maxHeight: CGFloat) {
//        guard let image = imageView.image else { return }
//        
//        let imageSize = image.size
//        let scaleX = maxWidth / imageSize.width
//        let scaleY = maxHeight / imageSize.height
//        let scale = min(scaleX, scaleY)  // Сохраняем пропорции
//        
//        let newWidth = imageSize.width * scale
//        let newHeight = imageSize.height * scale
//        
//        // Центрируем по X и подгоняем по Y
//        let currentCenterX = imageView.center.x
//        imageView.frame.size = CGSize(width: newWidth, height: newHeight)
//        imageView.center.x = currentCenterX
//        imageView.contentMode = .scaleAspectFit
//    }

    
    
    
    // - MARK: Timer
    
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
        
        let timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [self] timer in
            second -= 1
            self.startTimeLabel.pulseAnimation()
            self.startTimeLabel.text = "\(second)"
            
            
            if second > 0 {
                self.startTimeLabel.text = "\(second)"
                self.startTimeLabel.pulseAnimation()
            } else if second == 0 {
                self.startTimeLabel.text = "GO!"
                self.startTimeLabel.pulseAnimation()
            } else {
                timer.invalidate()
                self.startTimeLabel.isHidden = true
                self.mainTimeCount()
                self.startRoadAnimation()
            }
        }
        
        timer.fire()
    }
    
    
    
    // - MARK: Save & load record and object
   
    private func saveRaceRecord() {
        let time  = Int(numberOfTime.text ?? "0") ?? 0
        
        let settings = saveManager.loadSettings()
        let playerName = settings?.name ?? "Player"
        
        let newRecord = RaceRecord(playerName: playerName, time: time, date: Date())
        
        var records = saveManager.loadRecords() // загрузка сохраненных к нему добавляем новый рекорд и сортируем по убыванию
        records.append(newRecord)
        records.sort { $0.time > $1.time}  // нужно ли вторая тут сортировка 
        
        saveManager.saveRecords(records)
    }
    
    
    // - MARK: Load settings
    
    private func loadGameSettings() {
        let settings = saveManager.loadSettings() ?? PlayerSettings(name: "Player", carName: "CarCamaroNewSnadow", objectName: "Police", speedGame: 5.0)
        
        carImageView.image = UIImage(named: settings.carName)
        
        objectImageView.image = UIImage(named: settings.objectName)
        
        carBaseName = settings.carName
        hasAnimation = settings.carName == "CarCamaroNewSnadow"
        
        print("Гружу настройки \(settings.carName), \(settings.objectName), скорость \(settings.speedGame)")
    
    }
    
    
}
