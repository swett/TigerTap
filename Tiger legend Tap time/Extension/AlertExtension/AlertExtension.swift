//
//  AlertExtension.swift
//  Tiger legend Tap time
//
//  Created by Mykyta Kurochka on 02.07.2024.
//

import UIKit
import SwiftUI
import SwiftMessages

@MainActor func showAlert(with title: String, with body: String, viewcontroller: UIViewController) {
    let messageView: MessageView = MessageView.viewFromNib(layout: .centeredView)
    messageView.configureContent(title: title, body: body)
    messageView.button?.isHidden = true
    messageView.iconLabel?.isHidden = true
    messageView.iconImageView?.isHidden = true
    messageView.configureTheme(backgroundColor: UIColor(hexString: "#12171B"), foregroundColor: UIColor(hexString: "#FAFF00"))
    messageView.configureDropShadow()
    messageView.configureBackgroundView(width: 400)
    var config = SwiftMessages.defaultConfig
    config.presentationStyle = .top
    config.presentationContext = .viewController(viewcontroller)
    SwiftMessages.show(config: config, view: messageView)
}

struct DemoMessage: Identifiable {
    let title: String
    let body: String

    var id: String { title + body }
}

struct DemoMessageView: View {

    let message: DemoMessage

    var body: some View {
        VStack(alignment: .leading) {
            Text(message.title).font(.system(size: 25, weight: .bold))
            Text(message.body).font(.system(size: 20, weight: .regular))
        }
        .foregroundColor(.theme.mainTextColor)
        .multilineTextAlignment(.leading)
        .padding(30)
        // This makes the message width greedy
        .frame(maxWidth: .infinity)
        .background(LinearGradient(colors: [Color(hex: "#141925"),Color(hex: "#060910")], startPoint: .top, endPoint: .bottom))
        // This makes a tab-style view where the bottom corners are rounded and
        // the view's background extends to the top edge.
        .mask(
            RoundedRectangle(cornerRadius: 16)
            
            // This causes the background to extend into the safe area to the screen edge.
            .edgesIgnoringSafeArea(.top)
        )
    }
}
