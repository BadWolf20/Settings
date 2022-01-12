//
//  ViewController.swift
//  Settings
//
//  Created by Roman on 08.01.2022.
//

import UIKit

class ViewController: UIViewController {

    var set = [Setting]()
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(TableViewCell.self, forCellReuseIdentifier: "TableViewCell")
        tableView.frame = CGRect.init(origin: .zero, size: view.frame.size)
        tableView.rowHeight = 50
        tableView.dataSource = self
        tableView.delegate = self

        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        //self.view.backgroundColor = UIColor.white
        self.navigationItem.title = "Settings"
        //self.navigationController?.navigationBar.prefersLargeTitles = true


        //self.tableView.register(TableViewCell.self, forCellReuseIdentifier: "TableViewCell")
        //self.tableView.dataSource = self


        setupHierarchy()
        setupLayout()
        setupView()
    }


    // MARK: - Settings
    private func setupHierarchy() {
        view.addSubview(tableView)
    }

    private func setupLayout() {

    }

    private func setupView() {

    }

    private func updateLayout(with size: CGSize) {
       tableView.frame = CGRect.init(origin: .zero, size: size)
    }

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        updateLayout(with: size)
    }
}


extension ViewController: UITableViewDataSource, UITableViewDelegate{

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        tableView.deselectRow(at: indexPath, animated: true)

        print("You push '\(settingsList[getSelectedRowNumber()].name)' button")

        moveToSetttingView(settingsList[getSelectedRowNumber()].name)

        func getSelectedRowNumber() -> Int{
            var selectedRowNumber = Int()
            switch indexPath.section {
            case 0:
                selectedRowNumber = indexPath.row
            case 1...:
                selectedRowNumber = cot(indexPath.section) + indexPath.row
            default:
                selectedRowNumber = 666
            }
            return selectedRowNumber
        }

        func cot(_ sectionNum: Int) -> Int{
            var c = Int()
            var out = Int()
            for i in Block.allValues{
                out += getSettingsSecttionLenght(block: i)
                if c == sectionNum - 1 {
                    break
                }
                c += 1
            }
            return out
        }

    }

    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        if indexPath.row == 0 && indexPath.section == 0{
            return nil
        }
        return indexPath
    }


    func numberOfSections(in tableView: UITableView) -> Int{
        return Setting.getSectionsCount()
    }

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
        content.imageProperties.maximumSize = CGSize(width: 30, height: 30)

        cell.contentConfiguration = content

        let switchObj = UISwitch(frame: CGRect(x: 1, y: 1, width: 20, height: 20))
        switchObj.isOn = false
        switchObj.addTarget(self, action: #selector(tog(_:)), for: .valueChanged)

        if setChose.style == .check {
            cell.accessoryView = switchObj
        }
        if setChose.style == .move {
            cell.accessoryType = .disclosureIndicator
        }

        return cell
    }

    func moveToSetttingView(_ pageName: String) {
        switch pageName{
        case "Wi-Fi":
            navigationController?.pushViewController(WiFiViewController(), animated: true)
        default:
            print("No page")
        }
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

