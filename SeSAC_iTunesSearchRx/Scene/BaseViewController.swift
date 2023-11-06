//
//  BaseViewController.swift
//  SeSAC_iTunesSearchRx
//
//  Created by 문정호 on 11/6/23.
//

import UIKit


class BaseViewController: UIViewController{
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .systemBackground
        configure()
        setConstraints()
    }
    
    func configure() { }
    func setConstraints() { }
}
