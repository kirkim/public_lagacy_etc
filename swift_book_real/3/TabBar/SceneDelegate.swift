//
//  SceneDelegate.swift
//  Chapter03-TabBar
//
//  Created by 김기림 on 2021/12/03.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
 
        guard let _ = (scene as? UIWindowScene) else { return }

        // (1) 루트 뷰 컨트롤러를 UITabBarController로 캐스팅한다.
        if let tbC = self.window?.rootViewController as? UITabBarController {
            // (2) 탭 바에서 탭 바 아이템 배열을 가져온다.
            if let tbItems = tbC.tabBar.items {
                // (3) 탭 바 아이템에 커스텀 이미지를 등록한다.
//                tbItems[0].image = UIImage(named: "calendar")
//                tbItems[1].image = UIImage(named: "file-tree")
//                tbItems[2].image = UIImage(named: "photo")
                // 이미지 원본 그대로 등록
                tbItems[0].image = UIImage(named: "designbump")?.withRenderingMode(.alwaysOriginal)
                tbItems[1].image = UIImage(named: "rss")?.withRenderingMode(.alwaysOriginal)
                tbItems[2].image = UIImage(named: "facebook")?.withRenderingMode(.alwaysOriginal)

                for tbItem in tbItems {
                    let image = UIImage(named: "checkmark")?.withRenderingMode(.alwaysOriginal)
                    tbItem.selectedImage = image
                    
                    // 탭 바 아이템별 텍스트 색상 속성을 설정한다.
//                    tbItem.setTitleTextAttributes([.foregroundColor: UIColor.gray], for: .disabled)
//                    tbItem.setTitleTextAttributes([.foregroundColor: UIColor.red], for: .selected)
                    
                    // 전체 아이템의 폰트 크기를 설정한다.
//                    tbItem.setTitleTextAttributes([.font: UIFont.systemFont(ofSize: 15)], for: .normal)
                }
                // 외형 프록시 객체를 이용하여 아이템의 타이틀 색상과 폰트 크기를 설정한다.
                let tbItemProxy = UITabBarItem.appearance()
                tbItemProxy.setTitleTextAttributes([.foregroundColor: UIColor.gray], for: .disabled)
                tbItemProxy.setTitleTextAttributes([.foregroundColor: UIColor.red], for: .selected)
                tbItemProxy.setTitleTextAttributes([.font: UIFont.systemFont(ofSize: 15)], for: .normal)
                // (4) 탭 바 아이템에 타이틀을 설정한다.
                tbItems[0].title = "calendar"
                tbItems[1].title = "file"
                tbItems[2].title = "photo"
            }
            // (5) 탭 바 아이템의 이미지 색상을 변경한다.
//            tbC.tabBar.tintColor = .white // 선택된 탭 바 아이템의 색상
//            tbC.tabBar.unselectedItemTintColor = .gray // 선택되지 않은 나머지 탭 바 아이템의 색상
            
            // (6) 탭 바에 배경 이미지를 설정한다.(적용안되는게 많아서 'brown'컬러로 지정
//            tbC.tabBar.backgroundColor = .brown
//            tbC.tabBar.standardAppearance.backgroundImage = UIImage(named: "menubar-bg-mini")
//            tbC.tabBar.standardAppearance.backgroundColor = .brown
//            tbC.tabBar.scrollEdgeAppearance?.backgroundImage = UIImage(named: "menubar-bg-mini")
//            tbC.tabBar.scrollEdgeAppearance = tbC.tabBar.standardAppearance
            if #available(iOS 13.0, *) {
                let appearance = tbC.tabBar.standardAppearance.copy()
                setTabBarItemBadgeAppearance2(appearance.stackedLayoutAppearance)
                setTabBarItemBadgeAppearance2(appearance.inlineLayoutAppearance)
                setTabBarItemBadgeAppearance2(appearance.compactInlineLayoutAppearance)
                tbC.tabBar.standardAppearance = appearance
                if #available(iOS 15.0, *) {
                    tbC.tabBar.scrollEdgeAppearance = appearance
            }
            
            
//            let temp = UITabBarAppearance()
//            setTabBarItemColors(temp.inlineLayoutAppearance)
//            setTabBarItemColors(temp.stackedLayoutAppearance)
//            setTabBarItemColors(temp.compactInlineLayoutAppearance)
//            temp.backgroundImage = UIImage(named: "menubar-bg-mini")
//            tbC.tabBar.scrollEdgeAppearance = temp
//            tbC.tabBar.standardAppearance = temp
            
//            if #available(iOS 15.0, *) {
//               let appearance = UITabBarAppearance()
//               appearance.configureWithOpaqueBackground()
//                appearance.backgroundColor = .brown
//               
//               tbC.tabBar.standardAppearance = appearance
//                tbC.tabBar.scrollEdgeAppearance = tbC.tabBar.standardAppearance
//            }
        }
            
    }
        @available(iOS 13.0, *)
        func setTabBarItemBadgeAppearance2(_ itemAppearance: UITabBarItemAppearance) {
            itemAppearance.normal.badgeBackgroundColor = UIColor.green
        }
        
    @available(iOS 13.0, *)
       func setTabBarItemColors(_ itemAppearance: UITabBarItemAppearance) {
           itemAppearance.normal.iconColor = .lightGray
           itemAppearance.normal.badgeBackgroundColor = .blue
           itemAppearance.normal.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.lightGray]
           
           itemAppearance.selected.iconColor = .white
           itemAppearance.selected.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
       }
    @available(iOS 13.0, *)
       func setTabBarItemBadgeAppearance(_ itemAppearance: UITabBarItemAppearance) {
          //Adjust the badge position as well as set its color
          itemAppearance.normal.badgeBackgroundColor = .blue
          itemAppearance.normal.badgeTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
          itemAppearance.normal.badgePositionAdjustment = UIOffset(horizontal: 10, vertical: -10)
      }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}
}
