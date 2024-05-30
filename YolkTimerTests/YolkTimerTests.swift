//
//  YolkTimerTests.swift
//  YolkTimerTests
//
//  Created by Adrien CHABAUD on 2024-05-30.
//

import XCTest
import Combine
@testable import YolkTimer

final class YolkTimerTests: XCTestCase {

//    func test_methodName_withCircumstances_shouldExpectation() throws {
//
//    }
    var startViewModel: StartViewModel!
    var cancellables: Set<AnyCancellable> = []
    
    override func setUp() {
        super.setUp()
        
        // Initialize the StartViewModel before each test
        startViewModel = StartViewModel()
    }
    
    override func tearDown() {
        // Clean up after each test
        startViewModel = nil
        cancellables = []
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
    
    func test_TimerCountdown() throws {
        // Given
        startViewModel.pickerSelection = .runnyState // 3 minutes in seconds
        startViewModel.selectTime()
        
        // When
        startViewModel.isRunning = true
        print("Timer started with remaining time: \(startViewModel.remainingTime)")
        
        // Set up expectation
        let expectation = self.expectation(description: "Timer should countdown")
        
        // Subscribe to changes in remainingTime
        startViewModel.$remainingTime
            .dropFirst() // Ignore the initial value
            .sink { remainingTime in
                print("Remaining time: \(remainingTime)")
                if remainingTime < 180 {
                    expectation.fulfill()
                }
            }
            .store(in: &cancellables)
        
        // Then
        waitForExpectations(timeout: 2, handler: nil)
        XCTAssertLessThan(startViewModel.remainingTime, 180, "Timer should count down.")
    }
    
    // Timer func
    // test setting timer (3 cases) X
    // Test timer countdown X
    // Test timer completion
    
    // Notif func
    // test notification is sent when timer completes
    
    // UI Elements
    // Test UI components are present and visible
    // Test UX: tapping on button changes the egg cooking type
    
    // Edge test
    // Test rapid timer changes does not cause errors or incorrect timer durations
    // Verify that app handles interruptions (incoming calls) without loosing timer progress
    

}
