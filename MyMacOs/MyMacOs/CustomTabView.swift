//
//  CustomTabView.swift
//  MyMacOs
//
//  Created by 王本东 on 2023/3/20.
//

import Foundation
import AppKit

class CustomTabViewItem : NSTabViewItem
{
    override func sizeOfLabel(_ computeMin : Bool) -> NSSize
    {
        var size : NSSize = super.sizeOfLabel(computeMin)
        size.height = 60
        return size
    }
}

