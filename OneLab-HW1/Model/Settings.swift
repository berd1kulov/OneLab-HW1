//
//  Settings.swift
//  OneLab-HW1
//
//  Created by Bakdaulet Berdikul on 13.04.2022.
//

import Foundation
import UIKit

struct Settings {
    let settingName : String
    let identity: SettingCase
    //let settingsView : UIView
}

enum SettingCase {
    case switchButton
    case exitButton
    case changePassword
    case rightItem
}
