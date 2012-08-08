me = this
@ballCategorySelectorContainer = Ti.UI.createImageView(
  backgroundImage: "images/match/layout/bg-endgame.png"
  backgroundColor: "transparent"
  top: 44
  left: 0
  height: (getPlatformHeight() - 44)
  width: getPlatformWidth()
)
@ballCategorySelectorContainer.visible = false
@view.add @ballCategorySelectorContainer
@ballCategorySelector = Ti.UI.createView(
  backgroundImage: "images/match/8ball/layout/bg-select-suit.png"
  height: 280
  width: 275
  top: 88
)
@ballCategorySelector.visible = false
@ballCategorySelectorPlayerName = Ti.UI.createLabel(
  text: ""
  color: "#afd5f1"
  top: 6
  left: 0
  height: 20
  width: 275
  textAlign: "center"
  font:
    fontSize: 14
    fontWeight: "bold"
    fontFamily: "HelveticaNeue-Bold"
)
@ballCategorySelector.add @ballCategorySelectorPlayerName
@ballCategoryButtonContainer = Ti.UI.createView(
  backgroundColor: "transparent"
  top: 55
  left: 9
  height: 126
  width: 257
)
@solidCategoryButton = Ti.UI.createImageView(
  backgroundImage: "images/match/layout/bg_play_gamebutton.png"
  backgroundColor: "transparent"
  top: 0
  left: 0
  height: 126
  width: 124
)
@solidCategoryButtonActive = Ti.UI.createView(
  backgroundImage: "images/match/layout/bg_play_gamebutton_active.png"
  backgroundColor: "transparent"
  top: 0
  left: 0
  height: 126
  width: 124
)
@solidCategoryButtonActive.visible = false
@solidCategoryButtonIcon = Ti.UI.createImageView(
  backgroundImage: "images/match/icons/icon_gamebutton_8ball.png"
  backgroundColor: "transparent"
  top: 5
  left: 21
  height: 88
  width: 88
)
@solidCategoryButtonLabel = Ti.UI.createLabel(
  text: "Solids"
  backgroundColor: "transparent"
  top: 93
  left: 3
  height: 25
  width: 124
  textAlign: "center"
  color: "#ffffff"
  font:
    fontSize: 20
    fontWeight: "bold"
    fontFamily: "HelveticaNeue-Bold"
)
@solidCategoryClick = ->
  if me.solidCategoryButtonActive.visible is false
    me.solidCategoryButtonActive.visible = true
    me.solidCategoryButton.visible = false
    me.stripeCategoryButtonActive.visible = false
    me.stripeCategoryButton.visible = true

@solidCategoryButtonIcon.addEventListener "click", @solidCategoryClick
@solidCategoryButton.addEventListener "click", @solidCategoryClick
@ballCategoryButtonContainer.add @solidCategoryButtonActive
@ballCategoryButtonContainer.add @solidCategoryButton
@ballCategoryButtonContainer.add @solidCategoryButtonIcon
@ballCategoryButtonContainer.add @solidCategoryButtonLabel
@stripeCategoryButton = Ti.UI.createImageView(
  backgroundImage: "images/match/layout/bg_play_gamebutton.png"
  backgroundColor: "transparent"
  top: 0
  left: 132
  height: 126
  width: 124
)
@stripeCategoryButton.visible = true
@stripeCategoryButtonActive = Ti.UI.createView(
  backgroundImage: "images/match/layout/bg_play_gamebutton_active.png"
  backgroundColor: "transparent"
  top: 0
  left: 132
  height: 126
  width: 124
)
@stripeCategoryButtonActive.visible = false
@stripeCategoryButtonIcon = Ti.UI.createView(
  backgroundImage: "images/match/icons/icon_gamebutton_9ball.png"
  backgroundColor: "transparent"
  top: 5
  left: 152
  height: 88
  width: 88
)
@stripeCategoryButtonLabel = Ti.UI.createLabel(
  text: "Stripes"
  backgroundColor: "transparent"
  top: 93
  left: 134
  height: 25
  width: 124
  color: "#ffffff"
  textAlign: "center"
  font:
    fontSize: 20
    fontWeight: "bold"
    fontFamily: "HelveticaNeue-Bold"
)
@stripeCategoryClick = ->
  if me.stripeCategoryButtonActive.visible is false
    me.solidCategoryButtonActive.visible = false
    me.solidCategoryButton.visible = true
    me.stripeCategoryButtonActive.visible = true
    me.stripeCategoryButton.visible = false

@stripeCategoryButton.addEventListener "click", @stripeCategoryClick
@stripeCategoryButtonIcon.addEventListener "click", @stripeCategoryClick
@ballCategoryButtonContainer.add @stripeCategoryButtonActive
@ballCategoryButtonContainer.add @stripeCategoryButton
@ballCategoryButtonContainer.add @stripeCategoryButtonIcon
@ballCategoryButtonContainer.add @stripeCategoryButtonLabel
@ballCategorySelector.add @ballCategoryButtonContainer
@ballCategoryContinueButton = Ti.UI.createImageView(
  backgroundImage: "images/match/8ball/buttons/btn-selectandcontinue.png"
  backgroundColor: "transparent"
  top: 187
  left: 10
  height: 35
  width: 254
)
@ballCategoryCancelButton = Ti.UI.createImageView(
  backgroundImage: "images/match/8ball/buttons/btn-cancel.png"
  backgroundColor: "transparent"
  top: 229
  left: 10
  height: 35
  width: 254
)
@ballCategoryContinueButton.addEventListener "click", ->
  if me.stripeCategoryButtonActive.visible is true
    if me.currentMatch.PlayerOne.CurrentlyUp is false
      me.currentMatch.CurrentGame.setPlayerOneBallTypeToStriped()
    else
      me.currentMatch.CurrentGame.setPlayerTwoBallTypeToStriped()
    me.saveAndUpdateUI()
  else if me.solidCategoryButtonActive.visible is true
    if me.currentMatch.PlayerOne.CurrentlyUp is false
      me.currentMatch.CurrentGame.setPlayerOneBallTypeToSolid()
    else
      me.currentMatch.CurrentGame.setPlayerTwoBallTypeToSolid()
    me.saveAndUpdateUI()
  else
    me.showOverlay "Must pick ball category first!", 300

@ballCategoryCancelButton.addEventListener "click", ->
  unless me.currentMatch.Ended is true
    me.hideBallCategorySelector()
  else
    me.showOverlay "Match has ended, must pick category!", 300

@ballCategorySelector.add @ballCategoryContinueButton
@ballCategorySelector.add @ballCategoryCancelButton
@view.add @ballCategorySelector
@showBallCategorySelector = ->
  @stripeCategoryButtonActive.visible = false
  @solidCategoryButtonActive.visible = false
  @stripeCategoryButton.visible = true
  @solidCategoryButton.visible = true
  @ballCategorySelectorPlayerName.text = (if (@currentMatch.PlayerOne.CurrentlyUp is true) then @currentMatch.PlayerTwo.getFirstNameWithInitials() else @currentMatch.PlayerOne.getFirstNameWithInitials())
  @ballCategorySelector.visible = true
  @ballCategorySelectorContainer.visible = true

@hideBallCategorySelector = ->
  @ballCategorySelectorContainer.visible = false
  @ballCategorySelector.visible = false