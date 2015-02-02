//
//  PopularShotsViewController.swift
//  Dribbble_client_sample
//
//  Created by Ryo Aoyama on 2/2/15.
//  Copyright (c) 2015 Ryo Aoyama. All rights reserved.
//

import UIKit

class PopularShotsViewController: ShotsListViewController {
    override func shotsStatusComponent() -> ShotsStatusComponent {
        var component = super.shotsStatusComponent()
        component.timeFrame = .Month
        component.sort = .Views
        return component
    }
}