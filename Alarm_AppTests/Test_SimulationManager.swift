//
//  Alarm_AppTests.swift
//  Alarm_AppTests
//
//  Created by Sven Niederlöhner on 27.05.26.
//

import XCTest
@testable import Alarm_App

final class Alarm_AppTests: XCTestCase {
    
    var manager : SimulationManager!

    @MainActor
    override func setUpWithError() throws {
       try super.setUpWithError()
        manager = SimulationManager.simulationsschicht
        manager.resetToAwake()
    }

    @MainActor
    override func tearDownWithError() throws {
       manager = nil
        try super.tearDownWithError()
    }

    @MainActor
    func testStateAwake(){
        XCTAssertEqual(manager.currentStatus, .awake)
    }

    @MainActor
    func testStateisAsleep(){
        manager.triggerToAsleep()
        XCTAssertEqual(manager.currentStatus, .asleep)
    }
}
