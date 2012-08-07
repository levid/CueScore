me = this
currentTeamSigning = null
@signatureViewOverlay = Ti.UI.createView(
  backgroundImage: "images/match/layout/bg-sign-scoresheet-android.png"
  height: 452
  width: 320
  visible: false
)
@signatureView = Ti.UI.createPaint(
  right: 116
  top: 50
  height: 365
  width: 40
  backgroundColor: "#ffffff"
)
@signatureView.visible = false
@isSignatureTeamNameTurned = false
@signatureTeamName = Ti.UI.createLabel(
  text: ""
  top: 100
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
  text: "Team 123"
  left: 80
  bottom: 40
  height: 20
  width: 220
  backgroundColor: "transparent"
  textAlign: "right"
  font:
    fontSize: 15
    fontWeight: "bold"
    fontFamily: "HelveticaNeue-Bold"
)
@signatureBackButton = Ti.UI.createImageView(
  height: 61
  width: 31
  top: 8
  right: 7
  backgroundColor: "transparent"
)
@signatureBackButton.addEventListener "click", ->
  me.hideSignatureView()

@signatureNextButton = Ti.UI.createImageView(
  height: 61
  width: 31
  right: 8
  bottom: 13
  backgroundColor: "transparent"
)
@signatureNextButton.addEventListener "click", ->
  me.setupSignatureOverlay()

@signatureSendButton = Ti.UI.createImageView(
  height: 135
  width: 27
  right: 260
  top: 232
  backgroundColor: "transparent"
)
@signatureSendButton.addEventListener "click", ->
  DataService.sendSignature me.signatureView.toImage()

@protestMatchButton = Ti.UI.createImageView(
  height: 115
  width: 27
  right: 260
  top: 111
  backgroundColor: "transparent"
)
@protestMatchButton.addEventListener "click", ->

@view.add @signatureViewOverlay
@signatureViewOverlay.add @signatureTeamName
@signatureViewOverlay.add @signatureTeamNumber
@signatureViewOverlay.add @signatureBackButton
@signatureViewOverlay.add @signatureNextButton
@signatureViewOverlay.add @signatureSendButton
@signatureViewOverlay.add @protestMatchButton
@view.add @signatureView
@openSignatureView = ->
  me.setupSignatureOverlay()
  me.signatureViewOverlay.visible = true
  me.signatureView.visible = true

@hideSignatureView = ->
  me.signatureViewOverlay.visible = false
  me.signatureView.visible = false

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