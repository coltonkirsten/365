//
//  Bouncy_Ball_Sim__Day_2_UITestsLaunchTests.swift
//  Bouncy Ball Sim (Day 2)UITests
//
//  Created by Colton Kirsten on 1/2/25.
//

import XCTest

final class Bouncy_Ball_Sim__Day_2_UITestsLaunchTests: XCTestCase {

    override class var runsForEachTargetApplicationUIConfiguration: Bool {
        true
    }

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    @MainActor
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
