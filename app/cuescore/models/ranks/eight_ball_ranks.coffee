class EightBall extends $CS.Models.Rank
  defaults:
    games_to_win: []

  initialize: () ->
    _.extend @, @defaults
    @setRanks()
    
  # Getters
    
  getGamesNeedToWin: (myRank, opponentRank) ->
    if myRank > 1 and myRank < 8 and opponentRank > 1 and opponentRank < 8
      gamesNeeded = @games_to_win[myRank][opponentRank]
      return gamesNeeded
    0

  getTimeouts: (rank) ->
    if rank < 4
      return 2
    else return 1  if rank >= 4 and rank <= 9
    0
    
  # Setters
  
  setRanks: () ->
    @games_to_win[2] = []
    @games_to_win[2][2] = 2
    @games_to_win[2][3] = 2
    @games_to_win[2][4] = 2
    @games_to_win[2][5] = 2
    @games_to_win[2][6] = 2
    @games_to_win[2][7] = 2
    @games_to_win[3] = []
    @games_to_win[3][2] = 3
    @games_to_win[3][3] = 2
    @games_to_win[3][4] = 2
    @games_to_win[3][5] = 2
    @games_to_win[3][6] = 2
    @games_to_win[3][7] = 2
    @games_to_win[4] = []
    @games_to_win[4][2] = 4
    @games_to_win[4][3] = 3
    @games_to_win[4][4] = 3
    @games_to_win[4][5] = 3
    @games_to_win[4][6] = 3
    @games_to_win[4][7] = 2
    @games_to_win[5] = []
    @games_to_win[5][2] = 5
    @games_to_win[5][3] = 4
    @games_to_win[5][4] = 4
    @games_to_win[5][5] = 4
    @games_to_win[5][6] = 4
    @games_to_win[5][7] = 3
    @games_to_win[6] = []
    @games_to_win[6][2] = 6
    @games_to_win[6][3] = 5
    @games_to_win[6][4] = 5
    @games_to_win[6][5] = 5
    @games_to_win[6][6] = 5
    @games_to_win[6][7] = 4
    @games_to_win[7] = []
    @games_to_win[7][2] = 7
    @games_to_win[7][3] = 6
    @games_to_win[7][4] = 5
    @games_to_win[7][5] = 5
    @games_to_win[7][6] = 5
    @games_to_win[7][7] = 5

$CS.Models.Rank.EightBall = EightBall
