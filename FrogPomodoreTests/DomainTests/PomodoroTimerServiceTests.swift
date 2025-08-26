//
//  PomodoroTimerServiceTests.swift
//  FrogPomodoreTests
//
//  Created by Rodrigo Cerqueira Reis on 25/08/25.
//

import XCTest
@testable import FrogPomodore

final class PomodoroTimerServiceTests: XCTestCase {

    private var sut: PomodoroTimer!
    
    override func setUp() {
        super.setUp()
        sut = PomodoroTimer()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    func test_start_timer_initializes_with_correct_time() {
        let expectedTime: TimeInterval = 25 * 60
        sut.start()
        
        let expectation = XCTestExpectation(description: "Timer should update")
        
        sut.onTimerUpdate = { pomodoro in
            if pomodoro.remainingTimeInSeconds <= expectedTime - 1 {
                XCTAssertEqual(pomodoro.remainingTimeInSeconds, expectedTime - 1, accuracy: 0.1)
                expectation.fulfill()
            }
        }
        
        wait(for: [expectation], timeout: 2.0)
    }
    
    func test_timer_completes_and_changes_to_break_phase() {
        sut = PomodoroTimer(initialTimeInSeconds: 1)
        
        let expectation = XCTestExpectation(description: "Timer should change phase")
        
        sut.onPhaseChange = { pomodoro in
            XCTAssertEqual(pomodoro.phase, .shortBreak)
            XCTAssertEqual(pomodoro.completedWorkCycles, 1)
            expectation.fulfill()
        }
        
        sut.start()
        
        wait(for: [expectation], timeout: 2.0)
    }
}
