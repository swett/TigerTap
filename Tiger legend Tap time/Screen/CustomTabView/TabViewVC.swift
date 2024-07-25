//
//  TabVC.swift
//  Tiger legend Tap time
//
//  Created by Mykyta Kurochka on 30.06.2024.
//

import UIKit
import SwiftUI

class TabViewVC: UIHostingController<CustomTabBar> {
    
    var viewModel: TabViewModel
    
    init(viewModel: TabViewModel) {
        self.viewModel = viewModel
        super.init(rootView: CustomTabBar(viewModel: viewModel))
    }
    
    @MainActor required dynamic init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.setView(self)
        // Do any additional setup after loading the view.
    }
}
