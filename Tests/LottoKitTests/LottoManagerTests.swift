//
//  LottoManagerTests.swift
//  LottoKitTests
//
//  Created by Pedro José Pereira Vieito on 22/11/2019.
//  Copyright © 2019 Pedro José Pereira Vieito. All rights reserved.
//

import Foundation
import XCTest
import LottoKit

class LottoManagerTests: XCTestCase {
    static let invalidLottoNumbers = [-1, 100000]
    static let validLottoNumbers = [0, 1993, 99999]

    func testLottoManager() throws {
        for invalidLottoNumber in LottoManagerTests.invalidLottoNumbers {
            XCTAssertThrowsError(try LottoManager.checkLotto(number: invalidLottoNumber))
        }
        
        for lottoNumber in LottoManagerTests.validLottoNumbers {
            let lottoResult = try LottoManager.checkLotto(number: lottoNumber)
            XCTAssertEqual(lottoResult.number, lottoNumber)
            XCTAssertGreaterThanOrEqual(lottoResult.prize, 0)
        }
    }
}
