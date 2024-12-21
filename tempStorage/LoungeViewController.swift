//
//  LoungeViewController.swift
//  AniFace
//
//  Created by daesungYOON on 2022/07/27.
//

import PhotosUI
import UIKit
import RxSwift
import RxCocoa

import NVActivityIndicatorView

class LoungeViewController: BaseViewController {
  init() {
    super.init(nibName: nil, bundle: nil)
    bind()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    makeUI()
    setAddTargets()
    setRegisters()
    setDelegates()
    setNavigations()
  }
  
  private let viewModel = LoungeViewModel()
  
  // MARK: Status
  
  var isPhotoPicked: Bool = false
  
  // MARK: View
    
  private lazy var totalPaddingView = UIView()
  private lazy var disposeBag = DisposeBag()
  
  private let imgOriginCell = "imgOriginCell"
  
	private lazy var rightBarButton = UIBarButtonItem(
		barButtonSystemItem: UIBarButtonItem.SystemItem.add,
		target: self,
		action: #selector(rightBarButtonDidTap)
	)
	
  private lazy var resultCollectionView: UICollectionView = {
    var layout = UICollectionViewFlowLayout()
    layout.scrollDirection = .vertical
    layout.minimumLineSpacing = 10
    layout.minimumInteritemSpacing = 10
    var collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    collectionView.backgroundColor = .clear
    return collectionView
  }()
  
  private func makeUI() {
    self.view.backgroundColor = Const.Colors.BackGround.themeBG
    
    self.view.addSubview(totalPaddingView)
    
    self.totalPaddingView.snp.makeConstraints { make in
      make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
      make.leading.trailing.equalToSuperview().inset(10)
      make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
    }
    
    self.totalPaddingView.addSubview(resultCollectionView)
    resultCollectionView.snp.makeConstraints { make in
      make.top.equalToSuperview()
      make.leading.trailing.equalToSuperview()
      make.bottom.equalToSuperview().inset(50)
    }
  }
  
  // MARK: SetDelegates
  
  private func setDelegates() {
    self.resultCollectionView.delegate = self
    self.resultCollectionView.dataSource = self
  }
  
  // MARK: SetAddTargets
  
  private func setAddTargets() {
   
  }
  
  // MARK: SetRegisters
  
  private func setRegisters() {
    self.resultCollectionView.register(
      ImgOriginCell.self,
      forCellWithReuseIdentifier: imgOriginCell
    )
  }
  
  // MARK: SetNavigations
  
  private func setNavigations() {
    self.navigationController?.isNavigationBarHidden = false
    self.navigationItem.rightBarButtonItem = rightBarButton
  }
  
  // MARK: SetActions
  
  private lazy var picker: PHPickerViewController = {
    var config = PHPickerConfiguration()
    config.filter = .images
    config.selectionLimit = 1 // 이미지 선택 제한
    
    let picker = PHPickerViewController(configuration: config)
    picker.delegate = self
    
    return picker
  }()
  
  @objc private func rightBarButtonDidTap() {
//    let phpConfiguration: PHPickerConfiguration = {
//      var config = PHPickerConfiguration()
//      config.filter = .images
//      config.selectionLimit = 1 // 이미지 선택 제한
//      return config
//    }()
//
//    let picker = PHPickerViewController(configuration: phpConfiguration)
//    picker.delegate = self
    
    self.present(picker, animated: true, completion: nil)
  }
}

// MARK: Extensions

extension LoungeViewController: PHPickerViewControllerDelegate {
  
  func bind() {
    viewModel.succeedGetGenderResult
      .bind { resultGender in
        self.showAlert(
          title: "성별추측 결과",
          message: "\(resultGender)이 맞으면 확인 \n 아니라면 성별변경 클릭",
          preferredStyle: .alert,
          firstButtonName: "성별 일치",
          secondButtonName: "성별 변경",
          firstButtonCompletion: {
            self.viewModel.didSelectedCorrectGenderAlertButton.accept(true)
          },
          secondButtonCompletion: {
            self.viewModel.didSelectedCorrectGenderAlertButton.accept(false)
          })
      }
      .disposed(by: disposeBag)
  }
  // 사진 선택시 동작 delegate
  func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
    picker.dismiss(animated: true)
    
    guard let itemProvider = results.first?.itemProvider,
          itemProvider.canLoadObject(ofClass: UIImage.self) else {
      print("선택한 이미지를 로드할수 없음")
      return
    }
    
    itemProvider.loadObject(ofClass: UIImage.self) { image, error in
      guard error == nil,
        let selectedImg = image as? UIImage else {
        print("이곳 error")
        return
      }
      DispatchQueue.main.async {
        let sample = BasicAlertViewController()
        sample.rx.tappedOkButton
          .subscribe(onNext: { _ in
            print("ok button clicked!")
          })
          .disposed(by: self.disposeBag)
        self.present(sample, animated: true)
      }
      
      
//      self.viewModel.didSelectedPickerImage.accept(selectedImg)
      // RE_성별을 묻는 방식으로 변경필요 by.yoonds
//      self.viewModel.requestClassifyData(userImgData: imgToData) { resultGender in
//        self.showAlert(
//          title: "성별추측 결과",
//          message: "\(resultGender)이 맞으면 확인 \n 아니라면 성별변경 클릭",
//          preferredStyle: .alert,
//          firstButtonName: "성별 일치",
//          secondButtonName: "성별 변경",
//          firstButtonCompletion: {
//            self.viewModel.requestPytorchData(
//              userImgData: imgToData,
//              gender: resultGender
//            ) { dataResult, apiResult in
//              switch apiResult {
//              case .success:
//                //                    self.resultCollectionView.reloadData()
//                break
//              case .faceNotFound:
//                self.showAlert(
//                  title: "error: \(apiResult)",
//                  firstButtonName: "확인"
//                )
//              case .serverNotConnect:
//                self.showAlert(
//                  title: "error: \(apiResult)",
//                  firstButtonName: "확인"
//                )
//              }
//            }
//            self.viewModel.requestTensorFlowData(
//              userImgData: imgToData,
//              gender: resultGender
//            ) { dataResult, apiResult in
//              switch apiResult {
//              case .success:
//                self.resultCollectionView.reloadData()
//              case .faceNotFound:
//                self.showAlert(
//                  title: "error: \(apiResult)",
//                  firstButtonName: "확인"
//                )
//              case .serverNotConnect:
//                self.showAlert(
//                  title: "error: \(apiResult)",
//                  firstButtonName: "확인"
//                )
//              }
//            }
//          },
//          secondButtonCompletion: {
//            let changeGender = resultGender == "male" ? "female" : "male"
//            self.viewModel.requestPytorchData(
//              userImgData: imgToData,
//              gender: changeGender
//            ) { dataResult, apiResult in
//              switch apiResult {
//              case .success: break
//                //                    self.testImgView.image = UIImage(base64String: dataResult.resultAnimeGAN)
//              case .faceNotFound:
//                self.showAlert(
//                  title: "얼굴을 찾을수 없습니다: \(apiResult)",
//                  firstButtonName: "확인"
//                )
//              case .serverNotConnect:
//                self.showAlert(
//                  title: "서버 연결에 실패하였습니다. \(apiResult)",
//                  firstButtonName: "확인"
//                )
//              }
//            }
//          }
//        )
//      }
    }
  }
}

extension LoungeViewController: UICollectionViewDelegate {
  // cell 버튼액션 정의
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    
    let nextView = ImgDetailViewController()
    let pyTorchImg = self.viewModel.resultPytorch[indexPath.row]
    let tensorFlowImg = self.viewModel.resultTensorflow[indexPath.row]
    
    nextView.pyTorchImgList.append(pyTorchImg)
    nextView.tensorFlowImgList.append(tensorFlowImg)
    nextView.imgOrigin.image = self.viewModel.userSelectedImg[indexPath.row]
    
    self.navigationController?.pushViewController(nextView, animated: true)
  }
  
  // cell 선택시 highlight
  func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
    
    return true
  }
}

extension LoungeViewController: UICollectionViewDelegateFlowLayout {
  // cell size 조정
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    
    let width: CGFloat = (collectionView.frame.width / 2) - 5
    let height: CGFloat = (collectionView.frame.height / 3) - 10
    
    return CGSize(width: width, height: height)
  }
}

extension LoungeViewController: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    
    return self.viewModel.userSelectedImg.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: imgOriginCell, for: indexPath) as! ImgOriginCell
    
    cell.imgOrigin.image = self.viewModel.userSelectedImg[indexPath.row]
    
    return cell
  }
}
