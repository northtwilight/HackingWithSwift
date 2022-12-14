//
//  HWSSU_02_GuessTheFlagUITestsLaunchTests.swift
//  HWSSU-02-GuessTheFlagUITests
//
//  Created by Massimo Savino on 2022-08-24.
//

import XCTest

class HWSSU_02_GuessTheFlagUITestsLaunchTests: XCTestCase {

    override class var runsForEachTargetApplicationUIConfiguration: Bool {
        true
    }

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    func testLaunch() throws {
        let app = XCUIApplication()
        app.launch()

        // Insert steps here to perform after app launch but before taking a screenshot,
        // such as logging into a test account or navigating somewhere in the app

        let attachment = XCTAttachment(screenshot: app.screenshot())
        attachment.name = "Launch Screen"
        attachment.lifetime = .keepAlways
        add(attachment)
    }
}
