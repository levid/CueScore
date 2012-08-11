class NineBall extends $CS.Models.Rank
  defaults:
    ball_counts:
      1: 14
      2: 19
      3: 25
      4: 31
      5: 38
      6: 46
      7: 55
      8: 65
      9: 75

  initialize: () ->
    @losersMatchPoints = []
    @losersMatchPoints[1] = []
    @losersMatchPoints[1][0] = 0
    @losersMatchPoints[1][1] = 0
    @losersMatchPoints[1][2] = 0
    @losersMatchPoints[1][3] = 1
    @losersMatchPoints[1][4] = 2
    @losersMatchPoints[1][5] = 3
    @losersMatchPoints[1][6] = 3
    @losersMatchPoints[1][7] = 4
    @losersMatchPoints[1][8] = 5
    @losersMatchPoints[1][9] = 6
    @losersMatchPoints[1][10] = 6
    @losersMatchPoints[1][11] = 7
    @losersMatchPoints[1][12] = 8
    @losersMatchPoints[1][13] = 8
    @losersMatchPoints[2] = []
    @losersMatchPoints[2][0] = 0
    @losersMatchPoints[2][1] = 0
    @losersMatchPoints[2][2] = 0
    @losersMatchPoints[2][3] = 0
    @losersMatchPoints[2][4] = 1
    @losersMatchPoints[2][5] = 1
    @losersMatchPoints[2][6] = 2
    @losersMatchPoints[2][7] = 2
    @losersMatchPoints[2][8] = 3
    @losersMatchPoints[2][9] = 4
    @losersMatchPoints[2][10] = 4
    @losersMatchPoints[2][11] = 5
    @losersMatchPoints[2][12] = 5
    @losersMatchPoints[2][13] = 6
    @losersMatchPoints[2][14] = 6
    @losersMatchPoints[2][15] = 7
    @losersMatchPoints[2][16] = 7
    @losersMatchPoints[2][17] = 8
    @losersMatchPoints[2][18] = 8
    @losersMatchPoints[3] = []
    @losersMatchPoints[3][0] = 0
    @losersMatchPoints[3][1] = 0
    @losersMatchPoints[3][2] = 0
    @losersMatchPoints[3][3] = 0
    @losersMatchPoints[3][4] = 0
    @losersMatchPoints[3][5] = 1
    @losersMatchPoints[3][6] = 1
    @losersMatchPoints[3][7] = 2
    @losersMatchPoints[3][8] = 2
    @losersMatchPoints[3][9] = 2
    @losersMatchPoints[3][10] = 3
    @losersMatchPoints[3][11] = 3
    @losersMatchPoints[3][12] = 4
    @losersMatchPoints[3][13] = 4
    @losersMatchPoints[3][14] = 4
    @losersMatchPoints[3][15] = 5
    @losersMatchPoints[3][16] = 5
    @losersMatchPoints[3][17] = 6
    @losersMatchPoints[3][18] = 6
    @losersMatchPoints[3][19] = 6
    @losersMatchPoints[3][20] = 7
    @losersMatchPoints[3][21] = 7
    @losersMatchPoints[3][22] = 8
    @losersMatchPoints[3][23] = 8
    @losersMatchPoints[3][24] = 8
    @losersMatchPoints[4] = []
    @losersMatchPoints[4][0] = 0
    @losersMatchPoints[4][1] = 0
    @losersMatchPoints[4][2] = 0
    @losersMatchPoints[4][3] = 0
    @losersMatchPoints[4][4] = 0
    @losersMatchPoints[4][5] = 0
    @losersMatchPoints[4][6] = 1
    @losersMatchPoints[4][7] = 1
    @losersMatchPoints[4][8] = 1
    @losersMatchPoints[4][9] = 2
    @losersMatchPoints[4][10] = 2
    @losersMatchPoints[4][11] = 2
    @losersMatchPoints[4][12] = 3
    @losersMatchPoints[4][13] = 3
    @losersMatchPoints[4][14] = 3
    @losersMatchPoints[4][15] = 4
    @losersMatchPoints[4][16] = 4
    @losersMatchPoints[4][17] = 4
    @losersMatchPoints[4][18] = 4
    @losersMatchPoints[4][19] = 5
    @losersMatchPoints[4][20] = 5
    @losersMatchPoints[4][21] = 5
    @losersMatchPoints[4][22] = 6
    @losersMatchPoints[4][23] = 6
    @losersMatchPoints[4][24] = 6
    @losersMatchPoints[4][25] = 7
    @losersMatchPoints[4][26] = 7
    @losersMatchPoints[4][27] = 7
    @losersMatchPoints[4][28] = 8
    @losersMatchPoints[4][29] = 8
    @losersMatchPoints[4][30] = 8
    @losersMatchPoints[5] = []
    @losersMatchPoints[5][0] = 0
    @losersMatchPoints[5][1] = 0
    @losersMatchPoints[5][2] = 0
    @losersMatchPoints[5][3] = 0
    @losersMatchPoints[5][4] = 0
    @losersMatchPoints[5][5] = 0
    @losersMatchPoints[5][6] = 0
    @losersMatchPoints[5][7] = 1
    @losersMatchPoints[5][8] = 1
    @losersMatchPoints[5][9] = 1
    @losersMatchPoints[5][10] = 1
    @losersMatchPoints[5][11] = 2
    @losersMatchPoints[5][12] = 2
    @losersMatchPoints[5][13] = 2
    @losersMatchPoints[5][14] = 2
    @losersMatchPoints[5][15] = 3
    @losersMatchPoints[5][16] = 3
    @losersMatchPoints[5][17] = 3
    @losersMatchPoints[5][18] = 3
    @losersMatchPoints[5][19] = 4
    @losersMatchPoints[5][20] = 4
    @losersMatchPoints[5][21] = 4
    @losersMatchPoints[5][22] = 4
    @losersMatchPoints[5][23] = 5
    @losersMatchPoints[5][24] = 5
    @losersMatchPoints[5][25] = 5
    @losersMatchPoints[5][26] = 5
    @losersMatchPoints[5][27] = 6
    @losersMatchPoints[5][28] = 6
    @losersMatchPoints[5][29] = 6
    @losersMatchPoints[5][30] = 7
    @losersMatchPoints[5][31] = 7
    @losersMatchPoints[5][32] = 7
    @losersMatchPoints[5][33] = 7
    @losersMatchPoints[5][34] = 8
    @losersMatchPoints[5][35] = 8
    @losersMatchPoints[5][36] = 8
    @losersMatchPoints[5][37] = 8
    @losersMatchPoints[6] = []
    @losersMatchPoints[6][0] = 0
    @losersMatchPoints[6][1] = 0
    @losersMatchPoints[6][2] = 0
    @losersMatchPoints[6][3] = 0
    @losersMatchPoints[6][4] = 0
    @losersMatchPoints[6][5] = 0
    @losersMatchPoints[6][6] = 0
    @losersMatchPoints[6][7] = 0
    @losersMatchPoints[6][8] = 0
    @losersMatchPoints[6][9] = 1
    @losersMatchPoints[6][10] = 1
    @losersMatchPoints[6][11] = 1
    @losersMatchPoints[6][12] = 1
    @losersMatchPoints[6][13] = 2
    @losersMatchPoints[6][14] = 2
    @losersMatchPoints[6][15] = 2
    @losersMatchPoints[6][16] = 2
    @losersMatchPoints[6][17] = 2
    @losersMatchPoints[6][18] = 3
    @losersMatchPoints[6][19] = 3
    @losersMatchPoints[6][20] = 3
    @losersMatchPoints[6][21] = 3
    @losersMatchPoints[6][22] = 3
    @losersMatchPoints[6][23] = 4
    @losersMatchPoints[6][24] = 4
    @losersMatchPoints[6][25] = 4
    @losersMatchPoints[6][26] = 4
    @losersMatchPoints[6][27] = 4
    @losersMatchPoints[6][28] = 5
    @losersMatchPoints[6][29] = 5
    @losersMatchPoints[6][30] = 5
    @losersMatchPoints[6][31] = 5
    @losersMatchPoints[6][32] = 6
    @losersMatchPoints[6][33] = 6
    @losersMatchPoints[6][34] = 6
    @losersMatchPoints[6][35] = 6
    @losersMatchPoints[6][36] = 6
    @losersMatchPoints[6][37] = 7
    @losersMatchPoints[6][38] = 7
    @losersMatchPoints[6][39] = 7
    @losersMatchPoints[6][40] = 7
    @losersMatchPoints[6][41] = 8
    @losersMatchPoints[6][42] = 8
    @losersMatchPoints[6][43] = 8
    @losersMatchPoints[6][44] = 8
    @losersMatchPoints[6][45] = 8
    @losersMatchPoints[7] = []
    @losersMatchPoints[7][0] = 0
    @losersMatchPoints[7][1] = 0
    @losersMatchPoints[7][2] = 0
    @losersMatchPoints[7][3] = 0
    @losersMatchPoints[7][4] = 0
    @losersMatchPoints[7][5] = 0
    @losersMatchPoints[7][6] = 0
    @losersMatchPoints[7][7] = 0
    @losersMatchPoints[7][8] = 0
    @losersMatchPoints[7][9] = 0
    @losersMatchPoints[7][10] = 0
    @losersMatchPoints[7][11] = 1
    @losersMatchPoints[7][12] = 1
    @losersMatchPoints[7][13] = 1
    @losersMatchPoints[7][14] = 1
    @losersMatchPoints[7][15] = 1
    @losersMatchPoints[7][16] = 2
    @losersMatchPoints[7][17] = 2
    @losersMatchPoints[7][18] = 2
    @losersMatchPoints[7][19] = 2
    @losersMatchPoints[7][20] = 2
    @losersMatchPoints[7][21] = 2
    @losersMatchPoints[7][22] = 3
    @losersMatchPoints[7][23] = 3
    @losersMatchPoints[7][24] = 3
    @losersMatchPoints[7][25] = 3
    @losersMatchPoints[7][26] = 3
    @losersMatchPoints[7][27] = 4
    @losersMatchPoints[7][28] = 4
    @losersMatchPoints[7][29] = 4
    @losersMatchPoints[7][30] = 4
    @losersMatchPoints[7][31] = 4
    @losersMatchPoints[7][32] = 4
    @losersMatchPoints[7][33] = 5
    @losersMatchPoints[7][34] = 5
    @losersMatchPoints[7][35] = 5
    @losersMatchPoints[7][36] = 5
    @losersMatchPoints[7][37] = 5
    @losersMatchPoints[7][38] = 6
    @losersMatchPoints[7][39] = 6
    @losersMatchPoints[7][40] = 6
    @losersMatchPoints[7][41] = 6
    @losersMatchPoints[7][42] = 6
    @losersMatchPoints[7][43] = 6
    @losersMatchPoints[7][44] = 7
    @losersMatchPoints[7][45] = 7
    @losersMatchPoints[7][46] = 7
    @losersMatchPoints[7][47] = 7
    @losersMatchPoints[7][48] = 7
    @losersMatchPoints[7][49] = 7
    @losersMatchPoints[7][50] = 8
    @losersMatchPoints[7][51] = 8
    @losersMatchPoints[7][52] = 8
    @losersMatchPoints[7][53] = 8
    @losersMatchPoints[7][54] = 8
    @losersMatchPoints[8] = []
    @losersMatchPoints[8][0] = 0
    @losersMatchPoints[8][1] = 0
    @losersMatchPoints[8][2] = 0
    @losersMatchPoints[8][3] = 0
    @losersMatchPoints[8][4] = 0
    @losersMatchPoints[8][5] = 0
    @losersMatchPoints[8][6] = 0
    @losersMatchPoints[8][7] = 0
    @losersMatchPoints[8][8] = 0
    @losersMatchPoints[8][9] = 0
    @losersMatchPoints[8][10] = 0
    @losersMatchPoints[8][11] = 0
    @losersMatchPoints[8][12] = 0
    @losersMatchPoints[8][13] = 0
    @losersMatchPoints[8][14] = 1
    @losersMatchPoints[8][15] = 1
    @losersMatchPoints[8][16] = 1
    @losersMatchPoints[8][17] = 1
    @losersMatchPoints[8][18] = 1
    @losersMatchPoints[8][19] = 1
    @losersMatchPoints[8][20] = 2
    @losersMatchPoints[8][21] = 2
    @losersMatchPoints[8][22] = 2
    @losersMatchPoints[8][23] = 2
    @losersMatchPoints[8][24] = 2
    @losersMatchPoints[8][25] = 2
    @losersMatchPoints[8][26] = 2
    @losersMatchPoints[8][27] = 3
    @losersMatchPoints[8][28] = 3
    @losersMatchPoints[8][29] = 3
    @losersMatchPoints[8][30] = 3
    @losersMatchPoints[8][31] = 3
    @losersMatchPoints[8][32] = 3
    @losersMatchPoints[8][33] = 4
    @losersMatchPoints[8][34] = 4
    @losersMatchPoints[8][35] = 4
    @losersMatchPoints[8][36] = 4
    @losersMatchPoints[8][37] = 4
    @losersMatchPoints[8][38] = 4
    @losersMatchPoints[8][39] = 4
    @losersMatchPoints[8][40] = 5
    @losersMatchPoints[8][41] = 5
    @losersMatchPoints[8][42] = 5
    @losersMatchPoints[8][43] = 5
    @losersMatchPoints[8][44] = 5
    @losersMatchPoints[8][45] = 5
    @losersMatchPoints[8][46] = 6
    @losersMatchPoints[8][47] = 6
    @losersMatchPoints[8][48] = 6
    @losersMatchPoints[8][49] = 6
    @losersMatchPoints[8][50] = 6
    @losersMatchPoints[8][51] = 6
    @losersMatchPoints[8][52] = 6
    @losersMatchPoints[8][53] = 7
    @losersMatchPoints[8][54] = 7
    @losersMatchPoints[8][55] = 7
    @losersMatchPoints[8][56] = 7
    @losersMatchPoints[8][57] = 7
    @losersMatchPoints[8][58] = 7
    @losersMatchPoints[8][59] = 8
    @losersMatchPoints[8][60] = 8
    @losersMatchPoints[8][61] = 8
    @losersMatchPoints[8][62] = 8
    @losersMatchPoints[8][63] = 8
    @losersMatchPoints[8][64] = 8
    @losersMatchPoints[9] = []
    @losersMatchPoints[9][0] = 0
    @losersMatchPoints[9][1] = 0
    @losersMatchPoints[9][2] = 0
    @losersMatchPoints[9][3] = 0
    @losersMatchPoints[9][4] = 0
    @losersMatchPoints[9][5] = 0
    @losersMatchPoints[9][6] = 0
    @losersMatchPoints[9][7] = 0
    @losersMatchPoints[9][8] = 0
    @losersMatchPoints[9][9] = 0
    @losersMatchPoints[9][10] = 0
    @losersMatchPoints[9][11] = 0
    @losersMatchPoints[9][12] = 0
    @losersMatchPoints[9][13] = 0
    @losersMatchPoints[9][14] = 0
    @losersMatchPoints[9][15] = 0
    @losersMatchPoints[9][16] = 0
    @losersMatchPoints[9][17] = 0
    @losersMatchPoints[9][18] = 0
    @losersMatchPoints[9][19] = 1
    @losersMatchPoints[9][20] = 1
    @losersMatchPoints[9][21] = 1
    @losersMatchPoints[9][22] = 1
    @losersMatchPoints[9][23] = 1
    @losersMatchPoints[9][24] = 1
    @losersMatchPoints[9][25] = 2
    @losersMatchPoints[9][26] = 2
    @losersMatchPoints[9][27] = 2
    @losersMatchPoints[9][28] = 2
    @losersMatchPoints[9][29] = 2
    @losersMatchPoints[9][30] = 2
    @losersMatchPoints[9][31] = 2
    @losersMatchPoints[9][32] = 3
    @losersMatchPoints[9][33] = 3
    @losersMatchPoints[9][34] = 3
    @losersMatchPoints[9][35] = 3
    @losersMatchPoints[9][36] = 3
    @losersMatchPoints[9][37] = 3
    @losersMatchPoints[9][38] = 3
    @losersMatchPoints[9][39] = 4
    @losersMatchPoints[9][40] = 4
    @losersMatchPoints[9][41] = 4
    @losersMatchPoints[9][42] = 4
    @losersMatchPoints[9][43] = 4
    @losersMatchPoints[9][44] = 4
    @losersMatchPoints[9][45] = 4
    @losersMatchPoints[9][46] = 4
    @losersMatchPoints[9][47] = 5
    @losersMatchPoints[9][48] = 5
    @losersMatchPoints[9][49] = 5
    @losersMatchPoints[9][50] = 5
    @losersMatchPoints[9][51] = 5
    @losersMatchPoints[9][52] = 5
    @losersMatchPoints[9][53] = 5
    @losersMatchPoints[9][54] = 6
    @losersMatchPoints[9][55] = 6
    @losersMatchPoints[9][56] = 6
    @losersMatchPoints[9][57] = 6
    @losersMatchPoints[9][58] = 6
    @losersMatchPoints[9][59] = 6
    @losersMatchPoints[9][60] = 6
    @losersMatchPoints[9][61] = 7
    @losersMatchPoints[9][62] = 7
    @losersMatchPoints[9][63] = 7
    @losersMatchPoints[9][64] = 7
    @losersMatchPoints[9][65] = 7
    @losersMatchPoints[9][66] = 7
    @losersMatchPoints[9][67] = 7
    @losersMatchPoints[9][68] = 8
    @losersMatchPoints[9][69] = 8
    @losersMatchPoints[9][70] = 8
    @losersMatchPoints[9][71] = 8
    @losersMatchPoints[9][72] = 8
    @losersMatchPoints[9][73] = 8
    @losersMatchPoints[9][74] = 8
    
  getBallCount: (rank) ->
    parseInt @ball_counts[rank], 10

  getLosingPlayersMatchPoints: (loserRank, loserScore) ->
    losingMatchPoints = @losersMatchPoints[loserRank][loserScore]
    losingMatchPoints

  getWinningPlayersMatchPoints: (loserRank, loserScore) ->
    losingMatchPoints = @losersMatchPoints[loserRank][loserScore]
    winningMatchPoints = 20 - @losersMatchPoints[loserRank][loserScore]
    winningMatchPoints

  getTimeouts: (rank) ->
    if rank < 4
      return 2
    else return 1 if rank >= 4 and rank <= 9
    0 

$CS.Models.Rank.NineBall = NineBall
