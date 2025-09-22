//
//  SamuAdventures_2025_09_05_menu_1_3_ENG_HUUITestsLaunchTests.swift
//  SamuAdventures_2025_09_05_menu_1_3_ENG_HUUITests
//
//  Created by Eva Julia Boros on 2025. 09. 05..
//

import XCTest

final class SamuAdventures_2025_09_05_menu_1_3_ENG_HUUITestsLaunchTests: XCTestCase {

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
