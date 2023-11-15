//
//  SearchTableViewCell.swift
//  SeSACRxThreads
//
//  Created by jack on 2023/11/03.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa
import Kingfisher

final class SearchTableViewCell: UITableViewCell {
    
    static let identifier = "SearchTableViewCell"
    
    private let appNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.textColor = .black
        return label
    }()
    
    private let appIconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 8
        return imageView
    }()
    
    let downloadButton: UIButton = {
        let button = UIButton()
        button.setTitle("받기", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.isUserInteractionEnabled = true
        button.backgroundColor = .lightGray
        button.layer.cornerRadius = 16
        return button
    }()
    
    private lazy var developerInfoStack = {
        let view = UIStackView(arrangedSubviews: [rateStackView, developerNameLabel, categoryLabel])
        view.axis = .horizontal
        view.distribution = .equalSpacing
        view.spacing = 20
        return view
    }()

    private let developerNameLabel = {
        let view = UILabel()
        view.text = ""
        view.textAlignment = .center
        view.setContentCompressionResistancePriority(.dragThatCanResizeScene, for: .horizontal)
        return view
    }()
    
    private let categoryLabel = {
        let view = UILabel()
        view.text = ""
        view.textAlignment = .right
        return view
    }()
    
    private lazy var rateStackView = {
        let view = UIStackView(arrangedSubviews: [rateImageView, rateLabel])
        view.axis = .horizontal
        view.spacing = 0
        view.alignment = .fill
        view.distribution = .equalSpacing
        return view
    }()
    
    private let rateLabel = {
        let label = UILabel()
        label.text = "0.0"
        label.textAlignment = .left
        return label
    }()
    
    private let rateImageView = {
        let view = UIImageView()
        view.image = UIImage(systemName: "star.fill")
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    lazy var screenShotStackView = {
        let view = UIStackView(arrangedSubviews: [screenShotImageView, screenShotSecondView, screenShotThirdView])
        view.axis = .horizontal
        view.distribution = .fillEqually
        view.alignment = .fill
        view.spacing = 10
        return view
    }()
    
    private let screenShotImageView = {
        let view = UIImageView(frame: .zero)
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    private let screenShotSecondView = {
        let view = UIImageView(frame: .zero)
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    private let screenShotThirdView = {
        let view = UIImageView(frame: .zero)
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    var disposeBag = DisposeBag()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.selectionStyle = .none
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        contentView.addSubview(appNameLabel)
        contentView.addSubview(appIconImageView)
        contentView.addSubview(downloadButton)
        contentView.addSubview(screenShotStackView)
        contentView.addSubview(developerInfoStack)
        
        appIconImageView.snp.makeConstraints {
            $0.top.leading.equalToSuperview().inset(20)
//            $0.leading.equalTo(20)
            $0.size.equalTo(60)
        }
        
        appNameLabel.snp.makeConstraints {
            $0.centerY.equalTo(appIconImageView)
            $0.leading.equalTo(appIconImageView.snp.trailing).offset(8)
            $0.trailing.equalTo(downloadButton.snp.leading).offset(-8)
        }
        
        downloadButton.snp.makeConstraints {
            $0.centerY.equalTo(appIconImageView)
            $0.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(32)
            $0.width.equalTo(72)
        }
        developerInfoStack.snp.makeConstraints { make in
            make.top.equalTo(appIconImageView.snp.bottom).offset(5)
            make.leading.equalTo(appIconImageView)
            make.trailing.equalTo(downloadButton)
        }
        screenShotStackView.snp.makeConstraints { make in
            make.top.equalTo(developerInfoStack.snp.bottom).offset(8)
            make.leading.equalTo(appIconImageView)
            make.trailing.equalTo(downloadButton)
            make.height.equalTo(screenShotStackView.snp.width).multipliedBy(0.6)
            make.bottom.equalToSuperview().inset(20)
        }
        
        
    }
    
    func setCellData(element: AppInfo){
        appNameLabel.text = element.trackName
        appIconImageView.backgroundColor = .green
        appIconImageView.kf.setImage(with: URL(string: element.artworkUrl512)!)
        screenShotImageView.kf.setImage(with: URL(string: element.screenshotUrls[0]))
        screenShotSecondView.kf.setImage(with: URL(string: element.screenshotUrls[1]))
        screenShotThirdView.kf.setImage(with: URL(string: element.screenshotUrls[2]))
        rateLabel.text = String(format: "%.2f", element.averageUserRating)
        developerNameLabel.text = element.sellerName
        categoryLabel.text = element.genres.first
    }
}
