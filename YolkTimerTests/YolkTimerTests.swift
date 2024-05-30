//
//  YolkTimerTests.swift
//  YolkTimerTests
//
//  Created by Adrien CHABAUD on 2024-05-30.
//

import XCTest
@testable import YolkTimer

final class YolkTimerTests: XCTestCase {

//    func test_methodName_withCircumstances_shouldExpectation() throws {
//
//    }
    var startViewModel: StartViewModel!
    
    override func setUp() {
        super.setUp()
        
        // Initialize the StartViewModel before each test
        startViewModel = StartViewModel()
    }
    
    override func tearDown() {
        // Clean up after each test
        startViewModel = nil
        super.tearDown()
    }
    
    func test_settingTimeFor_RunnyYolk() throws {
        // Given
        let expectedRunnyYolkTime = 180 // 3 minutes in seconds
        startViewModel.pickerSelection = .runnyState // Select the runny state
        
        // When
        startViewModel.selectTime()
        
        // Then
        XCTAssertEqual(Int(startViewModel.remainingTime), expectedRunnyYolkTime, "Runny yolk timer should be set to 3 minutes.")
    }
    
    func test_settingTimeFor_SoftEgg() throws {
        //Given
        let expectedSoftEggTime = 360 // 6 minutes in seconds
        startViewModel.pickerSelection = .softState
        
        // When
        startViewModel.selectTime()
        
        // Then
        XCTAssertEqual(Int(startViewModel.remainingTime), expectedSoftEggTime, "Soft egg timer should be set to 6 minutes.")
    }
    
    func test_settingTimeFor_HardEgg() throws {
        // Given
        let expectedHardEggTime = 540 // 9 minutes in seconds
        startViewModel.pickerSelection = .hardState
        
        // When
        startViewModel.selectTime()
        
        // Then
        XCTAssertEqual(Int(startViewModel.remainingTime), expectedHardEggTime, "Hard egg timer should be set to 9 minutes.")
    }

}
