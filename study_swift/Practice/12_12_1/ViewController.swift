//
//  ViewController.swift
//  Practice12_12_1
//
//  Created by 김기림 on 2021/12/12.
//

import UIKit

class ViewController: UIViewController {

    var settingModel = [[SettingModel]]()
    
    func makeData() {
        settingModel.append([
            SettingModel(mainTitle: "Sign in to your iPhonee", subTitle: "Set up iCloudm the App Store, and more.rawValue", leftImage: "person.circle", rightImage: "chevron.right")
        ])
        settingModel.append([
            SettingModel(mainTitle: "General", subTitle: nil, leftImage: "gear", rightImage: "chevron.right"),
            SettingModel(mainTitle: "Accessibility", subTitle: nil, leftImage: "person.fill", rightImage: "chevron.right"),
            SettingModel(mainTitle: "Privacy", subTitle: nil, leftImage: "hand.raised.fill", rightImage: "chevron.right")
                            
        ])
    }
    
    @IBOutlet weak var settingTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.settingTableView.delegate = self
        self.settingTableView.dataSource = self
        self.settingTableView.register(UINib(nibName: "ProfileCell", bundle: nil), forCellReuseIdentifier: "ProfileCell")
        self.makeData()
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.settingModel[section].count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.settingModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileCell", for: indexPath) as! ProfileCell
            cell.mainTitle.text = settingModel[indexPath.section][indexPath.row].mainTitle
            cell.subTitle.text = settingModel[indexPath.section][indexPath.row].subTitle
            cell.leftImage.image = UIImage(systemName: settingModel[indexPath.section][indexPath.row].leftImage)
            return cell
        }
        let cell = UITableViewCell()
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if indexPath.section == 0 && indexPath.row == 0 {
            let myidVC = MyIDViewController(nibName: "MyIDViewController", bundle: nil)
            self.present(myidVC, animated: true, completion: nil)
        }
    }
    
}
