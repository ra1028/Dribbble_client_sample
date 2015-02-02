//
//  ShotsModel.swift
//  Dribbble_client_sample
//
//  Created by Ryo Aoyama on 2/1/15.
//  Copyright (c) 2015 Ryo Aoyama. All rights reserved.
//

import RequestKit

class ShotsModel: Model {
    class var sharedModel: ShotsModel {
        struct SharedInstance {
            static let instance = ShotsModel()
        }
        return SharedInstance.instance
    }
    
    let PerPage = 20
    
    func fetchLatestShots(
        list: List? = nil,
        sort: Sort? = nil,
        timeFrame: TimeFrame? = nil,
        success: ([Shot] -> Void)? = nil,
        failure: Failure? = nil) {
            ShotsRequest.fetchShotsList(
                list: list,
                timeframe: timeFrame,
                sort: sort,
                page: 1,
                perPage: PerPage,
                handelers: Request.Handlers(
                    success: { (urlResponse, responseObject) -> Void in
                        var shots = [Shot]()
                        if let json: JSON = Model.serializeToJson(responseObject) {
                            for shotJson in json {
                                let shot = Shot(json: shotJson.1)
                                shots.append(shot)
                            }
                        }
                        success?(shots)
                        return
                    },
                    failure: { (urlResponse, error) -> Void in
                        failure?(error: error! as NSError)
                        return
                }))
    }
    
    func fetchAdditionalShots(
        list: List? = nil,
        sort: Sort? = nil,
        timeFrame: TimeFrame? = nil,
        page: Int = 2,
        success: ([Shot] -> Void)? = nil,
        failure: Failure? = nil) {
            ShotsRequest.fetchShotsList(
                list: list,
                timeframe: timeFrame,
                sort: sort,
                page: page,
                perPage: PerPage,
                handelers: Request.Handlers(
                    success: { (urlResponse, responseObject) -> Void in
                        var shots = [Shot]()
                        if let json: JSON = Model.serializeToJson(responseObject) {
                            for shotJson in json {
                                let shot = Shot(json: shotJson.1)
                                shots.append(shot)
                            }
                        }
                        success?(shots)
                        return
                    },
                    failure: { (urlResponse, error) -> Void in
                        failure?(error: error! as NSError)
                        return
                }))
    }
}