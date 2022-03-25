//
//  SynchronizationClient.swift
//  ScreenshotButton
//
//  Created by laptop on 3/25/22.
//

import ComposableArchitecture
import Combine
import MultipeerConnectivity
import os

struct SynchronizationClient {
  var startBroadcasting: () -> Effect<Action, Never>
  //  var startListening: () -> Effect<Never, Never>
  //  var joinSession: (_ sessionId: String) -> Effect<Action, Failure>
}

enum Action: Equatable {
case didJoinSession(sessionId: String)
case didReceiveInviteFromPeer(peerId: MCPeerID)
}

enum Failure: Equatable, Error {
  case couldNotJoinSession(sessionId: String)
}

extension SynchronizationClient {
  
  static var localMultipeer: Self {
    
    let serviceType = "example-color"
    
#if os(iOS)
    let myPeerId = MCPeerID(displayName: UIDevice.current.name)
#else
    let myPeerId = MCPeerID(displayName: Host.current().localizedName!)
#endif
    
    let session: MCSession = MCSession(peer: myPeerId)
    
    let serviceAdvertiser: MCNearbyServiceAdvertiser = MCNearbyServiceAdvertiser(
      peer: myPeerId,
      discoveryInfo: nil,
      serviceType: serviceType
    )
    //     let serviceBrowser: MCNearbyServiceBrowser
    
    
    
    return Self(
      startBroadcasting: {
        Effect.run { subscriber in
          
          let advertiserDelegate = ServiceAdvertiserDelegate(
            didReceiveInviteFromPeer: { peerId in
              subscriber.send(.didReceiveInviteFromPeer(peerId: peerId))
            },
            
            session: session
          )
          
          serviceAdvertiser.delegate = advertiserDelegate
          
          serviceAdvertiser.startAdvertisingPeer()
          
          let cancellable = AnyCancellable {
            _ = serviceAdvertiser
            _ = advertiserDelegate
            serviceAdvertiser.stopAdvertisingPeer()
          }
          
          return cancellable
        }
        
      }
      
      //      startListening: .fireAndForget { _ in
      //
      //      },
      //      joinSession: .future {_ in}
    )
  }
  
}

private class ServiceAdvertiserDelegate: NSObject, MCNearbyServiceAdvertiserDelegate {
  private var invitationHandler: ((Bool, MCSession?) -> Void)?
  
  let didReceiveInviteFromPeer: (_ peerId: MCPeerID) -> Void
  let session: MCSession
  
  init(
    didReceiveInviteFromPeer: @escaping (_ peerId: MCPeerID) -> Void,
    session: MCSession
  ) {
    self.didReceiveInviteFromPeer = didReceiveInviteFromPeer
    self.session = session
  }
  
  func advertiser(_ advertiser: MCNearbyServiceAdvertiser,
                  didReceiveInvitationFromPeer peerID: MCPeerID,
                  withContext context: Data?,
                  invitationHandler: @escaping (Bool, MCSession?) -> Void
  ) {
    self.invitationHandler = invitationHandler
  }
  
  func join() {
    guard let invitationHandler = invitationHandler else {
      return
    }
    
    invitationHandler(true, session)
  }
  
  
}
