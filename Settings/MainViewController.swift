//
//  ViewController.swift
//  Settings
//
//  Created by Roman on 08.01.2022.
//

import UIKit


class MainViewController: UIViewController {

    var set = [Setting]()
    let notificationCenter = UNUserNotificationCenter.current()

    // MARK: - Views
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(SettingsTableViewCell.self, forCellReuseIdentifier: "SettingsTableViewCell")
        tableView.frame = CGRect.init(origin: .zero, size: view.frame.size)
        tableView.rowHeight = 50
        tableView.dataSource = self
        tableView.delegate = self

        return tableView
    }()

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Settings"

        askAccess()
        setupHierarchy()
    }

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        updateLayout(with: size)
    }

    // MARK: - Settings
    private func setupHierarchy() {
        view.addSubview(tableView)
    }

    private func updateLayout(with size: CGSize) {
       tableView.frame = CGRect.init(origin: .zero, size: size)
    }

}

//  Добавление таблицы
extension MainViewController: UITableViewDataSource, UITableViewDelegate {

    // При выборе строки
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        sendNotification(title: "You push '\(settingsList[getSelectedRowNumber()].name)' button")
        print("You push '\(settingsList[getSelectedRowNumber()].name)' button")

        moveToSetttingView(settingsList[getSelectedRowNumber()].name)

        // Внутриние функции
        func getSelectedRowNumber() -> Int {
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

        func cot(_ sectionNum: Int) -> Int {
            var c = Int()
            var out = Int()
            for i in Block.allValues {
                out += Setting.getSettingsSectionLenght(block: i)
                if c == sectionNum - 1 {
                    break
                }
                c += 1
            }
            return out
        }

    }

    // При момент до выбора строки (собираемся выбрать)
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        if indexPath.row == 0 && indexPath.section == 0 {
            return nil
        }
        return indexPath
    }

    // Количество секций
    func numberOfSections(in tableView: UITableView) -> Int {
        return Setting.getSectionsCount()
    }

    // Количество ячеек в каждой секции
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return Setting.getSettingsSectionLenght(block: .fast)
        case 1:
            return Setting.getSettingsSectionLenght(block: .notifications)
        case 2:
            return Setting.getSettingsSectionLenght(block: .main)
        default:
            return 0
        }
    }

    // Определение содержимого ячейки
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "SettingsTableViewCell", for: indexPath) as! SettingsTableViewCell

        switch indexPath.section {
        case 0:
            set = Setting.getSettingsList(block: .fast)
        case 1:
            set = Setting.getSettingsList(block: .notifications)
        case 2:
            set = Setting.getSettingsList(block: .main)
        default:
            set = Setting.getSettingsList(block: .fast)
        }

        let setChose = set[indexPath.row]

        // Присвоение значений в ячейки
        var content = cell.defaultContentConfiguration()
        content.text = setChose.name
        content.image = setChose.imageMain
        content.imageProperties.maximumSize = CGSize(width: 30, height: 30)
        cell.contentConfiguration = content

        // Создание переключателя
        lazy var switchObj: UISwitch = {
            let switchObj = UISwitch(frame: CGRect(x: 1, y: 1, width: 20, height: 20))
            switchObj.isOn = false
            switchObj.addTarget(self, action: #selector(tog(_:)), for: .valueChanged)

            return switchObj
        }()

        // Определение стиля
        switch setChose.style {
        case .check:
            cell.accessoryView = switchObj
        case .move:
            cell.accessoryType = .disclosureIndicator
        }

        return cell
    }

    // Переход на нужное View
    func moveToSetttingView(_ pageName: String) {
        switch pageName{
        case "Wi-Fi":
            navigationController?.pushViewController(WiFiViewController(), animated: true)
        default:
            print("No page")
        }
    }

    // Срабатывание при переключении переключателя
    @objc private func tog(_ toggle: UISwitch) {
        print("Airplane mode is \(toggle.isOn ? "on" : "off")")
    }
}

// Класс ячейки
class SettingsTableViewCell: UITableViewCell {
    // При повторном использовании
    override func prepareForReuse() {
        super.prepareForReuse()
        self.accessoryType = .none
    }
}
