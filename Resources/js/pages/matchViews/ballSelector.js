// Generated by CoffeeScript 1.3.3
(function() {
  var me;

  me = this;

  this.currentlySelectedBallNumber = null;

  this.ballSelectorGrayImage = Ti.UI.createView({
    backgroundColor: "transparent",
    backgroundImage: "images/match/buttons/overlay.png",
    width: 156,
    height: 148,
    anchorPoint: {
      x: 0,
      y: 0
    },
    isNinePatch: false
  });

  this.ballSelectorGrayImage.visible = false;

  this.ballSelectorGrayImageSmall = Ti.UI.createView({
    backgroundColor: "transparent",
    backgroundImage: "images/match/buttons/overlay-small.png",
    width: 156,
    height: 108,
    anchorPoint: {
      x: 0,
      y: 0
    },
    isNinePatch: false,
    visible: false
  });

  this.ballSelectorScoreItImageForSmall = Ti.UI.createButton({
    backgroundColor: "transparent",
    backgroundImage: "images/match/buttons/overlay-scoreit-add.png",
    top: 6,
    left: 8,
    width: 140,
    height: 36,
    color: "#ffffff",
    shadowColor: "#000000",
    title: "Score It",
    font: {
      fontSize: 16,
      fontWeight: "bold",
      fontFamily: "HelveticaNeue-Bold"
    },
    isNinePatch: false
  });

  this.ballSelectorCancelImageForSmall = Ti.UI.createButton({
    backgroundColor: "transparent",
    backgroundImage: "images/match/buttons/overlay-cancel.png",
    bottom: 23,
    left: 8,
    width: 140,
    height: 36,
    color: "#ffffff",
    shadowColor: "#000000",
    title: "Cancel",
    font: {
      fontSize: 16,
      fontWeight: "bold",
      fontFamily: "HelveticaNeue-Bold"
    },
    isNinePatch: false
  });

  this.ballSelectorScoreItImage = Ti.UI.createButton({
    backgroundColor: "transparent",
    backgroundImage: "images/match/buttons/overlay-scoreit-add.png",
    top: 6,
    left: 8,
    width: 140,
    height: 36,
    color: "#ffffff",
    shadowColor: "#000000",
    title: "Score It",
    font: {
      fontSize: 16,
      fontWeight: "bold",
      fontFamily: "HelveticaNeue-Bold"
    },
    isNinePatch: false
  });

  this.ballSelectorDeadBallImage = Ti.UI.createButton({
    backgroundColor: "transparent",
    backgroundImage: "images/match/buttons/overlay-deadball-add.png",
    bottom: 66,
    left: 8,
    width: 140,
    height: 36,
    color: "#ffffff",
    shadowColor: "#000000",
    title: (this.leagueMatch.GameType === "NineBall" ? "Dead Ball" : "Scratch"),
    font: {
      fontSize: 16,
      fontWeight: "bold",
      fontFamily: "HelveticaNeue-Bold"
    },
    isNinePatch: false
  });

  this.ballSelectorCancelImage = Ti.UI.createButton({
    backgroundColor: "transparent",
    backgroundImage: "images/match/buttons/overlay-cancel.png",
    bottom: 23,
    left: 8,
    width: 140,
    height: 36,
    color: "#ffffff",
    shadowColor: "#000000",
    title: "Cancel",
    font: {
      fontSize: 16,
      fontWeight: "bold",
      fontFamily: "HelveticaNeue-Bold"
    },
    isNinePatch: false
  });

  this.ballSelectorDeadBallImage.visible = true;

  this.showEightBallSelector = function(centerTop, centerWidth, ballNumber) {
    var eightShowingTransformation, eightTransformation, t2;
    if (this.currentlySelectedBallNumber !== 8) {
      if (this.ballSelectorGrayImageSmall.visible === true) {
        eightShowingTransformation = Ti.UI.create2DMatrix().setFillBefore(true).translate(centerWidth - 80 - this.ballSelectorGrayImageSmall.left, centerTop - 100 - this.ballSelectorGrayImageSmall.top);
        return this.ballSelectorGrayImageSmall.animate({
          opacity: 1,
          transform: eightShowingTransformation,
          duration: 300
        }, function() {
          if (Ti.Platform.name === "android") {
            me.ballSelectorGrayImageSmall.left = centerWidth - 80;
            return me.ballSelectorGrayImageSmall.top = centerTop - 100;
          }
        });
      } else {
        this.ballSelectorGrayImageSmall.left = centerWidth - 80;
        this.ballSelectorGrayImageSmall.top = centerTop - 100;
        this.ballSelectorGrayImageSmall.visible = true;
        if (Ti.Platform.name !== "android") {
          this.ballSelectorGrayImageSmall.opacity = 0;
        } else {
          this.ballSelectorGrayImageSmall.visible = true;
        }
        eightTransformation = Ti.UI.create2DMatrix().setFillBefore(true).translate((centerWidth - 80) - this.ballSelectorGrayImageSmall.left, (centerTop - 100) - this.ballSelectorGrayImageSmall.top);
        return this.ballSelectorGrayImageSmall.animate({
          opacity: 1,
          transform: eightTransformation,
          duration: 300
        }, function() {
          if (Ti.Platform.name !== "android") {
            me.ballSelectorGrayImageSmall.visible = true;
            return me.ballSelectorGrayImageSmall.opacity = 1;
          } else {
            me.ballSelectorGrayImageSmall.left = centerWidth - 80;
            return me.ballSelectorGrayImageSmall.top = centerTop - 100;
          }
        });
      }
    } else {
      this.closeSmallOverlay();
      this.ballSelectorContainer.visible = true;
      this.ballSelectorGrayImage.left = centerWidth - 80;
      this.ballSelectorGrayImage.top = centerTop - 140;
      if (Ti.Platform.name !== "android") {
        this.ballSelectorGrayImage.opacity = 0;
      } else {
        this.ballSelectorGrayImage.visible = true;
      }
      t2 = Ti.UI.create2DMatrix().setFillBefore(true).translate((centerWidth - 80) - this.ballSelectorGrayImage.left, (centerTop - 140) - this.ballSelectorGrayImage.top);
      this.ballSelectorGrayImage.animate({
        opacity: 1,
        transform: t2,
        duration: 300
      }, function() {
        if (Ti.Platform.name === "android") {
          me.ballSelectorGrayImage.left = centerWidth - 80;
          return me.ballSelectorGrayImage.top = centerTop - 140;
        }
      });
      if (Ti.Platform.name !== "android") {
        return this.ballSelectorGrayImage.visible = true;
      }
    }
  };

  this.showNineBallSelector = function(centerTop, centerWidth, ballNumber) {
    var t, t2;
    if (this.currentlySelectedBallNumber === 9) {
      this.closeOverlay();
      this.ballSelectorContainer.visible = true;
      this.ballSelectorGrayImageSmall.left = centerWidth - 80;
      this.ballSelectorGrayImageSmall.top = centerTop - 100;
      if (this.ballSelectorGrayImageSmall.visible === false) {
        this.ballSelectorGrayImageSmall.visible = true;
        if (Ti.Platform.name !== "android") {
          this.ballSelectorGrayImageSmall.opacity = 0;
        }
        return this.ballSelectorGrayImageSmall.animate({
          opacity: 1,
          duration: 300
        }, function() {
          if (Ti.Platform.name !== "android") {
            me.ballSelectorGrayImageSmall.visible = true;
            return me.ballSelectorGrayImageSmall.opacity = 1;
          }
        });
      }
    } else {
      if (this.ballSelectorGrayImage.visible === true) {
        t = Ti.UI.create2DMatrix().setFillBefore(true).translate((centerWidth - 80) - this.ballSelectorGrayImage.left, (centerTop - 140) - this.ballSelectorGrayImage.top);
        this.ballSelectorGrayImage.animate({
          opacity: 1,
          transform: t,
          duration: 300
        }, function() {
          if (Ti.Platform.name === "android") {
            me.ballSelectorGrayImage.left = centerWidth - 80;
            return me.ballSelectorGrayImage.top = centerTop - 140;
          }
        });
      } else {
        this.closeSmallOverlay();
        this.ballSelectorContainer.visible = true;
        this.ballSelectorGrayImage.left = centerWidth - 80;
        this.ballSelectorGrayImage.top = centerTop - 140;
        if (Ti.Platform.name !== "android") {
          this.ballSelectorGrayImage.opacity = 0;
        } else {
          this.ballSelectorGrayImage.visible = true;
        }
        t2 = Ti.UI.create2DMatrix().setFillBefore(true).translate((centerWidth - 80) - this.ballSelectorGrayImage.left, (centerTop - 140) - this.ballSelectorGrayImage.top);
        this.ballSelectorGrayImage.animate({
          opacity: 1,
          transform: t2,
          duration: 300
        }, function() {
          if (Ti.Platform.name === "android") {
            me.ballSelectorGrayImage.left = centerWidth - 80;
            return me.ballSelectorGrayImage.top = centerTop - 140;
          }
        });
      }
      if (Ti.Platform.name !== "android") {
        return this.ballSelectorGrayImage.visible = true;
      }
    }
  };

  this.centerBallSelector = function(centerTop, centerWidth, ballNumber) {
    this.currentlySelectedBallNumber = ballNumber;
    this.ballSelectorContainer.visible = true;
    if (this.leagueMatch.GameType === "EightBall") {
      return this.showEightBallSelector(centerTop, centerWidth, ballNumber);
    } else {
      if (this.leagueMatch.GameType === "NineBall") {
        return this.showNineBallSelector(centerTop, centerWidth, ballNumber);
      }
    }
  };

  this.closeOverlay = function() {
    if (me.ballSelectorGrayImage.visible === true) {
      me.ballSelectorGrayImage.animate({
        opacity: 0,
        duration: 300
      }, function() {
        return me.ballSelectorGrayImage.visible = false;
      });
    }
    return me.ballSelectorContainer.visible = false;
  };

  this.closeSmallOverlay = function() {
    if (me.ballSelectorGrayImageSmall.visible === true) {
      return me.ballSelectorGrayImageSmall.animate({
        opacity: 0,
        duration: 300
      }, function() {
        return me.ballSelectorGrayImageSmall.visible = false;
      });
    }
  };

  this.showScoreIt = function(turnOn) {
    me.ballSelectorScoreItImage.visible = turnOn;
    return me.ballSelectorGrayImage.visible = !turnOn;
  };

  this.showDeadBall = function(turnOn) {
    me.ballSelectorDeadBallImage.visible = turnOn;
    return me.ballSelectorGrayImage.visible = !turnOn;
  };

  this.scoreItClick = function() {
    me.closeOverlay();
    me.closeSmallOverlay();
    me.currentMatch.scoreNumberedBall(me.currentlySelectedBallNumber);
    return me.saveAndUpdateUI();
  };

  this.ballSelectorScoreItImageForSmall.addEventListener("click", this.scoreItClick);

  this.ballSelectorCancelImageForSmall.addEventListener("click", function() {
    return me.closeSmallOverlay();
  });

  this.ballSelectorScoreItImage.addEventListener("click", this.scoreItClick);

  this.ballSelectorDeadBallImage.addEventListener("click", function() {
    me.closeOverlay();
    me.closeSmallOverlay();
    if (me.leagueMatch.GameType === "NineBall") {
      me.currentMatch.hitDeadBall(me.currentlySelectedBallNumber);
    } else {
      if (me.leagueMatch.GameType === "EightBall") {
        me.currentMatch.CurrentGame.hitScratchOnEight();
      }
    }
    return me.saveAndUpdateUI();
  });

  this.ballSelectorCancelImage.addEventListener("click", this.closeOverlay);

  this.ballSelectorGrayImage.add(this.ballSelectorScoreItImage);

  this.ballSelectorGrayImage.add(this.ballSelectorDeadBallImage);

  this.ballSelectorGrayImage.add(this.ballSelectorCancelImage);

  this.ballSelectorGrayImageSmall.add(this.ballSelectorScoreItImageForSmall);

  this.ballSelectorGrayImageSmall.add(this.ballSelectorCancelImageForSmall);

  this.view.add(this.ballSelectorGrayImage);

  this.view.add(this.ballSelectorGrayImageSmall);

}).call(this);
