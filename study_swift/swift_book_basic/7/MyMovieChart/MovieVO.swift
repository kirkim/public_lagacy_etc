//
//  MovieVO.swift
//  MyMovieChart
//
//  Created by 김기림 on 2021/11/26.
//

import Foundation
import UIKit

class MovieVO {
    var thumbnail: String? // 영화 섬네일 이미지 주소
    var title: String? // 영화 제목
    var description: String? // 영화 설명
    var detail: String? // 상세정보
    var opendate: String? // 개봉일
    var rating: Double? // 평정
    
    // 영화 썸네일 이미지를 담을 UIImage 객체를 추가한다
    var thumbnailImage: UIImage?
}
