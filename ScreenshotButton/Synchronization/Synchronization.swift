//
// Created by laptop on 3/17/22.
//
import ComposableArchitecture
import MultipeerConnectivity

struct Session: Equatable, Identifiable {
  enum Status: Equatable {
    case idle
    case invitedToJoin(peerId: MCPeerID)
    case attemptingToJoin(sessionId: String)
    case joinFailed(sessionId: String, reason: String)

    case active(sessionId: String)
  }

  let id: UUID = .init()
  var status: Status = .idle
}

struct SynchronizationState: Equatable, Identifiable {
  let id: UUID
  var session: Session
}

/// TODO: further break this down into
/// Joining Session
/// and
/// Sending Messages
/// and
/// Disconnecting
enum SynchronizationAction: Equatable {
  // MARK: - Before Joining a Session
  case notAbleToStartBroadcastingAvailability(error: String)
  case notAbleToStartBrowsingForOthers(error: String)

  case possiblePeerDiscovered(peerId: String)
  /* going to write these as human readable as an experiment (see 95 commands otter recording */
  /*👋🇺🇸🇺🇦*/case requestInviteToSession(sessionId: String) /*(SyncrhonizationAction  ) */
  /*
                                                                * Session ID will be in sender's state, so don't need to specify as argument
                                                                */
  /*🇺🇦🤝🇺🇸*/case peerRequestedInviteToOurSession(invitingPeerId: String)
  /*🇺🇸🤝🇺🇦*/case receivedInviteFromPeer(invitingPeerId: MCPeerID)
  /*🗺🤐🔐*/case peerJoinedOurSession(
    joinerId: String,
    sessionId: String /*TODO: - session secret */
  )

  // MARK: - During an Attempt to Join a Session
  case attemptToJoinSession(sessionId: String)
  case weJoinedSessionSuccessfully(
    sessionId: String,
    peers: [String],
    /*TODO json or data handling instead of plain String*/
    currentState: String?
  )
  case errorJoiningSession(String)

  // MARK: Sending Mesages (After Joining Session)
  // FIXME: Pass JSON data instead of Stringified JSON data (if simple enough) (expect performance problems when state changes a lot or when state changes are large)
  // TODO: Should have some kind of simple code to share when syncing data or listening for data from connected peers to stave off malicious intent. This is, in realty, a non-realistic attack vector for this application. You should only use it with people you trust and enjoy spending time with as friends, family, and brothers and sisters under one blue earth
  case sendSyncState( /* //TODO: json or data handling*/String)
  case syncStateReceived( /*TODO json or data handling*/String)
  case sessionStateDidChange(state: MCSessionState)

  // Mark: Handling Errors after we've joined a session with at least one other peer
  case lostPeer(peerId: String)
}

struct SynchronizationEnvironment {
  let synchronizationClient: SynchronizationClient = .localMultipeer
}

let synchronizationReducer = Reducer<
  SynchronizationState,
  SynchronizationAction,
  SynchronizationEnvironment> { state, action, environment in

  switch action {
    
  case .receivedInviteFromPeer(invitingPeerId: let invitingPeerId):
    state.session.status = .invitedToJoin(peerId: invitingPeerId)
    
  case .possiblePeerDiscovered(peerId: let peerId): break
  case .requestInviteToSession(sessionId: let sessionId):break
    
  case .peerRequestedInviteToOurSession(invitingPeerId: let invitingPeerId):break
    
    
  case .peerJoinedOurSession(joinerId: let joinerId, sessionId: let sessionId):break
    
  case .attemptToJoinSession(sessionId: let sessionId):break
    
  case .weJoinedSessionSuccessfully(sessionId: let sessionId, peers: let peers, currentState: let currentState):break
    
    
  case .sessionStateDidChange(state: let state):break
    
    
  case .sendSyncState(_):break
    
  case .syncStateReceived(_):break
    
    
  case .notAbleToStartBroadcastingAvailability(error: let error): break
  case .notAbleToStartBrowsingForOthers(error: let error): break
  case .errorJoiningSession(_):break
  case .lostPeer(peerId: let peerId):break
    
  }

  return .none
}
