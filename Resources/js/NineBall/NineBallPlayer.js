// Generated by CoffeeScript 1.3.3
(function() {
  var NineBallPlayer;

  NineBallPlayer = function(name, rank, number, teamNumber) {
    this.Name = name;
    this.Rank = rank;
    this.Number = number;
    this.TeamNumber = teamNumber;
    this.BallCount = new NineBallRanks().getBallCount(rank).toString();
    this.Score = 0;
    this.Safeties = 0;
    this.CurrentlyUp = false;
    this.NineOnSnaps = 0;
    this.BreakAndRuns = 0;
    this.TimeoutsTaken = 0;
    this.TimeoutsAllowed = new NineBallRanks().getTimeouts(rank);
    this.IsCaptain = false;
    this.resetPlayerRankStats = function() {
      this.BallCount = new NineBallRanks().getBallCount(this.Rank).toString();
      return this.TimeoutsAllowed = new NineBallRanks().getTimeouts(this.Rank);
    };
    this.addToScore = function(addToScore) {
      return this.Score += addToScore;
    };
    this.addOneToSafeties = function() {
      return this.Safeties += 1;
    };
    this.hasWon = function() {
      return this.Score >= this.BallCount;
    };
    this.addOneToNineOnSnaps = function() {
      return this.NineOnSnaps += 1;
    };
    this.addOneToBreakAndRuns = function() {
      return this.BreakAndRuns += 1;
    };
    this.getRemainingBallCount = function() {
      return (this.BallCount - this.Score).toString();
    };
    this.getFirstNameWithInitials = function() {
      var nameToReturn, spaceIndex;
      spaceIndex = this.Name.indexOf(" ");
      if (spaceIndex === -1) {
        return this.Name;
      }
      nameToReturn = this.Name.substr(0, spaceIndex);
      return nameToReturn + " " + this.Name[spaceIndex + 1] + ".";
    };
    this.getSafeties = function() {
      return this.Safeties.toString();
    };
    this.getScore = function() {
      return this.Score.toString();
    };
    this.getRatioScore = function() {
      return this.Score / this.BallCount;
    };
    this.getNineOnSnaps = function() {
      return this.NineOnSnaps.toString();
    };
    this.getBreakAndRuns = function() {
      return this.BreakAndRuns.toString();
    };
    this.toJSON = function() {
      return {
        Name: this.Name,
        Rank: this.Rank,
        BallCount: this.BallCount,
        Number: this.Number,
        TeamNumber: this.TeamNumber,
        Score: this.Score,
        Safeties: this.Safeties,
        NineOnSnaps: this.NineOnSnaps,
        BreakAndRuns: this.BreakAndRuns,
        CurrentlyUp: this.CurrentlyUp
      };
    };
    return this.fromJSON = function(playerJSON) {
      this.Name = playerJSON.Name;
      this.Rank = playerJSON.Rank;
      this.BallCount = playerJSON.BallCount;
      this.Number = playerJSON.Number;
      this.TeamNumber = playerJSON.TeamNumber;
      this.Score = playerJSON.Score;
      this.Safeties = playerJSON.Safeties;
      this.NineOnSnaps = playerJSON.NineOnSnaps;
      this.BreakAndRuns = playerJSON.BreakAndRuns;
      this.CurrentlyUp = playerJSON.CurrentlyUp;
      return this.resetPlayerRankStats();
    };
  };

}).call(this);
