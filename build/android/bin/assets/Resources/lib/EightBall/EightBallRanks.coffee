EightBallRanks = ->
  @gamesToWin = []
  @getGamesNeedToWin = (myRank, opponentRank) ->
    if myRank > 1 and myRank < 8 and opponentRank > 1 and opponentRank < 8
      gamesNeeded = @gamesToWin[myRank][opponentRank]
      return gamesNeeded
    0

  @getTimeouts = (rank) ->
    if rank < 4
      return 2
    else return 1  if rank >= 4 and rank <= 9
    0

  @gamesToWin[2] = []
  @gamesToWin[2][2] = 2
  @gamesToWin[2][3] = 2
  @gamesToWin[2][4] = 2
  @gamesToWin[2][5] = 2
  @gamesToWin[2][6] = 2
  @gamesToWin[2][7] = 2
  @gamesToWin[3] = []
  @gamesToWin[3][2] = 3
  @gamesToWin[3][3] = 2
  @gamesToWin[3][4] = 2
  @gamesToWin[3][5] = 2
  @gamesToWin[3][6] = 2
  @gamesToWin[3][7] = 2
  @gamesToWin[4] = []
  @gamesToWin[4][2] = 4
  @gamesToWin[4][3] = 3
  @gamesToWin[4][4] = 3
  @gamesToWin[4][5] = 3
  @gamesToWin[4][6] = 3
  @gamesToWin[4][7] = 2
  @gamesToWin[5] = []
  @gamesToWin[5][2] = 5
  @gamesToWin[5][3] = 4
  @gamesToWin[5][4] = 4
  @gamesToWin[5][5] = 4
  @gamesToWin[5][6] = 4
  @gamesToWin[5][7] = 3
  @gamesToWin[6] = []
  @gamesToWin[6][2] = 6
  @gamesToWin[6][3] = 5
  @gamesToWin[6][4] = 5
  @gamesToWin[6][5] = 5
  @gamesToWin[6][6] = 5
  @gamesToWin[6][7] = 4
  @gamesToWin[7] = []
  @gamesToWin[7][2] = 7
  @gamesToWin[7][3] = 6
  @gamesToWin[7][4] = 5
  @gamesToWin[7][5] = 5
  @gamesToWin[7][6] = 5
  @gamesToWin[7][7] = 5