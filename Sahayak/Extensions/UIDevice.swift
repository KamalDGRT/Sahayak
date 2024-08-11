//
//  UIDevice.swift
//  Sahayak
//
//  Created by Kamal Sharma on 11/08/24.
//

import UIKit

public extension UIDevice {
    static var is_iPhone: Bool {
        return UIDevice.current.userInterfaceIdiom == .phone
    }
    
    static var logicalDeviceHeight: CGFloat {
        return UIScreen.main.bounds.size.height
    }
    
    static var logicalDeviceWidth: CGFloat {
        return UIScreen.main.bounds.size.width
    }
    
    static var isSmallerScreen: Bool {
        return logicalDeviceHeight >= 480 || logicalDeviceHeight <= 568
    }
    
    static var isMediumScreen: Bool {
        return logicalDeviceHeight > 568 && logicalDeviceHeight <= 667
    }
    
    static var isLargeScreen: Bool {
        return logicalDeviceHeight > 667
    }
    
    static var deviceName: String {
        switch UIDevice.current.name {
        case "iPhone Xʀ": return "iPhone XR"
        default: return UIDevice.current.name
        }
    }
    
    static var fontSizeMultiplier: CGFloat {
        isLargeScreen ? 1.0 : isMediumScreen ? 0.9 : 0.8
        /*
         In layman terms, the above expression means this:
         if (isLargeScreen) {
         return 1.0
         } else if (isMediumScreen) {
         return 0.9
         } else  {
         return 0.8
         }
         */
    }
}
