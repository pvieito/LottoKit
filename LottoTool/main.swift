//
//  main.swift
//  LottoTool
//
//  Created by Pedro José Pereira Vieito on 30/12/2017.
//  Copyright © 2017 Pedro José Pereira Vieito. All rights reserved.
//

import Foundation
import FoundationKit
import LoggerKit
import ArgumentParser
import LottoKit

struct LottoTool: ParsableCommand {
    static var configuration: CommandConfiguration {
        return CommandConfiguration(commandName: String(describing: Self.self))
    }
    
    @Option(name: .shortAndLong, parsing: .upToNextOption, help: "Input numbers.")
    var input: Array<String>
    
    @Option(name: .shortAndLong, help: "Output format (\(LottoManager.LottoMode.allCases.map(\.rawValue).quotedListDescription)).")
    var mode: LottoManager.LottoMode?
        
    @Flag(name: .shortAndLong, help: "Verbose mode.")
    var verbose: Bool = false
    
    func run() throws {
        Logger.logMode = .commandLine
        Logger.logLevel = self.verbose ? .debug : .info

        for inputValue in self.input {
            guard let inputNumber = Int(inputValue) else {
                Logger.log(warning: "Input value “\(inputValue)” is not a valid number.")
                continue
            }
            
            do {
                let lottoResult = try LottoManager.checkLotto(number: inputNumber, mode: self.mode)
                Logger.log(success: lottoResult)
            }
            catch {
                Logger.log(warning: "\(inputNumber): \(error.localizedDescription)")
            }
        }
    }
}

LottoTool.main()
