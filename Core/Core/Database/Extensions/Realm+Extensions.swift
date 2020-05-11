//
//  Realm+Extensions.swift
//  Core
//
//  Created by Alex2 on 11.05.2020.
//  Copyright © 2020 Alex2. All rights reserved.
//

import Foundation
import Realm
import RealmSwift
//import RxSwift

extension Object {
    static func build<O: Object>(_ builder: (O) -> () ) -> O {
        let object = O()
        builder(object)
        return object
    }
}
