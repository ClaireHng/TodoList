//
//  UIColorExtensions.swift
//  iOSRecruitment
//
//  Created by Claire HUANG on 16/06/2020.
//  Copyright © 2020 cheerz. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    var name: String? {
        switch self {
        case UIColor.systemGreen: return "green"
        case UIColor.systemYellow: return "yellow"
        case UIColor.black: return "black"
        case UIColor.darkGray: return "darkGray"
        case UIColor.lightGray: return "lightGray"
        case UIColor.white: return "white"
        case UIColor.gray: return "gray"
        case UIColor.red: return "red"
        case UIColor.green: return "green"
        case UIColor.blue: return "blue"
        case UIColor.cyan: return "cyan"
        case UIColor.yellow: return "yellow"
        case UIColor.magenta: return "magenta"
        case UIColor.orange: return "orange"
        case UIColor.purple: return "purple"
        case UIColor.brown: return "brown"
        default: return nil
        }
    }
}
