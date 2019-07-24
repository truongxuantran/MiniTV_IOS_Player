//
//  MSPlayer+Video.swift
//  WebRTC-Demo
//
//  Created by JONGYOUNG CHUNG on 04/07/2019.
//  Copyright © 2019 Stas Seldin. All rights reserved.
//

import Foundation
import WebRTC

extension MSPlayer{
    
    func createVideo(isLocal: Bool, frame: Frame) {
        
        
        let widthProportion : CGFloat = self.containerView.frame.width / 1920
        let heightProportion : CGFloat = self.containerView.frame.height / 1080

        let modifiedFrame = CGRect(x: frame.x * widthProportion, y: frame.y * heightProportion, width: frame.width * widthProportion, height: frame.height * heightProportion)
        
        // video view 생성
        
        if isLocal {
            if self.localVideoView?.superview != nil {
                self.localVideoView.removeFromSuperview()
            }
            self.localVideoView = UIView(frame: modifiedFrame)

            if frame.zIndex <= 2 {
                self.bringLocalVideoToFront()
            }else{
                self.sendLocalVideoToBack()
            }
            
        }else{
            if self.remoteVideoView?.superview != nil {
                self.remoteVideoView.removeFromSuperview()
            }
            self.remoteVideoView = UIView(frame: modifiedFrame)

            if frame.zIndex <= 2 {
                self.bringRemoteVideoToFront()
            }else{
                self.sendRemoteVideoToBack()
            }
        }
        
        let videoView = isLocal ? self.localVideoView! : self.remoteVideoView!
        self.containerView.addSubview(videoView)

        #if arch(arm64)
        // Using metal (arm64 only)
        print("arch(arm64)")
        let renderer = RTCMTLVideoView(frame: videoView.frame)
        renderer.videoContentMode = .scaleAspectFill
        #else
        // Using OpenGLES for the rest
        let renderer = RTCEAGLVideoView(frame: videoView.frame)
        #endif
        
        if isLocal {
            //좌우반전(거울처럼)
//            if UIDevice.current.orientation.isLandscape {
//                renderer.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
//            } else {
//                renderer.transform = CGAffineTransform(scaleX: 1.0, y: -1.0)
//            }
            
            Client.shared.webRTCClient.startCaptureLocalVideo(renderer: renderer)
        }else{
            Client.shared.webRTCClient.renderRemoteVideo(to: renderer)
        }
        self.embedView(renderer, into: videoView)
    }
    
    func destroyVideo(isLocal: Bool) {
        if isLocal {
            
            Client.shared.webRTCClient.stopCaptureLocalVideo()
            if self.localVideoView?.superview != nil {
                self.localVideoView.removeFromSuperview()
            }
        }else{
            Client.shared.webRTCClient.stopRenderRemoteVideo()
            if self.remoteVideoView?.superview != nil {
                self.remoteVideoView.removeFromSuperview()
            }
        }
    }
    
    private func embedView(_ view: UIView, into containerView: UIView) {
        containerView.addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        containerView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[view]|",
                                                                    options: [],
                                                                    metrics: nil,
                                                                    views: ["view":view]))
        
        containerView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[view]|",
                                                                    options: [],
                                                                    metrics: nil,
                                                                    views: ["view":view]))
        containerView.layoutIfNeeded()
    }
    
}
