//
//  ShotsRequest.swift
//  Dribbble_client_sample
//
//  Created by Ryo Aoyama on 1/31/15.
//  Copyright (c) 2015 Ryo Aoyama. All rights reserved.
//

import RequestKit

enum List: String {
    case Animated = "animated"
    case Attachments = "attachments"
    case Debuts = "debuts"
    case Playoffs = "playoffs"
    case Rebounds = "rebounds"
    case Teams = "teams"
}

enum TimeFrame: String {
    case Week = "week"
    case Month = "month"
    case Year = "year"
    case Ever = "ever"
}

enum Sort: String {
    case Comments = "comments"
    case Recent = "recent"
    case Views = "views"
}

class ShotsRequest: appRequest {
    private struct Keys {
        static let List = "list"
        static let TimeFrame = "timeframe"
        static let Sort = "sort"
        static let Page = "page"
        static let PerPage = "per_page"
    }
    
    class func fetchShotsList(
        list: List? = nil,
        timeframe: TimeFrame? = nil,
        sort: Sort? = nil,
        page: Int? = 1,
        perPage: Int? = 20,
        handelers: Handlers? = nil
        ) {
            var request = ShotsRequest()
            var component = RequestComponent(method: .GET, path: "/shots")
            var parameters = Parameters()
            
            if let value = list {
                parameters[Keys.List] = value.rawValue
            }
            if let value = timeframe {
                parameters[Keys.TimeFrame] = value.rawValue
            }
            if let value = sort {
                parameters[Keys.Sort] = value.rawValue
            }
            if let value = page {
                parameters[Keys.Page] = value
            }
            if let value = perPage {
                parameters[Keys.PerPage] = value
            }
            
            component.parameters = parameters
            request.handlers = handelers
            request.component = component
            request.dispatcher.dispatch(request)
    }
}