//
//  MSPlayer.swift
//  WebRTC-Demo
//
//  Created by JONGYOUNG CHUNG on 03/07/2019.
//  Copyright © 2019 Stas Seldin. All rights reserved.
//

import Foundation
import WebRTC
import WebKit

class MSPlayer : NSObject {

    var localVideoView: UIView!
    var remoteVideoView: UIView!
    var webView: WKWebView!
    weak var containerView: UIView!


    init(containerView: UIView) {
        super.init()
//      

        // video view 생성(local, remote)
        self.localVideoView = UIView(frame: CGRect(x: 0, y: containerView.frame.height * 0.5, width: 100, height: 50))
        self.remoteVideoView = UIView(frame: CGRect(x: containerView.frame.width * 0.5, y: containerView.frame.height * 0.5, width: 100, height: 50))
//        self.localVideoView = localVideoView
//        self.remoteVideoView = remoteVideoView

        //위치 설정
        self.initVideoView()

        // webview 생성
        self.containerView = containerView

        self.initWebview()
        
        self.containerView.addSubview(self.localVideoView)
        self.containerView.addSubview(self.remoteVideoView)
        self.containerView.sendSubviewToBack(webView)
    }
    
    func run() {
        self.openUrl()
    }
}
