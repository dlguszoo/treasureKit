// Copyright © 2024 DRINKIG. All rights reserved

import UIKit
import SnapKit
import Then
import SDWebImage

public class SampleTableViewCell: UITableViewCell, ViewConfigurable {
    private lazy var image = UIImageView().then {
        $0.contentMode = .scaleAspectFill
        $0.layer.cornerRadius = 5
        $0.layer.masksToBounds = true
    }
    
    private lazy var title = UILabel().then {
        $0.textColor = .black
        $0.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        $0.numberOfLines = 1
        $0.lineBreakMode = .byTruncatingTail
    }
    
    private lazy var contents = UILabel().then {
        $0.textColor = .black
        $0.font = UIFont.systemFont(ofSize: 10, weight: .regular)
        $0.numberOfLines = 0
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
        addComponents()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        contentView.backgroundColor = .white
        selectionStyle = .none
    }
    
    func addComponents() {
        [image, title, contents].forEach { contentView.addSubview($0) }
    }
    
    func setupConstraints() {
        image.snp.makeConstraints {
            $0.verticalEdges.equalToSuperview().inset(16)
            $0.leading.equalToSuperview().offset(16)
            $0.width.height.equalTo(50)
        }
        title.snp.makeConstraints {
            $0.top.equalTo(image.snp.top)
            $0.leading.equalTo(image.snp.trailing).offset(5)
            $0.trailing.equalToSuperview().offset(-16)
        }
        contents.snp.makeConstraints {
            $0.leading.equalTo(title.snp.leading)
            $0.top.equalTo(title.snp.bottom).offset(5)
        }
    }
    
    typealias DataType = ExModel
    public func configure(with data: ExModel) {
        if let url = URL(string: data.imageURL) {
            image.sd_setImage(with: url, placeholderImage: UIImage(named: "placeholder"))
        } else {
            image.image = UIImage(named: "placeholder")
        }
        title.text = data.title
        contents.text = data.contents
    }
}
