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
    static let validLottoNumbers = [0] + Array(1993...2019) + [99999]
    
    func testLottoManagerInputChecks() throws {
        for lottoMode in LottoManager.LottoMode.allCases + [nil] {
            for invalidLottoNumber in LottoManagerTests.invalidLottoNumbers {
                XCTAssertThrowsError(try LottoManager.checkLotto(number: invalidLottoNumber, mode: lottoMode))
            }
            
            for lottoNumber in LottoManagerTests.validLottoNumbers {
                let lottoResult = try LottoManager.checkLotto(number: lottoNumber, mode: lottoMode)
                XCTAssertEqual(lottoResult.number, lottoNumber)
                XCTAssertGreaterThanOrEqual(lottoResult.prize, 0)
            }
        }
    }
    
    func testLottoManagerKeepsCoherentResults() throws {
        for validNumber in LottoManagerTests.validLottoNumbers {
            for lottoMode in LottoManager.LottoMode.allCases {
                var lottoMode: LottoManager.LottoMode? = lottoMode
                
                let prize1 = try LottoManager.checkLotto(number: validNumber, mode: lottoMode).prize
                let prize2 = try LottoManager.checkLotto(number: validNumber, mode: lottoMode).prize
                
                if lottoMode == .christmas {
                    lottoMode = nil
                }
                
                let prize3 = try LottoManager.checkLotto(number: validNumber, mode: lottoMode).prize
                
                XCTAssertEqual(prize1, prize2)
                XCTAssertEqual(prize2, prize3)
            }
        }
    }
}
