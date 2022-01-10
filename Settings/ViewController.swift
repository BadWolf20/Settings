//
//  ViewController.swift
//  Settings
//
//  Created by Roman on 08.01.2022.
//

import UIKit

class ViewController: UIViewController {

    var set = [Setting]()
    let tableView = UITableView.init(frame: .zero, style: UITableView.Style.grouped)

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.navigationItem.title = "Table"
        self.navigationController?.navigationBar.prefersLargeTitles = true

        self.view.addSubview(self.tableView)
        self.tableView.register(TableViewCell.self, forCellReuseIdentifier: "TableViewCell")
        self.tableView.dataSource = self

        self.updateLayout(with: self.view.frame.size)
        tableView.rowHeight = 50
    }


    private func updateLayout(with size: CGSize) {
       self.tableView.frame = CGRect.init(origin: .zero, size: size)
    }

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
       super.viewWillTransition(to: size, with: coordinator)
       coordinator.animate(alongsideTransition: { (contex) in
           self.updateLayout(with: size)
       }, completion: nil)
    }
}


extension ViewController: UITableViewDataSource {



    func numberOfSections(in tableView: UITableView) -> Int{
        return 3 //data.count
    }  // Optional

//    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        return "Section #\(section)"
//    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return getSettingsSecttionLenght(block: .fast)
        case 1:
            return getSettingsSecttionLenght(block: .notifications)
        case 2:
            return getSettingsSecttionLenght(block: .main)
         default:
           return 0
        }
    }



    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell

        switch indexPath.section{
        case 0:
            set = getSettingsList(block: .fast)
        case 1:
            set = getSettingsList(block: .notifications)
        case 2:
            set = getSettingsList(block: .main)
        default:
            set = getSettingsList(block: .fast)
        }

        let setChose = set[indexPath.row]

        var content = cell.defaultContentConfiguration()

        content.text = setChose.name
        content.image = setChose.imageMain
        content.imageProperties.maximumSize = CGSize(width: 50, height: 50)

        cell.contentConfiguration = content

        let switchObj = UISwitch(frame: CGRect(x: 1, y: 1, width: 20, height: 20))
        switchObj.isOn = false
        switchObj.addTarget(self, action: #selector(tog(_:)), for: .valueChanged)



        if setChose.style == .check {
            cell.accessoryView = switchObj
        }
        return cell
    }

    @objc private func tog(_: UISwitch){
        print("swoth")
    }
}

class TableViewCell: UITableViewCell {
    override func prepareForReuse() {
        super.prepareForReuse()
        self.accessoryType = .none
    }
}


