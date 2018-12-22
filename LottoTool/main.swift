//
//  main.swift
//  LottoTool
//
//  Created by Pedro José Pereira Vieito on 30/12/2017.
//  Copyright © 2017 Pedro José Pereira Vieito. All rights reserved.
//

import Foundation
import LoggerKit
import CommandLineKit
import LottoKit

let inputOption = MultiStringOption(shortFlag: "i", longFlag: "input", required: true, helpMessage: "Input numbers.")
let modeOption = EnumOption<LottoManager.LottoMode>(shortFlag: "m", longFlag: "mode", helpMessage: "Lotto mode.")
let verboseOption = BoolOption(shortFlag: "v", longFlag: "verbose", helpMessage: "Verbose mode.")
let helpOption = BoolOption(shortFlag: "h", longFlag: "help", helpMessage: "Prints a help message.")

let cli = CommandLineKit.CommandLine()
cli.addOptions(inputOption, modeOption, verboseOption, helpOption)

do {
    try cli.parse(strict: true)
}
catch {
    cli.printUsage(error)
    exit(-1)
}

if helpOption.value {
    cli.printUsage()
    exit(0)
}

Logger.logMode = .commandLine
Logger.logLevel = verboseOption.value ? .debug : .info

guard let inputValues = inputOption.value else {
    Logger.log(warning: "Input values not specified.")
    exit(-1)
}

for inputValue in inputValues {

    guard let inputNumber = Int(inputValue) else {
        Logger.log(warning: "Input value “\(inputValue)” is not a valid number.")
        continue
    }
    
    do {
        let lottoResult = try LottoManager.checkLotto(number: inputNumber, mode: modeOption.value)
        Logger.log(success: lottoResult)
    }
    catch {
        Logger.log(error: "\(inputNumber): \(error.localizedDescription)")
    }
}

