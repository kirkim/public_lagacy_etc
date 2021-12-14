//
//  DragAbleView.swift
//  PanGesture_App
//
//  Created by 김기림 on 2021/12/12.
//

import UIKit

class DragAbleView: UIView {
    
    var dragType = DragType.none
    
    init() {
        super.init(frame: CGRect.zero)
        
        let pan = UIPanGestureRecognizer(target: self, action: #selector(dragging))
        self.addGestureRecognizer(pan)
    }
    
    // 스토리보드 자체에서 진행하고싶을때는 다음과 같이 초기화해야됨
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        let pan = UIPanGestureRecognizer(target: self, action: #selector(dragging))
        self.addGestureRecognizer(pan)
        
        //이런 것이 싫을 때 fatalError()을 걸어둔다.
//        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func dragging(pan: UIPanGestureRecognizer) {
        switch pan.state {
        case .began:
            print("began")
        case .changed:
            /* 핵심 로직*/
            let delta = pan.translation(in: self.superview)
            var myPosition = self.center
            
            if dragType == .x {
                myPosition.x += delta.x
            } else if dragType == .y {
                myPosition.y += delta.y
            } else {
                myPosition.x += delta.x
                myPosition.y += delta.y
            }
            
            self.center = myPosition
            pan.setTranslation(CGPoint.zero, in: self.superview)
            /* ------ */
        case .ended , .cancelled:
            print("ended cancelled")
            if self.frame.minX < 0 {
                self.frame.origin.x = 0
            }
            if let hasSuperView = self.superview {
                if self.frame.maxX > hasSuperView.frame.maxX {
                    self.frame.origin.x = hasSuperView.frame.maxX - self.frame.width
                }
                if self.frame.maxY > hasSuperView.frame.maxY {
                    self.frame.origin.y = hasSuperView.frame.maxY - self.frame.height
                }
            }
            if self.frame.minY < 0 {
                self.frame.origin.y = 0
            }
            
        default:
            break
        }
    }
}
