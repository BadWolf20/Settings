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
}

enum Style {
    case check
    case move
}

enum Block {
    case fast
    case notifications
    case main
}

var settingsList = [Setting(name: "Airplane Mode",
                            style: .check,      block: .fast,    imageMain: UIImage(named: "Airplane")),
                    Setting(name: "Wi-Fi",
                            style: .move,       block: .fast,    imageMain: UIImage(named: "Wifi")),
                    Setting(name: "Bluetooth",
                            style: .move,       block: .fast,    imageMain: nil),
                    Setting(name: "Cellular",
                            style: .move,       block: .fast,    imageMain: UIImage(named: "Cellular")),
                    Setting(name: "Personal Hotspot",
                            style: .move,       block: .fast,    imageMain: UIImage(named: "Hotspot")),
                    Setting(name: "Notifications",
                            style: .move,       block: .notifications,    imageMain: nil),
                    Setting(name: "Sounds & Haptics",
                            style: .move,       block: .notifications,    imageMain: nil),
                    Setting(name: "Do Not Disturb",
                            style: .move,       block: .notifications,    imageMain: nil),
                    Setting(name: "Screen Time",
                            style: .move,       block: .notifications,    imageMain: nil),
                    Setting(name: "General",
                            style: .move,       block: .main,    imageMain: nil),
                    Setting(name: "Control Center",
                            style: .move,       block: .main,    imageMain: nil),
                    Setting(name: "Display & Brightness",
                            style: .move,       block: .main,    imageMain: nil),
                    Setting(name: "Wallpaper",
                            style: .move,       block: .main,    imageMain: nil),
                    
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

