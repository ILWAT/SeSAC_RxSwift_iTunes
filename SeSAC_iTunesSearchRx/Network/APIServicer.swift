//
//  APIManager.swift
//  SeSAC_iTunesSearchRx
//
//  Created by 문정호 on 11/6/23.
//

import Foundation
import Alamofire
import RxSwift

final class APIServicer{
    //MARK: - Properties
    static let shared = APIServicer()
    
    private init(){}
    
    
    func callRequest<T: Decodable>(type: T.Type, api: Router, completionHandler: @escaping (T) -> Void){
        AF.request(api).validate().responseDecodable(of: T.self) { response in
            switch response.result {
            case .success(let success):
                completionHandler(success)
            case .failure(let failure):
                print(failure)
            }
        }
    }
    
    func fetchData<T: Decodable>(type: T.Type, api: Router) -> Observable<T> {
        return Observable<T>.create { value in
            AF.request(api).validate().responseDecodable(of: T.self) { response in
                switch response.result {
                case .success(let success):
                    print("success", success)
                    value.onNext(success)
                case .failure(let failure):
                    print(failure)
                    value.onError(failure)
                }
            }
            
            return Disposables.create()
        }
    }
    
//    func fetchiTunes(api: Router) -> Observable<SearchAppModel> {
//        return Observable<SearchAppModel>.create { value in
//            AF.request(api).validate().responseDecodable(of: SearchAppModel.self) { response in
//                switch response.result {
//                case .success(let success):
//                    print("success", success)
//                    value.onNext(success)
//                case .failure(let failure):
//                    print(failure)
//                    value.onError(failure)
//                }
//            }
//            
//            return Disposables.create()
//        }
//    }
}
