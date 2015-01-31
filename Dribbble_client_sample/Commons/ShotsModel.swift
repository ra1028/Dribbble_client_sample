//
//  ShotsModel.swift
//  Dribbble_client_sample
//
//  Created by Ryo Aoyama on 2/1/15.
//  Copyright (c) 2015 Ryo Aoyama. All rights reserved.
//

import RequestKit

class ShotsModel {
    class var sharedModel: ShotsModel {
        struct SharedInstance {
            static let instance = ShotsModel()
        }
        return SharedInstance.instance
    }
    
    let PerPage = 20
    
    func fetchLatestShots(list: List,
        sort: Sort,
        page: Int,
        success: ) {
            ShotsRequest.fetchShotsList(
                list: list,
                timeframe: .Ever,
                sort: sort,
                page: page,
                perPage: PerPage,
                handelers: handlers)
    }
}