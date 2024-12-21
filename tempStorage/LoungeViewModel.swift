//
//  ContentViewModel.swift
//  NewProfilePicDemo
//
//  Created by daesungYOON on 2022/07/26.
//

import Foundation
import RxSwift
import RxCocoa
import Moya

enum APIResultError: Error {
  case success
  case faceNotFound
  case serverNotConnect
}

class LoungeViewModel {
  
  private lazy var disposeBag = DisposeBag()
  
  // View -> ViewModel
  let didSelectedPickerImage = PublishRelay<UIImage>()
  let didSelectedCorrectGenderAlertButton = PublishRelay<Bool>()
  
  // ViewModel -> View
  let succeedGetGenderResult = PublishRelay<String>()
//  let failToRequestPytorchData = PublishRelay
  
  init() {
    didSelectedPickerImage
      .map { $0.rotateImage() }
      .compactMap { $0.jpegData(compressionQuality: 1.0) }
      .bind { [weak self] data in
        self?.requestClassifyData(userImgData: data) { genderResult in
          print("여기")
          self?.succeedGetGenderResult.accept(genderResult)
        }
      }
      .disposed(by: disposeBag)
    
    didSelectedCorrectGenderAlertButton
      .map { isCorrectGender in
        
      }
  }
  
  
  ///////
  
  let pytorchProvider = MoyaProvider<PytorchRepository>()
  let tensorFlowProvider = MoyaProvider<TensorFlowRepository>()
  
  var userSelectedImg = [UIImage]()
  var resultPytorch = [PyTorchResponse]()
  var resultTensorflow = [TensorFlowResponse]()
  
  // RE_CellVM으로 옴겨야함 by.yoonds
  // 성별 데이터 Classificatoin 통신
  func requestClassifyData(
    userImgData: Data,
    completion: @escaping (String) -> Void
  ) {
    pytorchProvider.request(
      .classification(
        targetImageData: userImgData
      )) { result in
        switch result {
        case .success(let response):
          print("here")
          let result = try? response.map(ClassifyResponse.self)
          
          guard let maleData = result?.male,
                let femaleData = result?.female else { return }
          let genderResult = self.genderCheck(male: maleData, female: femaleData)
          completion(genderResult)
        case .failure(let error):
          print("halo")
          print(error.localizedDescription)
        }
      }
  }
  
  // RE_성별을 묻는 방식으로 변경필요 by.yoonds
  // 유저선택 이미지 성별 체크
  func genderCheck(male: Double, female: Double) -> String {
    if male > female {
      return "male"
    } else {
      return "female"
    }
  }
  
  // Pytorch server통신
  func requestPytorchData(
    userImgData: Data,
    gender: String,
    completion: @escaping (PyTorchResponse, APIResultError) -> Void
  ) {
    // pytorch 서버통신
    pytorchProvider.request(
      .inference(
        targetImageData: userImgData,
        gender: gender
      )
    ) { result in
      switch result {
      case .success(let response):
        self.pytorchDataAnalze(userImgData: userImgData, response: response) { dataResult, apiResult in
          guard let dataResult = dataResult else { return }
          completion(dataResult as! PyTorchResponse, apiResult)
        }
      case .failure(let error):
        print(error.localizedDescription)
      }
    }
  }
  
  // Pytorch 통신후 응답 데이터 분석
  func pytorchDataAnalze(
    userImgData: Data,
    response: Response,
    completion: @escaping (Any?, APIResultError) -> Void
  ) {
    if response.statusCode == 200 {
      print("response.data: \(response.data)")
      do {
        guard let decodedData = try? JSONDecoder().decode(
          PyTorchResponse.self,
          from: response.data
        ) else { return print("인입 return") }
        completion(decodedData, .success)
        
        guard let dataToImg = UIImage(data: userImgData) else { return }
        
        self.userSelectedImg.append(dataToImg)
        self.resultPytorch.append(decodedData)
      } catch {
#if DEBUG
        print("Decoding Error: ", error)
#endif
      }
    } else {
      completion(nil, .faceNotFound)
#if DEBUG
      print("Status Error: ", response.statusCode)
#endif
    }
  }
  
  // TensorFlow server통신
  func requestTensorFlowData(
    userImgData: Data,
    gender: String,
    completion: @escaping (TensorFlowResponse, APIResultError) -> Void
  ) {
    // tensorflow 서버통신
    tensorFlowProvider.request(
      .inference(
        targetImageData: userImgData,
        gender: gender
      )
    ) { result in
      switch result {
      case .success(let response):
        self.tensorFlowDataAnalze(userImgData: userImgData, response: response) { dataResult, apiResult in
          guard let dataResult = dataResult else { return }
          completion(dataResult as! TensorFlowResponse, apiResult)
        }
      case .failure(let error):
        print(error.localizedDescription)
      }
    }
  }
  
  // TensorFlow 통신후 응답 데이터 분석
  func tensorFlowDataAnalze(
    userImgData: Data,
    response: Response,
    completion: @escaping (Any?, APIResultError) -> Void
  ) {
    if response.statusCode == 200 {
      print("response.data: \(response.data)")
      do {
        guard let decodedData = try? JSONDecoder().decode(
          TensorFlowResponse.self,
          from: response.data
        ) else { return print("인입 return") }
        completion(decodedData, .success)
        
        guard let dataToImg = UIImage(data: userImgData) else { return }
        
        self.resultTensorflow.append(decodedData)
      } catch {
#if DEBUG
        print("Decoding Error: ", error)
#endif
      }
    } else {
      completion(nil, .faceNotFound)
#if DEBUG
      print("Status Error: ", response.statusCode)
#endif
    }
  }
  
}
