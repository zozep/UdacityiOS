//
//  GCDBlackBox.swift
//  FlickFinder
//
//  Created by Joseph Park on 4/8/17.
//  Copyright © 2017 Joseph Park. All rights reserved.
//

import Foundation

func performUIUpdatesOnMain(_ updates: @escaping () -> Void) {
    DispatchQueue.main.async {
        updates()
    }
}
