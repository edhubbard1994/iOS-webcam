//
//  GetMediaData.swift
//  webcam_iOS
//
//  Created by Edward Hubbard on 5/25/20.
//  Copyright © 2020 Edward Hubbard. All rights reserved.
//

import UIKit

class GetMediaData: NSObject {
    
    private func init() {}
    
    static public func shared() {
        if (!GetMediaData.instance){ GetMediaData.instance = GetMediaData() }
    }
    
    static private var instance : GetMediaData?
    

}
