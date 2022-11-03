//
//  OzeTestTests.swift
//  OzeTestTests
//
//  Created by Mac on 03/11/2022.
//
import Combine
import XCTest
@testable import OzeTest

final class OzeTestTests: XCTestCase {

    private var mockRepository: MockRepository!
    private var viewModelToTest: ViewModel!
    private var cancellables: Set<AnyCancellable> = []
    
    override func setUpWithError() throws {
        mockRepository = MockRepository()
        viewModelToTest = ViewModel(with: mockRepository)
    }
    
    override func tearDownWithError() throws {
        mockRepository = nil
        viewModelToTest = nil
    }
    
    func testLaunchDataIsRetured() {
        let expectation = XCTestExpectation(description: "Data is fetched")
        viewModelToTest.fetchDataFromApi(page: 1)
        viewModelToTest.fetchFromDB()
        viewModelToTest.$itemsFromDb
            .sink { result in
                XCTAssertEqual(result.count, 4)
                expectation.fulfill()
            }.store(in: &cancellables)
        wait(for: [expectation], timeout: 1)
    }
    
    func testDevDetailsIsReturned() {
        let mockData = mockRepository.mockRepoData
        let expectation = XCTestExpectation(description: "Data is fetched")
        mockRepository.fetchRepoData = Result.success(mockData).publisher.eraseToAnyPublisher()
        viewModelToTest.fetchRepoData(name: "Ekene")
        
        viewModelToTest.$repoDataCount.sink { result in
            XCTAssert(!result.isEmpty)
            expectation.fulfill()
        }.store(in: &cancellables)
        wait(for: [expectation], timeout: 1)
    }
    
    func testAddFavourite() {
        let mockData = mockRepository.mockRepoData
        let expectation = XCTestExpectation(description: "Data is fetched")
        viewModelToTest.update(id: 1, updateValue: mockData, save: false)
        viewModelToTest.update(id: 1, updateValue: mockData, save: true)
        viewModelToTest.fetchFromDB()
        viewModelToTest.$itemsFromDb
            .sink { result in
                XCTAssertEqual(result.first?.repoData.count, 3)
                expectation.fulfill()
            }.store(in: &cancellables)
        wait(for: [expectation], timeout: 1)
    }
    
    func testRemoveFavourite() {
        let mockData = mockRepository.mockRepoData
        let expectation = XCTestExpectation(description: "Data is fetched")
        viewModelToTest.update(id: 1, updateValue: mockData, save: true)
        viewModelToTest.update(id: 1, updateValue: mockData, save: false)
        viewModelToTest.fetchFromDB()
        viewModelToTest.$itemsFromDb
            .sink { result in
                XCTAssertEqual(result.first?.repoData.count, 0)
                expectation.fulfill()
            }.store(in: &cancellables)
        wait(for: [expectation], timeout: 1)
    }
}
