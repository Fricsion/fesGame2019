//
//  global.swift
//  fesGame2019
//
//  Created by Tiz Matz on 2019/09/10.
//  Copyright © 2019 Tiz'sMake. All rights reserved.
//

import Foundation

// categoryBitMask管理
let playerBit: UInt32 = 1 << 3
let bulletBit: UInt32 = 1 << 2
let enemyBit : UInt32 = 1 << 0

/*
 スコアの追加
 スコアの算出方法を如何にしようか
*/
var score: Int = 0
var scores: [Int] = []
