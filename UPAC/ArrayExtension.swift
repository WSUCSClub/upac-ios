//
//  ArrayExtension.swift
//  UPAC
//
//  Created by Marquez, Richard A on 11/15/14.
//  Copyright (c) 2014 wsu. All rights reserved.
//

import Foundation

extension Array {
    func contains<T : Equatable>(x:T) -> Bool {
        for var i = 0; i < self.count; i++ {
            if self[i] as T == x {
                return true
            }
        }
        return false
    }
}