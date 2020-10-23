//
//  ViewController.swift
//  Moya+RxSwift+ObjectMapper
//
//  Created by Developer on 2020/10/21.
//

import UIKit
import Moya
import RxSwift
import RxCocoa

class ViewController: UIViewController {
    
  fileprivate let testProvider = MoyaProvider<TestAPI>()
    
  fileprivate let disposeBag = DisposeBag()
    
    fileprivate var dataSource = TestModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
       testProvider.rx
            .request(.test)
            .observeOn(MainScheduler.asyncInstance)
            .asObservable()
            .mapObject(type: TestModel.self)
            .subscribe(onNext: { [weak self] result in
                guard let `self` = self else { return }
                self.dataSource = result
                print(self.dataSource)
                print(self.dataSource.channels.count)
            }, onError: { (error) in
                print(error)
            }).disposed(by: disposeBag)
    }
}

