//
//  MainVC.swift
//  PracticeRxDataSourcesMultipleSection
//
//  Created by 김기림 on 2022/04/22.
//

import UIKit
import RxDataSources
import RxCocoa
import RxSwift

class MainVC: UIViewController {
    let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout())
    let viewModel = MainViewModel4()
    let disposeBag = DisposeBag()
    let sectionManager = MagnetListSectionManager()
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        attribute()
        layout()
        bind()
        test()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func bind() {
        Observable.just(viewModel.data)
            .bind(to: self.collectionView.rx.items(dataSource: viewModel.dataSource()))
            .disposed(by: disposeBag)

    }
    
    private func attribute() {
        self.collectionView.register(Cell1.self, forCellWithReuseIdentifier: Cell1.identifier)
        self.collectionView.register(Cell2.self, forCellWithReuseIdentifier: Cell2.identifier)
        self.collectionView.register(Cell3.self, forCellWithReuseIdentifier: Cell3.identifier)
        
        self.collectionView.register(MagnetMenuHeaderCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: MagnetMenuHeaderCell.identifier)
        self.collectionView.register(BlankHeaderCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: BlankHeaderCell.identifier)
        self.collectionView.collectionViewLayout = sectionManager.createLayout()
    }
    
    private func layout() {
        self.view.addSubview(collectionView)
        
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    func test() {
        //
        struct Student {
            var score: BehaviorSubject<Int>
        }
        
        
        let disposeBag = DisposeBag()
        
        // 1
        let ryan = Student(score: BehaviorSubject(value: 80))
        let charlotte = Student(score: BehaviorSubject(value: 90))
        
        // 2
        let student = PublishSubject<Student>()
        
        // 3
        student
            .flatMap{
                $0.score
            }
        // 4
            .subscribe(onNext: {
                print($0)
            })
            .disposed(by: disposeBag)
        
        // 5
        student.onNext(ryan)    // Print: 80
        
        // 6
        ryan.score.onNext(85)   // Print: 80 85
        
        // 7
        student.onNext(charlotte)   // Print: 80 85 90
        
        // 8
        ryan.score.onNext(95)   // Print: 80 85 90 95
        
        // 9
        charlotte.score.onNext(100) // Print: 80 85 90 95 100
    }
    
}
