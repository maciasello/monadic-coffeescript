monadic promiseM
  {userId, userName} <-- getUser()
  {sessions: [activeSession]} <-- getUserStats userId, userName
  validate mostRecentlyActiveSession
