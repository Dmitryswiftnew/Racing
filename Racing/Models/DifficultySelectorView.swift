
import Foundation
import UIKit
import SnapKit


class DifficultySelectorView: UIView {
    
    private let stackView = UIStackView()
    private var buttons = [UIButton]()
    var selectedIndex: Int  = 1 {
        didSet {
            updateSelection()
        }
    }
    
    private let speeds = [3.0, 5.0, 8.0]
    var onSpeedChanged: ((CGFloat)  -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    
    private func setup() {
        stackView.axis = .horizontal
        stackView.spacing = 25
        stackView.distribution = .fillEqually
        addSubview(stackView)
        stackView.snp.makeConstraints { $0.edges.equalToSuperview().inset(10)}
        
        ["Easy", "Normal", "Hard"].enumerated().forEach { index, title in
            let button = UIButton(type: .custom)
            button.tag = index
            button.setTitle(title, for: .normal)
            button.setTitleColor(.white, for: .normal)
            button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
            button.layer.cornerRadius = 30
            button.backgroundColor = UIColor.black.withAlphaComponent(0.3)
            button.layer.borderWidth = 1.5
            button.layer.borderColor = UIColor.orange.cgColor
            
            button.addTarget(self, action: #selector(tappedDifficultyButton(_ :)), for: .touchUpInside)
            buttons.append(button)
            stackView.addArrangedSubview(button)
            
        }
        
        updateSelection()
        
    }
    
    
    @objc private func tappedDifficultyButton(_ sender: UIButton) {
        selectedIndex = sender.tag
        onSpeedChanged?(speeds[selectedIndex])
    }
    
    private func updateSelection() {
        buttons.enumerated().forEach{ i, button in
            button.isSelected = i == selectedIndex
            button.backgroundColor = i == selectedIndex ? .yellow :
            UIColor.black.withAlphaComponent(0.3)
            button.setTitleColor(i == selectedIndex ? .black : .white, for: .normal)
        }
    }
    
    
}
