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
  var startBroadcasting: () -> Effect<Action, Failure>
  var stopBroadcasting: () -> Effect<Never, Never>
  
  var startBrowsing: () -> Effect<Action, Failure>
  var stopBrowsing: () -> Effect<Never, Never>
  
  //  var joinSession: (_ sessionId: String) -> Effect<Action, Failure>
  
  
  enum Action: Equatable {
    
    case didJoinSession(sessionId: String)
    
    // MARK: - Broadcasting
    case didReceiveInviteFromPeer(peerId: MCPeerID)
    
    // MARK: - Browsing
    case peerDiscovered(peerId: MCPeerID)
    case peerStoppedAdvertising(peerId: MCPeerID)
  }
  
  enum Failure: Equatable, Error {
    case couldNotJoinSession(sessionId: String)
    
    // MARK: - Browsing
    case couldNotStartBrowsing
    
  }
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
    
    let serviceBrowser: MCNearbyServiceBrowser = MCNearbyServiceBrowser(
      peer: myPeerId,
      serviceType: serviceType
    )
    
    return Self(
      
      // MARK: - Broadcasting
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
        
      },
      
      stopBroadcasting: {
        .fireAndForget {
          serviceAdvertiser.stopAdvertisingPeer()
        }
      },
      
      // MARK: - Browsing
      
      startBrowsing: {
        Effect.run { subscriber in
          
          let browserDelegate = ServiceBrowserDelegate(
            serviceBrowser,
            
            didFindPeer: { peerId in
              subscriber.send(.peerDiscovered(peerId: peerId))
            },
            
            peerDidStopAdvertising: { peerId in
              subscriber.send(.peerStoppedAdvertising(peerId: peerId))
            }
          )
          
          serviceBrowser.delegate = browserDelegate
          serviceBrowser.startBrowsingForPeers()
          
          let cancellable = AnyCancellable {
            _ = serviceBrowser
            _ = browserDelegate
            serviceBrowser.stopBrowsingForPeers()
          }
         
          return cancellable
        }
      },
      
      stopBrowsing: {
         .fireAndForget {
           serviceBrowser.stopBrowsingForPeers()
         }
      }
      
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

private class ServiceBrowserDelegate: NSObject, MCNearbyServiceBrowserDelegate {
  
  // Assuming this browser is the same as the one in the methods
  // below. Could be source of bugs.
  let browser: MCNearbyServiceBrowser
  
  let didFindPeer: (_ peerId: MCPeerID) -> Void
  let peerDidStopAdvertising: (_ peerId: MCPeerID) -> Void
 
  init(
    _ browser: MCNearbyServiceBrowser,
    didFindPeer: @escaping (_ peerId: MCPeerID) -> Void,
    peerDidStopAdvertising: @escaping (_ peerId: MCPeerID) -> Void
  ) {
    self.browser = browser
    self.didFindPeer = didFindPeer
    self.peerDidStopAdvertising = peerDidStopAdvertising
  }
  
  
  func browser(_ browser: MCNearbyServiceBrowser, foundPeer peerID: MCPeerID, withDiscoveryInfo info: [String : String]?) {
    didFindPeer(peerID)
  }
  
  func browser(_ browser: MCNearbyServiceBrowser, lostPeer peerID: MCPeerID) {
    peerDidStopAdvertising(peerID)
  }
  
  func stopBrowsing() {
    browser.stopBrowsingForPeers()
  }
  
}
