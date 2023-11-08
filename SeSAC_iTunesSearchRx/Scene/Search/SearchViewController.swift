//
//  SearchViewController.swift
//  SeSACRxThreads
//
//  Created by jack on 2023/11/03.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa
import Kingfisher

class SearchViewController: UIViewController {
     
    private let tableView: UITableView = {
       let view = UITableView()
        view.register(SearchTableViewCell.self, forCellReuseIdentifier: SearchTableViewCell.identifier)
        view.backgroundColor = .white
        view.rowHeight = 80
        view.separatorStyle = .none
       return view
     }()
    
    let searchBar = UISearchBar()
    
    var cellData: [AppInfo] = []
     
    lazy var items = BehaviorSubject(value: cellData)
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        setSearchController()
        configure()
        bind()
        
    }
     
    func bind() {
        items
            .bind(to: tableView.rx.items(cellIdentifier: SearchTableViewCell.identifier, cellType: SearchTableViewCell.self)) { (row, element, cell) in
                cell.appNameLabel.text = element.trackName
                cell.appIconImageView.backgroundColor = .green
                cell.appIconImageView.kf.setImage(with: URL(string: element.artworkUrl512)!)
                
                cell.downloadButton.rx.tap.bind(with: self) { owner, _ in
                    let nextVC = AppDetailViewController()
                    owner.navigationController?.pushViewController(nextVC, animated: true)
                }
                .disposed(by: cell.disposeBag)
            }
            .disposed(by: disposeBag)
        
        searchBar
            .rx
            .searchButtonClicked
            .withLatestFrom(searchBar.rx.text.orEmpty, resultSelector: { _, value in
                return value
            })
            .flatMap({ query in
                return APIServicer.shared.fetchData(
                    type: SearchAppModel.self,
                    api: .iTunesSearch(query: query)
                )
            })
            .share()
            .subscribe(with: self) { owner, element in
                let data = element.results
                
                owner.items.onNext(data)
            }
            .disposed(by: disposeBag)
        
        searchBar
            .rx
            .cancelButtonClicked
            .subscribe(with: self) { owner, _ in
                owner.searchBar.rx.text.onNext(nil)
            }
            .disposed(by: disposeBag)
        

    }
    
    private func setSearchController() {
        view.addSubview(searchBar)
        self.navigationItem.titleView = searchBar
        searchBar.showsCancelButton = true
    }

    
    private func configure() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }

    }
}
