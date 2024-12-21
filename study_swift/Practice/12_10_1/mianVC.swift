//
//  mianVC.swift
//  Practice12_10_1
//
//  Created by 김기림 on 2021/12/11.
//
import UIKit

class mainVC: UIViewController {

    var settingModel = [[SettingModel]]()
    
    @IBOutlet weak var settingTableView: UITableView!
    func makeData() {
        settingModel.append(
            [SettingModel(leftImageName: "person.circle", menuTitle: "Sign in to your iPhone", subTitle: "Set up iClod, the App Store, and more.", rightImageName: "chevron.right")]
        )
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        settingTableView.delegate = self
        settingTableView.dataSource = self
        settingTableView.register(UINib(nibName: "ProfileCell", bundle: nil), forCellReuseIdentifier: "ProfileCell")
        self.title = "Settings"
        self.makeData()
    }


}

extension mainVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.settingModel[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileCell", for: indexPath) as! ProfileCell
            cell.mainTitle.text = self.settingModel[indexPath.section][indexPath.row].menuTitle
            cell.leftImage.image = UIImage(systemName: self.settingModel[indexPath.section][indexPath.row].leftImageName)
            cell.subTitle.text = self.settingModel[indexPath.section][indexPath.row].subTitle
            return cell
        }
        return UITableViewCell()
    }
}
