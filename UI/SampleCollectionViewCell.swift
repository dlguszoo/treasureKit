// Copyright © 2024 DRINKIG. All rights reserved

import UIKit
import SnapKit
import Then
import SDWebImage

public class SampleCollectionViewCell: UICollectionViewCell, ViewConfigurable {
    public static let identifier = "SampleCollectionViewCell"
    
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
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        addComponents()
        setupConstraints()
        configureShadow()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        contentView.backgroundColor = .clear
        contentView.layer.cornerRadius = 10
        contentView.layer.masksToBounds = true
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor.lightGray.cgColor
    }
    
    func addComponents() {
        [image, title].forEach { contentView.addSubview($0) }
    }
    
    func setupConstraints() {
        image.snp.makeConstraints {
            $0.top.equalToSuperview().offset(10)
            $0.horizontalEdges.equalToSuperview().inset(10)
            $0.height.equalTo(image.snp.width)
        }
        title.snp.makeConstraints {
            $0.top.equalTo(image.snp.bottom).offset(10)
            $0.centerX.equalTo(image)
        }
    }
    
    func configureShadow() {
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.2
        layer.shadowOffset = CGSize(width: 0, height: 2)
        layer.shadowRadius = 4
        layer.masksToBounds = false
    }
    
    typealias DataType = ExModel
    public func configure(with data: ExModel) {
        if let url = URL(string: data.imageURL) {
            image.sd_setImage(with: url, placeholderImage: UIImage(named: "placeholder"))
        } else {
            image.image = UIImage(named: "placeholder")
        }
        title.text = data.title
    }
}
