# Baluchon
> An iOS Travel app for the project number 9 of the iOS Developer training program of OpenclassRooms



<a href="https://github.com/Nicotrz"><img src="https://github.com/Nicotrz/baluchon/blob/master/Capture%20d’écran%202019-11-20%20à%2022.08.56.png?raw=true" title="Baluchon" alt="Nicotrz"></a>
<!-- [![FVCproductions](https://github.com/Nicotrz/baluchon/blob/master/Capture%20d’écran%202019-11-20%20à%2022.08.56.png?raw=true)](https://github.com/Nicotrz) -->

## Setup

To edit the code, just clone the repo.

To use it, please subscribe to the providers of the differents APIs (Fixer.io / Google Translate / OpenWeatherMaps) ans set the keys on a file you can call "keys.plist" in the baluchon repository.

Then you can set the key as with the titles:
- changekey for the Fixer.io key
- translatekey for the Google Translate key
- weatherkey for the OpenWeatherMaps key

This app is not available on the App Store

## Features

Prepare your next holidays with this iOS App: 
- Change the Currency with all the currencies of the world (API: Fixer.io)
- Translate a phrase from a language to another (API: Google Translate)
- Check the weather in 2 differents cities at the same time (API: OpenWeatherMaps)

## Purpose of the project

This app is been build from scratch (no design or sketch, no basic code). The main purpose of the project was to use API Calls with URLSessions and make unit test with mocked calls.

## Code Architecture

This code use the MVC Architecture. The API calls are all made on the model without any external frameworks.

The tests are made by making fakes URLSession and URLSessionDataTask classes who override the main methods:
```Swift
class URLSessionFake: URLSession {
    var data: Data?
    var response: URLResponse?
    var error: Error?

    init(data: Data?, response: URLResponse?, error: Error?) {
        self.data = data
        self.response = response
        self.error = error
    }

    override func dataTask(
        with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        let task = URLSessionDataTaskFake()
        task.completionHandler = completionHandler
        task.data = data
        task.urlResponse = response
        task.responseError = error
        return task
    }

    override func dataTask(
        with request: URLRequest, completionHandler: @escaping (
        Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        let task = URLSessionDataTaskFake()
        task.completionHandler = completionHandler
        task.data = data
        task.urlResponse = response
        task.responseError = error
        return task
    }
}

class URLSessionDataTaskFake: URLSessionDataTask {
    var completionHandler: ((Data?, URLResponse?, Error?) -> Void)?
    var data: Data?
    var urlResponse: URLResponse?
    var responseError: Error?

    override func resume() {
        completionHandler?(data, urlResponse, responseError)
    }

    override func cancel() {}
}
```

```Swift
Then we can just simulate the response from the server on the tests:
    func testRefreshChangeShouldPostFailedCallbackIfIncorrectData() {
        let changeService = ChangeService(
            changeSession: URLSessionFake(
                data: fakeChangeData.incorrectData, response: fakeChangeData.responseOK, error: nil))
        let expectaction = XCTestExpectation(description: "Wait for queue change.")
        changeService.refreshChangeRate { (errorCase, refreshDate) in
           XCTAssertEqual(errorCase, .networkError)
            XCTAssertNil(refreshDate)
            expectaction.fulfill()
        }
        wait(for: [expectaction], timeout: 0.01)
    }
```

## Credits
Nicolas Sommereijns - 2019
