//
//  Section.swift
//  Debit
//
//  Created by Tô Tử Siêu on 8/15/18.
//  Copyright © 2018 Tô Tử Siêu. All rights reserved.
//

import UIKit

struct Section {
    var name: String
    var items = [Debit]()
    var collapsed: Bool
    
    init(name: String, items: [Debit], collapsed: Bool = false) {
        self.name = name
        self.items = items
        self.collapsed = collapsed
    }
}
