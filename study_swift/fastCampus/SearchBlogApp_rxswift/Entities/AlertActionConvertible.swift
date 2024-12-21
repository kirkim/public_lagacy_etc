//
//  AlertActionConvertible.swift
//  Practice_RxswiftBySPM
//
//  Created by 김기림 on 2022/03/15.
//

import UIKit

protocol AlertActionConvertible {
    var title: String { get }
    var style: UIAlertAction.Style { get }
}
