//
//  Location.swift
//  rainyshinycloudy
//
//  Created by Teodora Knezevic on 3/9/19.
//  Copyright © 2019 Teodora Knežević. All rights reserved.
//

import CoreLocation

class Location {            // ovo je singlton. ima static instancu i private init
    
    static var sharedInstance = Location()
    private init() {}
    
    var latitude:Double!
    var longitude:Double!
    
    
}
