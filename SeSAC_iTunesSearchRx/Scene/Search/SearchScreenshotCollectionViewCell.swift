//
//  SearchScreenshotCollectionViewCell.swift
//  SeSAC_iTunesSearchRx
//
//  Created by 문정호 on 11/8/23.
//

import UIKit
import SnapKit

final class SearchScreenshotCollectionViewCell: UICollectionViewCell{
    //MARK: - Properties
    let imageView = UIImageView()
    
    //MARK: - init
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureHierarchy()
        setConstraints()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func configureHierarchy() {
        contentView.addSubview(imageView)
    }
    
    private func setConstraints(){
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
