//
//  ButtonStyleMaster.swift
//  Practice_coredata
//
//  Created by 김기림 on 2022/01/30.
//

import UIKit

class myButtonUIStyle: UIButton {
    required init(coder: NSCoder) {
        super.init(coder: coder)!
        self.layer.cornerRadius = 10
    }
}

class priorityButton: myButtonUIStyle {
    required init(coder: NSCoder) {
        super.init(coder: coder)
    }
}

class selectButton: myButtonUIStyle {
    required init(coder: NSCoder) {
        super.init(coder: coder)
    }
}
