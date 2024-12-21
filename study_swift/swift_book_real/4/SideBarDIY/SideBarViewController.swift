//
//  SideBarViewController.swift
//  Chapter04-SideBarDIY
//
//  Created by 김기림 on 2021/12/07.
//

import UIKit
class SideBarViewController: UITableViewController {
    // 메뉴 제목 배열
    let titles = [
        "메뉴 01",
        "메뉴 02",
        "메뉴 03",
        "메뉴 04",
        "메뉴 05"
    ]
    
    // 메뉴 아이콘 배열
    let icons = [
        UIImage(named: "icon01.png"),
        UIImage(named: "icon02.png"),
        UIImage(named: "icon03.png"),
        UIImage(named: "icon04.png"),
        UIImage(named: "icon05.png")
    ]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // (1) 계정 정보를 표시할 레이블 객체를 정의한다.
        let accountLabel = UILabel()
        accountLabel.frame = CGRect(x: 10, y: 30, width: self.view.frame.width, height: 30)
        
        accountLabel.text = "sqlpro@naver.com"
        accountLabel.textColor = .white
        accountLabel.font = UIFont.boldSystemFont(ofSize: 15)
        
        // (2) 테이블 뷰 상단에 표시될 뷰를 정의한다.
        let v = UIView()
        v.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 70)
        v.backgroundColor = .brown
        v.addSubview(accountLabel)
        
        // (3) 생성한 뷰 v를 테이블 헤더 뷰 영역에 등록한다.
        self.tableView.tableHeaderView = v

    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.titles.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // (1) 재사용 큐로부터 테이블 셀을 꺼내 온다.
        let id = "menucell" // 재사용 큐에 등록할 식별자
        let cell = tableView.dequeueReusableCell(withIdentifier: id) ?? UITableViewCell(style: .default, reuseIdentifier: id)
        
        // (2) 재사용 큐에 menucell키로 등록된 테이블 뷰 셀이 없다면 새로 추가한다.
        // 하지만 위에처럼 ?? 로 합치는것이좋다. 옵셔널 체인이 해제되어 cell? 구문을 cell로 작성가능해짐, 당연히 cell이 있으므로 cell! 대신 cell로 작성가능
//        if cell == nil {
//            cell = UITableViewCell(style: .default, reuseIdentifier: id)
//        }
        
        // (3) 타이틀과 이미지를 대입한다.
//        cell?.textLabel?.text = self.titles[indexPath.row]
//        cell?.imageView?.image = self.icons[indexPath.row]
        // (4) 폰트 설정
//        cell?.textLabel?.font = UIFont.systemFont(ofSize: 14)

        // (---) UIListContentConfiguration 이용(책내용x)
        var content = cell.defaultContentConfiguration()
        content.image = self.icons[indexPath.row]
        content.text = self.titles[indexPath.row]
        content.textProperties.font = UIFont.systemFont(ofSize: 14)
        cell.contentConfiguration = content
        
        return cell
    }
}
