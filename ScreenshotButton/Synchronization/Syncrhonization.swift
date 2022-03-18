//
// Created by laptop on 3/17/22.
//
import ComposableArchitecture

struct Session: Equatable, Identifiable {
  enum Status: Equatable {
    case idle
    case greetedSession(sessionId: String)
    case invitedToJoin(sessionId: String)
    case attemptingToJoin(sessionId: String)
    case joinFailed(sessionId: String, reason: String)
    
    case active(sessionId: String)
  }
  
  let id: UUID = .init()
  let status: Status = .idle
}

struct SyncrhoniazationState: Equatable, Identifiable {
  let id: UUID
  let session: Session
}

/**
  * TODO: further break this down into
 Joining Session
 and
 Sending Messages
 and
 Disconnecting
 */
enum SyncrhonizationAction: Equatable {
  // MARK: - Before Joining a Session
  
  /* going to right these as human readable as an experiement (see 95 commands otter recording */
  /*👋🇺🇸🇺🇦*/case sayIdLikeToJoinYourSession(sessionId: String)/*(SyncrhonizationAction  ) *//*
                                                                * Session ID will be in sender's state, so don't need to specify as argument
                                                                */
  /*🇺🇦🤝🇺🇸*/case someoneWantsToJoinOurSession(invitingPeerId: String)
  /*🇺🇸🤝🇺🇦*/case someoneWantsUsToJoinTheirSession(invitingPeerId: String)
  /*🗺🤐🔐*/case someoneJoinedOurSession(joinerId: String, sessionId: String/*TODO: - session secret */)
  
  
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
}

struct SynchronizationEnvironment {}

let synchronizationReducer = Reducer<SyncrhonizationAction, SyncrhoniazationState, SynchronizationEnvironment> {state, action, environment in
  
  return .none
  
}
