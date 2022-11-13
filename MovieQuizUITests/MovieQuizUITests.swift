//
//  MovieQuizUITests.swift
//  MovieQuizUITests
//
//  Created by Pavel Razumov on 11.11.2022.
//

import XCTest

final class MovieQuizUITests: XCTestCase {
    
    var app: XCUIApplication!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        
        app = XCUIApplication()
        app.launch()
        
        continueAfterFailure = false
    }
    
    override func tearDownWithError() throws {
        try super.tearDownWithError()
        
        app.terminate()
        app = nil
    }
    
    func testYesButton() throws {
        
        let firstPoster = app.images["Poster"]
        app.buttons["Yes"].tap()
        
        let secondPoster = app.images["Poster"]
        
        let indexLabel = app.staticTexts["Index"]
        
        sleep(3)
        
        XCTAssertFalse(firstPoster == secondPoster)
        XCTAssertTrue(indexLabel.label == "2/10")
    }
    
    func testNoButton() throws {
    
        let firstPoster = app.images["Poster"]
        app.buttons["No"].tap()
        
        let secondPoster = app.images["Poster"]
        
        sleep(3)
        
        XCTAssertFalse(firstPoster == secondPoster)
    }
    
    func testMe() throws {
        
        let app = XCUIApplication()
        let yesButton = app/*@START_MENU_TOKEN@*/.buttons["Yes"]/*[[".buttons[\"Да\"]",".buttons[\"Yes\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        yesButton.tap()
        yesButton.tap()
        yesButton.tap()
        yesButton.tap()
        yesButton.tap()
        yesButton.tap()
        yesButton.tap()
        yesButton.tap()
        yesButton.tap()
        yesButton.tap()
        yesButton.tap()
        app.alerts["Этот раунд окончен!"].scrollViews.otherElements.buttons["Сыграть еще раз?"].swipeUp()
        
    }
    
    func testFinishAlert() throws {
        
        for _ in 1...10 {
            app.buttons["Yes"].tap()
            sleep(2)
        }
        
        let alert = app.alerts["Этот раунд окончен!"]
        
        XCTAssertTrue(alert.exists)
        XCTAssertTrue(alert.label == "Этот раунд окончен!")
        XCTAssertTrue(alert.buttons.firstMatch.label == "Сыграть еще раз?")
        
    }

    func testDismissAlert() throws {
        
        for _ in 1...10 {
            app.buttons["Yes"].tap()
            sleep(2)
        }
        
        let alert = app.alerts["Этот раунд окончен!"]
        
        alert.buttons.firstMatch.tap()
        sleep(2)
        
        let indexLabel = app.staticTexts["Index"]
        
        XCTAssertFalse(alert.exists)
        XCTAssertTrue(indexLabel.label == "1/10")
        
    }
}
