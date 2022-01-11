//
//  SettingsList.swift
//  Settings
//
//  Created by Roman on 09.01.2022.
//

import Foundation
import UIKit

struct Setting {
    let name: String
    let style: Style
    let block: Block
    let imageMain: UIImage?

    static func getSectionsCount() -> Int {
        let set = Set(settingsList.map{$0.block})
        return set.count
    }
}

enum Style {
    case check
    case move
}

enum Block {
    case fast
    case notifications
    case main

    static let allValues = [Block.fast, Block.notifications, Block.main]
}

var settingsList = [Setting(name: "Airplane Mode",
                            style: .check,      block: .fast,    imageMain: UIImage(named: "Airplane Mode")),
                    Setting(name: "Wi-Fi",
                            style: .move,       block: .fast,    imageMain: UIImage(named: "Wi-Fi")),
                    Setting(name: "Bluetooth",
                            style: .move,       block: .fast,    imageMain: nil),
                    Setting(name: "Cellular",
                            style: .move,       block: .fast,    imageMain: UIImage(named: "Cellular")),
                    Setting(name: "Personal Hotspot",
                            style: .move,       block: .fast,    imageMain: UIImage(named: "Personal Hotspot")),
                    Setting(name: "Notifications",
                            style: .move,       block: .notifications,    imageMain: UIImage(named: "Notifications")),
                    Setting(name: "Sounds & Haptics",
                            style: .move,       block: .notifications,    imageMain: UIImage(named: "Sounds & Haptics")),
                    Setting(name: "Do Not Disturb",
                            style: .move,       block: .notifications,    imageMain: UIImage(named: "Do Not Disturb")),
                    Setting(name: "Screen Time",
                            style: .move,       block: .notifications,    imageMain: UIImage(named: "Screen Time")),
                    Setting(name: "General",
                            style: .move,       block: .main,    imageMain: UIImage(named: "General")),
                    Setting(name: "Control Center",
                            style: .move,       block: .main,    imageMain: nil),
                    Setting(name: "Display & Brightness",
                            style: .move,       block: .main,    imageMain: nil),
                    Setting(name: "Wallpaper",
                            style: .move,       block: .main,    imageMain: nil)
                    
]

func getSettingsList(block: Block) -> [Setting] {
    var out = [Setting]()
    for i in settingsList{
        if i.block == block {
            out.append(i)
        }
    }
    return out
}

func getSettingsSecttionLenght(block: Block) -> Int {
    var out = Int()
    for i in settingsList{
        if i.block == block {
            out += 1
        }
    }
    return out
}

