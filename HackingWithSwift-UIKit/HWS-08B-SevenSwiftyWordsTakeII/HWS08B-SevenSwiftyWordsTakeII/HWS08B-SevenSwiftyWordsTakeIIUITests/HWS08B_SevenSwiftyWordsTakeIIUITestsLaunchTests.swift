//
//  HWS08B_SevenSwiftyWordsTakeIIUITestsLaunchTests.swift
//  HWS08B-SevenSwiftyWordsTakeIIUITests
//
//  Created by Massimo Savino on 2022-09-30.
//

import XCTest

final class HWS08B_SevenSwiftyWordsTakeIIUITestsLaunchTests: XCTestCase {

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
