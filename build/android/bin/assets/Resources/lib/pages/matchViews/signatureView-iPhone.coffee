me = this
currentTeamSigning = null
@signatureViewOverlay = Ti.UI.createView(
  backgroundImage: "images/match/layout/bg-sign-scoresheet-iphone.png"
  height: 301
  width: 481
  backgroundColor: "#ffffff"
  visible: false
)
@signatureViewContainer = Ti.UI.createImageView(
  top: 116
  left: 55
  height: 40
  width: 390
  backgroundColor: "#ffffff"
)
@isSignatureTeamNameTurned = false
@signatureTeamName = Ti.UI.createLabel(
  text: "Team Name"
  top: 50
  left: 150
  height: 20
  width: 220
  backgroundColor: "transparent"
  textAlign: "left"
  font:
    fontSize: 15
    fontWeight: "bold"
    fontFamily: "HelveticaNeue-Bold"
)
@isSignatureTeamNumberTurned = false
@signatureTeamNumber = Ti.UI.createLabel(
  top: 50
  text: "Team 123"
  left: 80
  height: 20
  width: 220
  backgroundColor: "transparent"
  textAlign: "right"
  font:
    fontSize: 15
    fontWeight: "bold"
    fontFamily: "HelveticaNeue-Bold"
)
paint = require("ti.paint")
@signatureView = paint.createView(
  strokeWidth: 3
  strokeColor: "#000000"
  height: 40
  width: 390
  backgroundColor: "#ffffff"
)
@signatureViewContainer.add @signatureView
@signatureBackButton = Ti.UI.createImageView(
  height: 31
  width: 61
  top: 8
  left: 7
  backgroundColor: "transparent"
)
@signatureBackButton.addEventListener "click", ->
  me.hideSignatureView()

@signatureNextButton = Ti.UI.createImageView(
  height: 31
  width: 61
  top: 8
  right: 13
  backgroundColor: "transparent"
)
@signatureNextButton.addEventListener "click", ->
  me.setupSignatureOverlay()

@signatureSendButton = Ti.UI.createImageView(
  height: 27
  width: 135
  top: 250
  left: 232
  backgroundColor: "transparent"
)
@signatureSendButton.addEventListener "click", ->
  theMap = me.signatureViewContainer.toImage()
  file = Ti.Filesystem.createTempFile(Ti.Filesystem.resourcesDirectory)
  file.write theMap
  w = file.read()
  DataService.sendSignature w

@protestMatchButton = Ti.UI.createView(
  height: 27
  width: 115
  top: 250
  left: 111
  backgroundColor: "transparent"
)
@protestMatchButton.addEventListener "click", ->
  me.hideSignatureView()

@signatureViewOverlay.add @signatureBackButton
@signatureViewOverlay.add @signatureNextButton
@signatureViewOverlay.add @signatureSendButton
@signatureViewOverlay.add @protestMatchButton
@signatureViewOverlay.add @signatureViewContainer
@view.add @signatureViewOverlay
@openSignatureView = ->
  me.signatureViewOverlay.visible = true
  me.matchWindow.orientationModes = [ Ti.UI.LANDSCAPE_RIGHT ]
  Ti.UI.orientation = Ti.UI.LANDSCAPE_RIGHT

@hideSignatureView = ->
  me.signatureViewOverlay.visible = false
  me.matchWindow.orientationModes = [ Ti.UI.PORTRAIT ]
  Ti.UI.orientation = Ti.UI.PORTRAIT

@matchSignedCallBack = ->
  me.setupSignatureOverlay()

@setupSignatureOverlay = ->
  @changeTeamSigning()
  if @leagueMatch.HomeTeamNumber is currentTeamSigning
    @signatureTeamName.text = @leagueMatch.HomeTeamName
    @signatureTeamNumber.text = "Team " + @leagueMatch.HomeTeamNumber
  else if @leagueMatch.AwayTeamNumber is currentTeamSigning
    @signatureTeamName.text = @leagueMatch.AwayTeamName
    @signatureTeamNumber.text = "Team " + @leagueMatch.AwayTeamNumber
  else

@changeTeamSigning = ->
  unless currentTeamSigning?
    if @leagueMatch.HomeTeamSigned is false
      currentTeamSigning = @leagueMatch.HomeTeamNumber
    else currentTeamSigning = @leagueMatch.AwayTeamNumber  if @leagueMatch.AwayTeamSigned is false
  else if currentTeamSigning is @leagueMatch.HomeTeamNumber
    if @leagueMatch.HomeTeamSigned is false
      currentTeamSigning = @leagueMatch.HomeTeamNumber
    else if @leagueMatch.AwayTeamSigned is false
      currentTeamSigning = @leagueMatch.AwayTeamNumber
    else
      currentTeamSigning = null
  else if currentTeamSigning is @leagueMatch.AwayTeamNumber
    if @leagueMatch.AwayTeamSigned is false
      currentTeamSigning = @leagueMatch.HomeTeamNumber
    else if @leagueMatch.HomeTeamSigned is false
      currentTeamSigning = @leagueMatch.AwayTeamNumber
    else
      currentTeamSigning = null
  else
    if @leagueMatch.HomeTeamSigned is false
      currentTeamSigning = @leagueMatch.HomeTeamNumber
    else if @leagueMatch.AwayTeamSigned is false
      currentTeamSigning = @leagueMatch.AwayTeamNumber
    else
      currentTeamSigning = null