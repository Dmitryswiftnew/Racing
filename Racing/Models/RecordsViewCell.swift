
import Foundation
import UIKit
import SnapKit

final class RecordsViewCell: UITableViewCell {
    static var identifier: String { "\(Self.self)" }
    
    private let positionLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 20, weight: .regular)
        label.textColor = .white
        return label
    }()
  
    private let playerNameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.textColor = .white
        return label
    }()
    
    private let timeLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 22, weight: .regular)
        label.textColor = .white
        return label
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = .white
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        
        backgroundColor = UIColor.clear
        contentView.backgroundColor = UIColor.black.withAlphaComponent(0.2)
        
        contentView.addSubview(positionLabel)
        positionLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().inset(16)
            make.top.equalToSuperview().offset(16)
        }
        
        contentView.addSubview(playerNameLabel)
        playerNameLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.top.equalTo(positionLabel.snp.bottom).offset(8)
            make.bottom.equalToSuperview().inset(16)
        }
        
        contentView.addSubview(timeLabel)
        timeLabel.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }
        
        contentView.addSubview(dateLabel)
        dateLabel.snp.makeConstraints { make in
            make.right.equalToSuperview().inset(16)
            make.top.equalToSuperview().offset(16)
            make.bottom.equalToSuperview().inset(16)
        }
    }
    
    func configure(with record: RaceRecord, position: Int ) {
        positionLabel.text = "\(position)"
        playerNameLabel.text = record.playerName
        timeLabel.text = "\(record.time)"
        dateLabel.text = dateFormatter.string(from: record.date)
    }
    
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy - HH:mm"
        formatter.locale = Locale.current
        return formatter
    }()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        [positionLabel, playerNameLabel, timeLabel, dateLabel].forEach { $0.text = nil }
    }
    
}
