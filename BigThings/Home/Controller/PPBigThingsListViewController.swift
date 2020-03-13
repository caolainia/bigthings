//
//  PPBigThingsListViewController.swift
//  BigThings
//
//  Created by PP on 2019/11/8.
//  Copyright © 2019 PP. All rights reserved.
//

import UIKit
import Alamofire

class PPBigThingsListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    fileprivate var allBigThingsArray: [PPThingsVo] = [PPThingsVo]()
    //分组数据
    fileprivate var dataSource: [[PPThingsVo]] = [[PPThingsVo]]()
    fileprivate var titleIndex: [String] = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.sectionIndexBackgroundColor = UIColor.clear
        tableView.sectionIndexColor = UIColor(hex: 0x1296DB)
        self.tableView.tableFooterView = UIView();
        self.tableView.register(UINib(nibName: "PPHomeTableViewCell", bundle: nil), forCellReuseIdentifier: "PPHomeTableViewCell")
        loadAllBigThings()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        queryAllBigThings()
    }
    
    func queryAllBigThings()  {
        PPThingsVo.queryAllBigThings {[weak self] (values) in
            guard let weakSelf = self else {
                return
            }
            weakSelf.allBigThingsArray = values.sorted(by: { (objc1, objc2) -> Bool in
                return ((objc1.name ?? "").capitalized).compare((objc2.name ?? "").capitalized) == ComparisonResult.orderedAscending
            })
            
            weakSelf.groupBigThings()
            weakSelf.tableView.reloadData()
            
            if (values.count == 0) {
                PromptView.show(message: "No Big Things")
            }
        }
    }
    
    fileprivate func groupBigThings() {
        titleIndex.removeAll()
        dataSource.removeAll()
        var result = [[PPThingsVo]]()
        var other = [PPThingsVo]()
        var list = [PPThingsVo]()
        var lastChar: Character = Character("\0")
        
        for item in allBigThingsArray {
            if let name = item.name, name.count > 0 {
                let first = name[name.startIndex]
                let regex = try! NSRegularExpression(pattern: "[a-z]")
                if ((regex.firstMatch(in: String(first), options: [], range: NSRange(location: 0, length: 1))) == nil) {
                    other.append(item)
                } else if (first != lastChar) {
                    lastChar = first;
                    titleIndex.append(String(first))
                    if (list.count > 0) {
                        result.append(list)
                    }
                    list = [PPThingsVo]()
                    list.append(item)
                } else {
                    list.append(item)
                }
            } else {
                other.append(item)
            }
        }
        
        if (list.count > 0) {
            result.append(list)
        }
        
        if other.count > 0 {
            titleIndex.append("#")
            result.append(other)
        }
        
        dataSource = result
    }
    

    
    func loadAllBigThings() -> Void {
        let dataResult = SessionManager.default.request(allBigThings, method: HTTPMethod.get, parameters: nil, encoding: JSONEncoding.default, headers: nil)
        
        dataResult.responseData {[weak self] (response: DataResponse<Data>) in
            guard let weakSelf = self else {
                return
            }
            switch response.result {
            case .success(let value):
                PPLog.logger(items: String(data: value, encoding: String.Encoding.utf8) ?? "")
                if let object: [PPThingsVo] = try? JSONDecoder().decode([PPThingsVo].self, from: value) {

                    for j in weakSelf.allBigThingsArray {
                        for i in object {
                            if let jID = j.id, let iID = i.id, iID == jID {
                                i.isRated = j.isRated
                                i.isFavorited = j.isFavorited
                            }
                        }
                    }
                    PPThingsVo.updateThings(things: object, completeHandler: {[weak self] in
                        self?.queryAllBigThings()
                    })
                } else {
                    PromptView.show(message: "Failed to load data")
                }
            case .failure(let error):
                PPLog.logger(items: error.localizedDescription);
                PromptView.show(message: "There is no Internet")
            }
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }
}


extension PPBigThingsListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}

extension PPBigThingsListViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.dataSource.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataSource[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PPHomeTableViewCell", for: indexPath) as! PPHomeTableViewCell
        cell.thingsVo = self.dataSource[indexPath.section][indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.performSegue(withIdentifier: "showThingsDetail", sender: self.dataSource[indexPath.section][indexPath.row])
    }
    
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return titleIndex
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 28
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return titleIndex[section]
    }
    
    /// Segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showThingsDetail" {
            let controller = segue.destination as! PPThingsDetailViewController
            if let value = sender as? PPThingsVo {
                controller.thingsVo = value;
            }
        }
    }
}
