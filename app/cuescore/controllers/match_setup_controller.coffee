# class MatchSetupController
  # opts: {}
#   
  # constructor: (@options) ->
    # @options = _.extend({}, @opts, @options)
    # # _.extend @, @defaults
#   
  # showIndicator = (title) ->
    # indicatorShowing = true
    # indWin = Ti.UI.createWindow(
      # width: 150
      # height: 150
    # )
    # indView = Ti.UI.createView(
      # width: 150
      # height: 150
      # backgroundColor: "#000"
      # borderRadius: 10
      # opacity: 0.7
    # )
    # indWin.add indView
    # actInd = Ti.UI.createImageView(
      # top: 20
      # duration: 300
      # defaultImage: "images/dashboard/loading/loading1.png"
      # images: [ "images/dashboard/loading/loading1.png", "images/dashboard/loading/loading2.png", "images/dashboard/loading/loading3.png", "images/dashboard/loading/loading4.png", "images/dashboard/loading/loading5.png" ]
      # height: 88
      # width: 88
    # )
    # indWin.add actInd
    # message = Ti.UI.createLabel(
      # text: title
      # color: "#fff"
      # font:
        # fontSize: 20
        # fontWeight: "bold"
#   
      # top: 110
      # left: 30
    # )
    # indWin.add message
    # actInd.start()
    # indWin.open()
#     
  # hideIndicator: ->
    # actInd.stop()
    # indWin.close
      # opacity: 0
      # duration: 500
#   
    # indicatorShowing = false
#     
  # stopIndicator: ->
    # actInd.stop()
#     
  # matchSetup: ->
    # Ti.include "/js/json2.js"
    # Ti.include "/js/NineBall/NineBallGa@js"
    # Ti.include "/js/NineBall/NineBallPlayer.js"
    # Ti.include "/js/NineBall/NineBallLeagueMatch.js"
    # Ti.include "/js/NineBall/NineBallMatch.js"
    # Ti.include "/js/NineBall/NineBallRanks.js"
    # Ti.include "/js/EightBall/EightBallGa@js"
    # Ti.include "/js/EightBall/EightBallPlayer.js"
    # Ti.include "/js/EightBall/EightBallLeagueMatch.js"
    # Ti.include "/js/EightBall/EightBallMatch.js"
    # Ti.include "/js/EightBall/EightBallRanks.js"
    # Ti.include "/js/Services/DataService.js"
# 
    # @matchSetupWindow = Ti.UI.createWindow(
      # orientationModes: [ Ti.UI.PORTRAIT ]
      # title: "Play"
    # )
    # @matchSetupTitleBar = Ti.UI.createView(
      # backgroundColor: "transparent"
      # backgroundImage: "images/match/layout/titlebar-matches.png"
      # top: 0
      # left: 0
      # width: getPlatformWidth()
      # height: 44
    # )
    # @playLabel = Ti.UI.createLabel(
      # text: "Play"
      # color: "#ffffff"
      # shadowColor: "#000000"
      # textAlign: "center"
      # font:
        # fontSize: 20
        # fontWeight: "bold"
        # fontFamily: "HelveticaNeue-Bold"
    # )
    # @dashboardButton = Ti.UI.createView(
      # backgroundColor: "transparent"
      # backgroundImage: "images/match/buttons/btn-tabmenu-backto-dashboard.png"
      # top: 7
      # left: 8
      # width: 93
      # height: 30
    # )
    # @dashboardButtonLabel = Ti.UI.createLabel(
      # text: "Dashboard"
      # color: "#ffffff"
      # shadowColor: "#000000"
      # left: 13
      # font:
        # fontSize: 13
        # fontWeight: "bold"
        # fontFamily: "HelveticaNeue-Bold"
    # )
    # @dashboardButton.add @dashboardButtonLabel
    # @dashboardButton.addEventListener "click", ->
      # @matchSetupWindow.close()
      # @dashboardWindow.show()
#   
    # @matchSetupDoneButton = Ti.UI.createView(
      # backgroundColor: "transparent"
      # backgroundImage: "images/match/buttons/btn-done.png"
      # top: 7
      # right: 8
      # width: 60
      # height: 30
    # )
#     
    # @matchSetupDoneButton.addEventListener "click", @doneButtonClick
    # @matchSetupTitleBar.add @matchSetupDoneButton
    # @matchSetupTitleBar.add @playLabel
    # @matchSetupTitleBar.add @dashboardButton
    # @matchSetupFooter = Ti.UI.createView(
      # backgroundColor: "transparent"
      # backgroundImage: "images/match/layout/bg-tabmenu.png"
      # bottom: 0
      # width: @getPlatformWidth()
      # height: 49
    # )
    # @selectedButtonBackground = Ti.UI.createView(
      # backgroundImage: "images/match/buttons/btn-tabmenu-active.png"
      # top: 3
      # left: 2
      # width: 73
      # height: 44
    # )
    # @playButton = Ti.UI.createView(
      # backgroundColor: "transparent"
      # top: 3
      # left: 2
      # width: 73
      # height: 44
    # )
    # @playButtonIcon = Ti.UI.createView(
      # backgroundColor: "transparent"
      # backgroundImage: "images/match/icons/icon-tabmenu-play-active.png"
      # top: 8
      # left: 20
      # width: 32
      # height: 21
    # )
    # @playButtonLabel = Ti.UI.createLabel(
      # text: "Play"
      # color: "#ffffff"
      # shadowColor: "#000000"
      # width: 73
      # bottom: 1
      # textAlign: "center"
      # font:
        # fontSize: 9
        # fontWeight: "bold"
        # fontFamily: "HelveticaNeue-Bold"
    # )
    # @playButton.add @playButtonIcon
    # @playButton.add @playButtonLabel
    # @matchSetupFooter.add @selectedButtonBackground
    # @matchSetupFooter.add @playButton
    # @matchSetupWindow.add @matchSetupFooter
    # @matchSetupContainer = Ti.UI.createView(
      # backgroundImage: (if (Ti.Platform.name isnt "android") then "images/match/layout/bg-menus-iphone.png" else "images/match/layout/bg-menus-android.png")
      # backgroundColor: "transparent"
      # top: 44
      # left: 0
      # height: (@getPlatformHeight() - 95)
      # width: @getPlatformWidth()
    # )
    # @matchSetupView = Ti.UI.createScrollView(
      # contentWidth: "auto"
      # contentHeight: "auto"
      # backgroundColor: "transparent"
      # top: 12
      # left: 12
      # height: 340
      # width: 295
      # showPagingControl: true
    # )
    # @gameTypeLabel = Ti.UI.createLabel(
      # text: "Select Game Type"
      # color: "#ffffff"
      # height: 40
      # width: 295
      # top: 0
      # textAlign: "center"
      # font:
        # fontSize: 20
        # fontWeight: "bold"
        # fontFamily: "HelveticaNeue-Bold"
    # )
    # @matchTypeContainer = Ti.UI.createView(
      # backgroundImage: "images/match/layout/bg-dashboard-buttons-listview.png"
      # backgroundColor: "transparent"
      # top: 40
      # left: 16
      # height: 145
      # width: 262
    # )
    # @eightBallTypeButton = Ti.UI.createImageView(
      # backgroundImage: "images/match/layout/bg_play_gamebutton.png"
      # backgroundColor: "transparent"
      # top: 9
      # left: 5
      # height: 126
      # width: 124
    # )
    # @eightBallTypeButtonActive = Ti.UI.createView(
      # backgroundImage: "images/match/layout/bg_play_gamebutton_active.png"
      # backgroundColor: "transparent"
      # top: 9
      # left: 5
      # height: 126
      # width: 124
    # )
    # @eightBallTypeButtonActive.visible = false
    # @eightBallTypeButtonIcon = Ti.UI.createImageView(
      # backgroundImage: "images/match/icons/icon_gamebutton_8ball.png"
      # backgroundColor: "transparent"
      # top: 16
      # left: 21
      # height: 88
      # width: 88
    # )
    # @eightBallTypeButtonLabel = Ti.UI.createLabel(
      # text: "8-Ball"
      # backgroundColor: "transparent"
      # top: 94
      # left: 3
      # height: 25
      # width: 124
      # textAlign: "center"
      # color: "#ffffff"
      # font:
        # fontSize: 20
        # fontWeight: "bold"
        # fontFamily: "HelveticaNeue-Bold"
    # )
    # @matchTypeContainer.add @eightBallTypeButtonActive
    # @matchTypeContainer.add @eightBallTypeButton
    # @matchTypeContainer.add @eightBallTypeButtonIcon
    # @matchTypeContainer.add @eightBallTypeButtonLabel
    # @nineBallTypeButton = Ti.UI.createImageView(
      # backgroundImage: "images/match/layout/bg_play_gamebutton.png"
      # backgroundColor: "transparent"
      # top: 9
      # left: 132
      # height: 126
      # width: 124
    # )
    # @nineBallTypeButton.visible = false
    # @nineBallTypeButtonActive = Ti.UI.createView(
      # backgroundImage: "images/match/layout/bg_play_gamebutton_active.png"
      # backgroundColor: "transparent"
      # top: 9
      # left: 132
      # height: 126
      # width: 124
    # )
    # @nineBallTypeButtonActive.visible = true
    # @nineBallTypeButtonIcon = Ti.UI.createView(
      # backgroundImage: "images/match/icons/icon_gamebutton_9ball.png"
      # backgroundColor: "transparent"
      # top: 16
      # left: 152
      # height: 88
      # width: 88
    # )
    # @nineBallTypeButtonLabel = Ti.UI.createLabel(
      # text: "9-Ball"
      # backgroundColor: "transparent"
      # top: 96
      # left: 134
      # height: 25
      # width: 124
      # color: "#ffffff"
      # textAlign: "center"
      # font:
        # fontSize: 20
        # fontWeight: "bold"
        # fontFamily: "HelveticaNeue-Bold"
    # )
    # @matchTypeContainer.add @nineBallTypeButtonActive
    # @matchTypeContainer.add @nineBallTypeButton
    # @matchTypeContainer.add @nineBallTypeButtonIcon
    # @matchTypeContainer.add @nineBallTypeButtonLabel
    # @eightBallTypeClick = =>
      # if @eightBallTypeButtonActive.visible is false
        # @eightBallTypeButtonActive.visible = true
        # @eightBallTypeButton.visible = false
        # @nineBallTypeButtonActive.visible = false
        # @nineBallTypeButton.visible = true
#   
    # @nineBallTypeClick = =>
      # if @nineBallTypeButtonActive.visible is false
        # @eightBallTypeButtonActive.visible = false
        # @eightBallTypeButton.visible = true
        # @nineBallTypeButtonActive.visible = true
        # @nineBallTypeButton.visible = false
#   
    # @eightBallTypeButtonIcon.addEventListener "click", @eightBallTypeClick
    # @eightBallTypeButton.addEventListener "click", @eightBallTypeClick
    # @nineBallTypeButton.addEventListener "click", @nineBallTypeClick
    # @nineBallTypeButtonIcon.addEventListener "click", @nineBallTypeClick
    # @matchSetupTableExtender = Ti.UI.createView(
      # backgroundColor: "transparent"
      # top: 192
      # left: 18
      # height: 1452
      # width: 262
    # )
    # @matchSetupTable = Ti.UI.createView(
      # backgroundColor: "transparent"
      # top: 0
      # left: 0
      # height: 1399
      # width: 262
    # )
    # @matchSetupTableContainer = Ti.UI.createView(
      # backgroundColor: "#0e1115"
      # top: 7
      # left: 0
      # height: 1385
      # width: 262
    # )
    # @matchSetupTableContainerTop = Ti.UI.createView(
      # backgroundImage: "images/match/layout/bg_menu_container_top.png"
      # top: 0
      # left: 0
      # height: 7
      # width: 262
    # )
    # @matchSetupTableContainerBottom = Ti.UI.createView(
      # backgroundImage: "images/match/layout/bg_menu_container_bottom.png"
      # bottom: 0
      # left: 0
      # height: 7
      # width: 262
    # )
    # @matchSetupTable.add @matchSetupTableContainerBottom
    # @matchSetupTable.add @matchSetupTableContainerTop
    # @matchSetupTable.add @matchSetupTableContainer
    # @matchSetupTableExtender.add @matchSetupTable
    # @matchSetupEmail = Ti.UI.createView(
      # backgroundImage: "images/match/layout/bg-demosetup-field.png"
      # top: 3
      # left: 2
      # height: 42
      # width: 258
    # )
    # @matchSetupEmailLabel = Ti.UI.createLabel(
      # text: "E-mail"
      # color: "#ffff00"
      # top: 12
      # left: 6
      # height: 20
      # width: 100
      # font:
        # fontSize: 13
        # fontWeight: "bold"
        # fontFamily: "HelveticaNeue-Bold"
    # )
    # @matchSetupEmailText = Ti.UI.createTextField(
      # hintText: "i.wooten@gmail.com"
      # backgroundColor: "#ffffff"
      # top: 12
      # left: 110
      # height: 20
      # width: 130
      # suppressReturn: true
      # font:
        # fontSize: 13
        # fontWeight: "bold"
        # fontFamily: "HelveticaNeue-Bold"
    # )
    # @matchSetupEmail.add @matchSetupEmailLabel
    # @matchSetupEmail.add @matchSetupEmailText
    # @matchSetupTableExtender.add @matchSetupEmail
    # @matchSetupTeamOneNumber = Ti.UI.createView(
      # backgroundImage: "images/match/layout/bg-demosetup-field.png"
      # top: 48
      # left: 2
      # height: 42
      # width: 258
    # )
    # @matchSetupTeamOneNumberLabel = Ti.UI.createLabel(
      # text: "T1 Number"
      # color: "#ffff00"
      # top: 12
      # left: 6
      # height: 20
      # width: 100
      # font:
        # fontSize: 13
        # fontWeight: "bold"
        # fontFamily: "HelveticaNeue-Bold"
    # )
    # @matchSetupTeamOneNumberText = Ti.UI.createTextField(
      # hintText: "Team One Number"
      # backgroundColor: "#ffffff"
      # top: 12
      # left: 110
      # height: 20
      # width: 130
      # suppressReturn: true
      # font:
        # fontSize: 13
        # fontWeight: "bold"
        # fontFamily: "HelveticaNeue-Bold"
    # )
    # @matchSetupTeamOneNumber.add @matchSetupTeamOneNumberLabel
    # @matchSetupTeamOneNumber.add @matchSetupTeamOneNumberText
    # @matchSetupTableExtender.add @matchSetupTeamOneNumber
    # @matchSetupTeamTwoNumber = Ti.UI.createView(
      # backgroundImage: "images/match/layout/bg-demosetup-field.png"
      # top: 93
      # left: 2
      # height: 42
      # width: 258
    # )
    # @matchSetupTeamTwoNumberLabel = Ti.UI.createLabel(
      # text: "T2 Number"
      # color: "#ffff00"
      # top: 12
      # left: 6
      # height: 20
      # width: 100
      # font:
        # fontSize: 13
        # fontWeight: "bold"
        # fontFamily: "HelveticaNeue-Bold"
    # )
    # @matchSetupTeamTwoNumberText = Ti.UI.createTextField(
      # hintText: "Team Two Number"
      # backgroundColor: "#ffffff"
      # top: 12
      # left: 110
      # height: 20
      # width: 130
      # suppressReturn: true
      # font:
        # fontSize: 13
        # fontWeight: "bold"
        # fontFamily: "HelveticaNeue-Bold"
    # )
    # @matchSetupTeamTwoNumber.add @matchSetupTeamTwoNumberLabel
    # @matchSetupTeamTwoNumber.add @matchSetupTeamTwoNumberText
    # @matchSetupTableExtender.add @matchSetupTeamTwoNumber
    # @matchSetupTeamOnePlayerOneName = Ti.UI.createView(
      # backgroundImage: "images/match/layout/bg-demosetup-field.png"
      # top: 138
      # left: 2
      # height: 42
      # width: 258
    # )
    # @matchSetupTeamOnePlayerOneNameLabel = Ti.UI.createLabel(
      # text: "T1 P1 Name"
      # color: "#ffff00"
      # top: 12
      # left: 6
      # height: 20
      # width: 100
      # font:
        # fontSize: 13
        # fontWeight: "bold"
        # fontFamily: "HelveticaNeue-Bold"
    # )
    # @matchSetupTeamOnePlayerOneNameText = Ti.UI.createTextField(
      # hintText: "Player One Name"
      # backgroundColor: "#ffffff"
      # top: 12
      # left: 110
      # height: 20
      # width: 130
      # suppressReturn: true
      # font:
        # fontSize: 13
        # fontWeight: "bold"
        # fontFamily: "HelveticaNeue-Bold"
    # )
    # @matchSetupTeamOnePlayerOneNa@add @matchSetupTeamOnePlayerOneNameLabel
    # @matchSetupTeamOnePlayerOneNa@add @matchSetupTeamOnePlayerOneNameText
    # @matchSetupTableExtender.add @matchSetupTeamOnePlayerOneName
    # @matchSetupTeamOnePlayerOneNumber = Ti.UI.createView(
      # backgroundImage: "images/match/layout/bg-demosetup-field.png"
      # top: 183
      # left: 2
      # height: 42
      # width: 258
    # )
    # @matchSetupTeamOnePlayerOneNumberLabel = Ti.UI.createLabel(
      # text: "T1 P1 Num"
      # color: "#ffff00"
      # top: 12
      # left: 6
      # height: 20
      # width: 100
      # font:
        # fontSize: 13
        # fontWeight: "bold"
        # fontFamily: "HelveticaNeue-Bold"
    # )
    # @matchSetupTeamOnePlayerOneNumberText = Ti.UI.createTextField(
      # hintText: "Player One Number"
      # backgroundColor: "#ffffff"
      # top: 12
      # left: 110
      # height: 20
      # width: 130
      # suppressReturn: true
      # font:
        # fontSize: 13
        # fontWeight: "bold"
        # fontFamily: "HelveticaNeue-Bold"
    # )
    # @matchSetupTeamOnePlayerOneNumber.add @matchSetupTeamOnePlayerOneNumberLabel
    # @matchSetupTeamOnePlayerOneNumber.add @matchSetupTeamOnePlayerOneNumberText
    # @matchSetupTableExtender.add @matchSetupTeamOnePlayerOneNumber
    # @matchSetupTeamOnePlayerOneRank = Ti.UI.createView(
      # backgroundImage: "images/match/layout/bg-demosetup-field.png"
      # top: 228
      # left: 2
      # height: 42
      # width: 258
    # )
    # @matchSetupTeamOnePlayerOneRankLabel = Ti.UI.createLabel(
      # text: "T1 P1 Rank"
      # color: "#ffff00"
      # top: 12
      # left: 6
      # height: 20
      # width: 100
      # font:
        # fontSize: 13
        # fontWeight: "bold"
        # fontFamily: "HelveticaNeue-Bold"
    # )
    # @matchSetupTeamOnePlayerOneRankText = Ti.UI.createTextField(
      # hintText: "Player One Rank"
      # backgroundColor: "#ffffff"
      # top: 12
      # left: 110
      # height: 20
      # width: 130
      # suppressReturn: true
      # font:
        # fontSize: 13
        # fontWeight: "bold"
        # fontFamily: "HelveticaNeue-Bold"
    # )
    # @matchSetupTeamOnePlayerOneRank.add @matchSetupTeamOnePlayerOneRankLabel
    # @matchSetupTeamOnePlayerOneRank.add @matchSetupTeamOnePlayerOneRankText
    # @matchSetupTableExtender.add @matchSetupTeamOnePlayerOneRank
    # @matchSetupTeamTwoPlayerOneName = Ti.UI.createView(
      # backgroundImage: "images/match/layout/bg-demosetup-field.png"
      # top: 273
      # left: 2
      # height: 42
      # width: 258
    # )
    # @matchSetupTeamTwoPlayerOneNameLabel = Ti.UI.createLabel(
      # text: "T2 P1 Name"
      # color: "#ffff00"
      # top: 12
      # left: 6
      # height: 20
      # width: 100
      # font:
        # fontSize: 13
        # fontWeight: "bold"
        # fontFamily: "HelveticaNeue-Bold"
    # )
    # @matchSetupTeamTwoPlayerOneNameText = Ti.UI.createTextField(
      # hintText: "Player One Name"
      # backgroundColor: "#ffffff"
      # top: 12
      # left: 110
      # height: 20
      # width: 130
      # suppressReturn: true
      # font:
        # fontSize: 13
        # fontWeight: "bold"
        # fontFamily: "HelveticaNeue-Bold"
    # )
    # @matchSetupTeamTwoPlayerOneNa@add @matchSetupTeamTwoPlayerOneNameLabel
    # @matchSetupTeamTwoPlayerOneNa@add @matchSetupTeamTwoPlayerOneNameText
    # @matchSetupTableExtender.add @matchSetupTeamTwoPlayerOneName
    # @matchSetupTeamTwoPlayerOneNumber = Ti.UI.createView(
      # backgroundImage: "images/match/layout/bg-demosetup-field.png"
      # top: 318
      # left: 2
      # height: 42
      # width: 258
    # )
    # @matchSetupTeamTwoPlayerOneNumberLabel = Ti.UI.createLabel(
      # text: "T2 P1 Num"
      # color: "#ffff00"
      # top: 12
      # left: 6
      # height: 20
      # width: 100
      # font:
        # fontSize: 13
        # fontWeight: "bold"
        # fontFamily: "HelveticaNeue-Bold"
    # )
    # @matchSetupTeamTwoPlayerOneNumberText = Ti.UI.createTextField(
      # hintText: "Player One Number"
      # backgroundColor: "#ffffff"
      # top: 12
      # left: 110
      # height: 20
      # width: 130
      # suppressReturn: true
      # font:
        # fontSize: 13
        # fontWeight: "bold"
        # fontFamily: "HelveticaNeue-Bold"
    # )
    # @matchSetupTeamTwoPlayerOneNumber.add @matchSetupTeamTwoPlayerOneNumberLabel
    # @matchSetupTeamTwoPlayerOneNumber.add @matchSetupTeamTwoPlayerOneNumberText
    # @matchSetupTableExtender.add @matchSetupTeamTwoPlayerOneNumber
    # @matchSetupTeamTwoPlayerOneRank = Ti.UI.createView(
      # backgroundImage: "images/match/layout/bg-demosetup-field.png"
      # top: 363
      # left: 2
      # height: 42
      # width: 258
    # )
    # @matchSetupTeamTwoPlayerOneRankLabel = Ti.UI.createLabel(
      # text: "T2 P1 Rank"
      # color: "#ffff00"
      # top: 12
      # left: 6
      # height: 20
      # width: 100
      # font:
        # fontSize: 13
        # fontWeight: "bold"
        # fontFamily: "HelveticaNeue-Bold"
    # )
    # @matchSetupTeamTwoPlayerOneRankText = Ti.UI.createTextField(
      # hintText: "Player One Rank"
      # backgroundColor: "#ffffff"
      # top: 12
      # left: 110
      # height: 20
      # width: 130
      # suppressReturn: true
      # font:
        # fontSize: 13
        # fontWeight: "bold"
        # fontFamily: "HelveticaNeue-Bold"
    # )
    # @matchSetupTeamTwoPlayerOneRank.add @matchSetupTeamTwoPlayerOneRankLabel
    # @matchSetupTeamTwoPlayerOneRank.add @matchSetupTeamTwoPlayerOneRankText
    # @matchSetupTableExtender.add @matchSetupTeamTwoPlayerOneRank
    # @matchSetupTeamOnePlayerTwoName = Ti.UI.createView(
      # backgroundImage: "images/match/layout/bg-demosetup-field.png"
      # top: 408
      # left: 2
      # height: 42
      # width: 258
    # )
    # @matchSetupTeamOnePlayerTwoNameLabel = Ti.UI.createLabel(
      # text: "T1 P2 Name"
      # color: "#ffff00"
      # top: 12
      # left: 6
      # height: 20
      # width: 100
      # font:
        # fontSize: 13
        # fontWeight: "bold"
        # fontFamily: "HelveticaNeue-Bold"
    # )
    # @matchSetupTeamOnePlayerTwoNameText = Ti.UI.createTextField(
      # hintText: "Player Two Name"
      # backgroundColor: "#ffffff"
      # top: 12
      # left: 110
      # height: 20
      # width: 130
      # suppressReturn: true
      # font:
        # fontSize: 13
        # fontWeight: "bold"
        # fontFamily: "HelveticaNeue-Bold"
    # )
    # @matchSetupTeamOnePlayerTwoNa@add @matchSetupTeamOnePlayerTwoNameLabel
    # @matchSetupTeamOnePlayerTwoNa@add @matchSetupTeamOnePlayerTwoNameText
    # @matchSetupTableExtender.add @matchSetupTeamOnePlayerTwoName
    # @matchSetupTeamOnePlayerTwoNumber = Ti.UI.createView(
      # backgroundImage: "images/match/layout/bg-demosetup-field.png"
      # top: 453
      # left: 2
      # height: 42
      # width: 258
    # )
    # @matchSetupTeamOnePlayerTwoNumberLabel = Ti.UI.createLabel(
      # text: "T1 P2 Num"
      # color: "#ffff00"
      # top: 12
      # left: 6
      # height: 20
      # width: 100
      # font:
        # fontSize: 13
        # fontWeight: "bold"
        # fontFamily: "HelveticaNeue-Bold"
    # )
    # @matchSetupTeamOnePlayerTwoNumberText = Ti.UI.createTextField(
      # hintText: "Player Two Number"
      # backgroundColor: "#ffffff"
      # top: 12
      # left: 110
      # height: 20
      # width: 130
      # suppressReturn: true
      # font:
        # fontSize: 13
        # fontWeight: "bold"
        # fontFamily: "HelveticaNeue-Bold"
    # )
    # @matchSetupTeamOnePlayerTwoNumber.add @matchSetupTeamOnePlayerTwoNumberLabel
    # @matchSetupTeamOnePlayerTwoNumber.add @matchSetupTeamOnePlayerTwoNumberText
    # @matchSetupTableExtender.add @matchSetupTeamOnePlayerTwoNumber
    # @matchSetupTeamOnePlayerTwoRank = Ti.UI.createView(
      # backgroundImage: "images/match/layout/bg-demosetup-field.png"
      # top: 498
      # left: 2
      # height: 42
      # width: 258
    # )
    # @matchSetupTeamOnePlayerTwoRankLabel = Ti.UI.createLabel(
      # text: "T1 P2 Rank"
      # color: "#ffff00"
      # top: 12
      # left: 6
      # height: 20
      # width: 100
      # font:
        # fontSize: 13
        # fontWeight: "bold"
        # fontFamily: "HelveticaNeue-Bold"
    # )
    # @matchSetupTeamOnePlayerTwoRankText = Ti.UI.createTextField(
      # hintText: "Player Two Rank"
      # backgroundColor: "#ffffff"
      # top: 12
      # left: 110
      # height: 20
      # width: 130
      # suppressReturn: true
      # font:
        # fontSize: 13
        # fontWeight: "bold"
        # fontFamily: "HelveticaNeue-Bold"
    # )
    # @matchSetupTeamOnePlayerTwoRank.add @matchSetupTeamOnePlayerTwoRankLabel
    # @matchSetupTeamOnePlayerTwoRank.add @matchSetupTeamOnePlayerTwoRankText
    # @matchSetupTableExtender.add @matchSetupTeamOnePlayerTwoRank
    # @matchSetupTeamTwoPlayerTwoName = Ti.UI.createView(
      # backgroundImage: "images/match/layout/bg-demosetup-field.png"
      # top: 543
      # left: 2
      # height: 42
      # width: 258
    # )
    # @matchSetupTeamTwoPlayerTwoNameLabel = Ti.UI.createLabel(
      # text: "T2 P2 Name"
      # color: "#ffff00"
      # top: 12
      # left: 6
      # height: 20
      # width: 100
      # font:
        # fontSize: 13
        # fontWeight: "bold"
        # fontFamily: "HelveticaNeue-Bold"
    # )
    # @matchSetupTeamTwoPlayerTwoNameText = Ti.UI.createTextField(
      # hintText: "Player Two Name"
      # backgroundColor: "#ffffff"
      # top: 12
      # left: 110
      # height: 20
      # width: 130
      # suppressReturn: true
      # font:
        # fontSize: 13
        # fontWeight: "bold"
        # fontFamily: "HelveticaNeue-Bold"
    # )
    # @matchSetupTeamTwoPlayerTwoNa@add @matchSetupTeamTwoPlayerTwoNameLabel
    # @matchSetupTeamTwoPlayerTwoNa@add @matchSetupTeamTwoPlayerTwoNameText
    # @matchSetupTableExtender.add @matchSetupTeamTwoPlayerTwoName
    # @matchSetupTeamTwoPlayerTwoNumber = Ti.UI.createView(
      # backgroundImage: "images/match/layout/bg-demosetup-field.png"
      # top: 588
      # left: 2
      # height: 42
      # width: 258
    # )
    # @matchSetupTeamTwoPlayerTwoNumberLabel = Ti.UI.createLabel(
      # text: "T2 P2 Num"
      # color: "#ffff00"
      # top: 12
      # left: 6
      # height: 20
      # width: 100
      # font:
        # fontSize: 13
        # fontWeight: "bold"
        # fontFamily: "HelveticaNeue-Bold"
    # )
    # @matchSetupTeamTwoPlayerTwoNumberText = Ti.UI.createTextField(
      # hintText: "Player Two Number"
      # backgroundColor: "#ffffff"
      # top: 12
      # left: 110
      # height: 20
      # width: 130
      # suppressReturn: true
      # font:
        # fontSize: 13
        # fontWeight: "bold"
        # fontFamily: "HelveticaNeue-Bold"
    # )
    # @matchSetupTeamTwoPlayerTwoNumber.add @matchSetupTeamTwoPlayerTwoNumberLabel
    # @matchSetupTeamTwoPlayerTwoNumber.add @matchSetupTeamTwoPlayerTwoNumberText
    # @matchSetupTableExtender.add @matchSetupTeamTwoPlayerTwoNumber
    # @matchSetupTeamTwoPlayerTwoRank = Ti.UI.createView(
      # backgroundImage: "images/match/layout/bg-demosetup-field.png"
      # top: 633
      # left: 2
      # height: 42
      # width: 258
    # )
    # @matchSetupTeamTwoPlayerTwoRankLabel = Ti.UI.createLabel(
      # text: "T2 P2 Rank"
      # color: "#ffff00"
      # top: 12
      # left: 6
      # height: 20
      # width: 100
      # font:
        # fontSize: 13
        # fontWeight: "bold"
        # fontFamily: "HelveticaNeue-Bold"
    # )
    # @matchSetupTeamTwoPlayerTwoRankText = Ti.UI.createTextField(
      # hintText: "Player Two Rank"
      # backgroundColor: "#ffffff"
      # top: 12
      # left: 110
      # height: 20
      # width: 130
      # suppressReturn: true
      # font:
        # fontSize: 13
        # fontWeight: "bold"
        # fontFamily: "HelveticaNeue-Bold"
    # )
    # @matchSetupTeamTwoPlayerTwoRank.add @matchSetupTeamTwoPlayerTwoRankLabel
    # @matchSetupTeamTwoPlayerTwoRank.add @matchSetupTeamTwoPlayerTwoRankText
    # @matchSetupTableExtender.add @matchSetupTeamTwoPlayerTwoRank
    # @matchSetupTeamOnePlayerThreeName = Ti.UI.createView(
      # backgroundImage: "images/match/layout/bg-demosetup-field.png"
      # top: 678
      # left: 2
      # height: 42
      # width: 258
    # )
    # @matchSetupTeamOnePlayerThreeNameLabel = Ti.UI.createLabel(
      # text: "T1 P3 Name"
      # color: "#ffff00"
      # top: 12
      # left: 6
      # height: 20
      # width: 100
      # font:
        # fontSize: 13
        # fontWeight: "bold"
        # fontFamily: "HelveticaNeue-Bold"
    # )
    # @matchSetupTeamOnePlayerThreeNameText = Ti.UI.createTextField(
      # hintText: "Player Three Name"
      # backgroundColor: "#ffffff"
      # top: 12
      # left: 110
      # height: 20
      # width: 130
      # suppressReturn: true
      # font:
        # fontSize: 13
        # fontWeight: "bold"
        # fontFamily: "HelveticaNeue-Bold"
    # )
    # @matchSetupTeamOnePlayerThreeNa@add @matchSetupTeamOnePlayerThreeNameLabel
    # @matchSetupTeamOnePlayerThreeNa@add @matchSetupTeamOnePlayerThreeNameText
    # @matchSetupTableExtender.add @matchSetupTeamOnePlayerThreeName
    # @matchSetupTeamOnePlayerThreeNumber = Ti.UI.createView(
      # backgroundImage: "images/match/layout/bg-demosetup-field.png"
      # top: 723
      # left: 2
      # height: 42
      # width: 258
    # )
    # @matchSetupTeamOnePlayerThreeNumberLabel = Ti.UI.createLabel(
      # text: "T1 P3 Num"
      # color: "#ffff00"
      # top: 12
      # left: 6
      # height: 20
      # width: 100
      # font:
        # fontSize: 13
        # fontWeight: "bold"
        # fontFamily: "HelveticaNeue-Bold"
    # )
    # @matchSetupTeamOnePlayerThreeNumberText = Ti.UI.createTextField(
      # hintText: "Player Three Number"
      # backgroundColor: "#ffffff"
      # top: 12
      # left: 110
      # height: 20
      # width: 130
      # suppressReturn: true
      # font:
        # fontSize: 13
        # fontWeight: "bold"
        # fontFamily: "HelveticaNeue-Bold"
    # )
    # @matchSetupTeamOnePlayerThreeNumber.add @matchSetupTeamOnePlayerThreeNumberLabel
    # @matchSetupTeamOnePlayerThreeNumber.add @matchSetupTeamOnePlayerThreeNumberText
    # @matchSetupTableExtender.add @matchSetupTeamOnePlayerThreeNumber
    # @matchSetupTeamOnePlayerThreeRank = Ti.UI.createView(
      # backgroundImage: "images/match/layout/bg-demosetup-field.png"
      # top: 768
      # left: 2
      # height: 42
      # width: 258
    # )
    # @matchSetupTeamOnePlayerThreeRankLabel = Ti.UI.createLabel(
      # text: "T1 P3 Rank"
      # color: "#ffff00"
      # top: 12
      # left: 6
      # height: 20
      # width: 100
      # font:
        # fontSize: 13
        # fontWeight: "bold"
        # fontFamily: "HelveticaNeue-Bold"
    # )
    # @matchSetupTeamOnePlayerThreeRankText = Ti.UI.createTextField(
      # hintText: "Player Three Rank"
      # backgroundColor: "#ffffff"
      # top: 12
      # left: 110
      # height: 20
      # width: 130
      # suppressReturn: true
      # font:
        # fontSize: 13
        # fontWeight: "bold"
        # fontFamily: "HelveticaNeue-Bold"
    # )
    # @matchSetupTeamOnePlayerThreeRank.add @matchSetupTeamOnePlayerThreeRankLabel
    # @matchSetupTeamOnePlayerThreeRank.add @matchSetupTeamOnePlayerThreeRankText
    # @matchSetupTableExtender.add @matchSetupTeamOnePlayerThreeRank
    # @matchSetupTeamTwoPlayerThreeName = Ti.UI.createView(
      # backgroundImage: "images/match/layout/bg-demosetup-field.png"
      # top: 813
      # left: 2
      # height: 42
      # width: 258
    # )
    # @matchSetupTeamTwoPlayerThreeNameLabel = Ti.UI.createLabel(
      # text: "T2 P3 Name"
      # color: "#ffff00"
      # top: 12
      # left: 6
      # height: 20
      # width: 100
      # font:
        # fontSize: 13
        # fontWeight: "bold"
        # fontFamily: "HelveticaNeue-Bold"
    # )
    # @matchSetupTeamTwoPlayerThreeNameText = Ti.UI.createTextField(
      # hintText: "Player Three Name"
      # backgroundColor: "#ffffff"
      # top: 12
      # left: 110
      # height: 20
      # width: 130
      # suppressReturn: true
      # font:
        # fontSize: 13
        # fontWeight: "bold"
        # fontFamily: "HelveticaNeue-Bold"
    # )
    # @matchSetupTeamTwoPlayerThreeNa@add @matchSetupTeamTwoPlayerThreeNameLabel
    # @matchSetupTeamTwoPlayerThreeNa@add @matchSetupTeamTwoPlayerThreeNameText
    # @matchSetupTableExtender.add @matchSetupTeamTwoPlayerThreeName
    # @matchSetupTeamTwoPlayerThreeNumber = Ti.UI.createView(
      # backgroundImage: "images/match/layout/bg-demosetup-field.png"
      # top: 858
      # left: 2
      # height: 42
      # width: 258
    # )
    # @matchSetupTeamTwoPlayerThreeNumberLabel = Ti.UI.createLabel(
      # text: "T2 P3 Num"
      # color: "#ffff00"
      # top: 12
      # left: 6
      # height: 20
      # width: 100
      # font:
        # fontSize: 13
        # fontWeight: "bold"
        # fontFamily: "HelveticaNeue-Bold"
    # )
    # @matchSetupTeamTwoPlayerThreeNumberText = Ti.UI.createTextField(
      # hintText: "Player Three Number"
      # backgroundColor: "#ffffff"
      # top: 12
      # left: 110
      # height: 20
      # width: 130
      # suppressReturn: true
      # font:
        # fontSize: 13
        # fontWeight: "bold"
        # fontFamily: "HelveticaNeue-Bold"
    # )
    # @matchSetupTeamTwoPlayerThreeNumber.add @matchSetupTeamTwoPlayerThreeNumberLabel
    # @matchSetupTeamTwoPlayerThreeNumber.add @matchSetupTeamTwoPlayerThreeNumberText
    # @matchSetupTableExtender.add @matchSetupTeamTwoPlayerThreeNumber
    # @matchSetupTeamTwoPlayerThreeRank = Ti.UI.createView(
      # backgroundImage: "images/match/layout/bg-demosetup-field.png"
      # top: 903
      # left: 2
      # height: 42
      # width: 258
    # )
    # @matchSetupTeamTwoPlayerThreeRankLabel = Ti.UI.createLabel(
      # text: "T2 P3 Rank"
      # color: "#ffff00"
      # top: 12
      # left: 6
      # height: 20
      # width: 100
      # font:
        # fontSize: 13
        # fontWeight: "bold"
        # fontFamily: "HelveticaNeue-Bold"
    # )
    # @matchSetupTeamTwoPlayerThreeRankText = Ti.UI.createTextField(
      # hintText: "Player Three Rank"
      # backgroundColor: "#ffffff"
      # top: 12
      # left: 110
      # height: 20
      # width: 130
      # suppressReturn: true
      # font:
        # fontSize: 13
        # fontWeight: "bold"
        # fontFamily: "HelveticaNeue-Bold"
    # )
    # @matchSetupTeamTwoPlayerThreeRank.add @matchSetupTeamTwoPlayerThreeRankLabel
    # @matchSetupTeamTwoPlayerThreeRank.add @matchSetupTeamTwoPlayerThreeRankText
    # @matchSetupTableExtender.add @matchSetupTeamTwoPlayerThreeRank
    # @matchSetupTeamOnePlayerFourName = Ti.UI.createView(
      # backgroundImage: "images/match/layout/bg-demosetup-field.png"
      # top: 948
      # left: 2
      # height: 42
      # width: 258
    # )
    # @matchSetupTeamOnePlayerFourNameLabel = Ti.UI.createLabel(
      # text: "T1 P4 Name"
      # color: "#ffff00"
      # top: 12
      # left: 6
      # height: 20
      # width: 100
      # font:
        # fontSize: 13
        # fontWeight: "bold"
        # fontFamily: "HelveticaNeue-Bold"
    # )
    # @matchSetupTeamOnePlayerFourNameText = Ti.UI.createTextField(
      # hintText: "Player Four Name"
      # backgroundColor: "#ffffff"
      # top: 12
      # left: 110
      # height: 20
      # width: 130
      # suppressReturn: true
      # font:
        # fontSize: 13
        # fontWeight: "bold"
        # fontFamily: "HelveticaNeue-Bold"
    # )
    # @matchSetupTeamOnePlayerFourNa@add @matchSetupTeamOnePlayerFourNameLabel
    # @matchSetupTeamOnePlayerFourNa@add @matchSetupTeamOnePlayerFourNameText
    # @matchSetupTableExtender.add @matchSetupTeamOnePlayerFourName
    # @matchSetupTeamOnePlayerFourNumber = Ti.UI.createView(
      # backgroundImage: "images/match/layout/bg-demosetup-field.png"
      # top: 993
      # left: 2
      # height: 42
      # width: 258
    # )
    # @matchSetupTeamOnePlayerFourNumberLabel = Ti.UI.createLabel(
      # text: "T1 P4 Num"
      # color: "#ffff00"
      # top: 12
      # left: 6
      # height: 20
      # width: 100
      # font:
        # fontSize: 13
        # fontWeight: "bold"
        # fontFamily: "HelveticaNeue-Bold"
    # )
    # @matchSetupTeamOnePlayerFourNumberText = Ti.UI.createTextField(
      # hintText: "Player Four Number"
      # backgroundColor: "#ffffff"
      # top: 12
      # left: 110
      # height: 20
      # width: 130
      # suppressReturn: true
      # font:
        # fontSize: 13
        # fontWeight: "bold"
        # fontFamily: "HelveticaNeue-Bold"
    # )
    # @matchSetupTeamOnePlayerFourNumber.add @matchSetupTeamOnePlayerFourNumberLabel
    # @matchSetupTeamOnePlayerFourNumber.add @matchSetupTeamOnePlayerFourNumberText
    # @matchSetupTableExtender.add @matchSetupTeamOnePlayerFourNumber
    # @matchSetupTeamOnePlayerFourRank = Ti.UI.createView(
      # backgroundImage: "images/match/layout/bg-demosetup-field.png"
      # top: 1038
      # left: 2
      # height: 42
      # width: 258
    # )
    # @matchSetupTeamOnePlayerFourRankLabel = Ti.UI.createLabel(
      # text: "T1 P4 Rank"
      # color: "#ffff00"
      # top: 12
      # left: 6
      # height: 20
      # width: 100
      # font:
        # fontSize: 13
        # fontWeight: "bold"
        # fontFamily: "HelveticaNeue-Bold"
    # )
    # @matchSetupTeamOnePlayerFourRankText = Ti.UI.createTextField(
      # hintText: "Player Four Rank"
      # backgroundColor: "#ffffff"
      # top: 12
      # left: 110
      # height: 20
      # width: 130
      # suppressReturn: true
      # font:
        # fontSize: 13
        # fontWeight: "bold"
        # fontFamily: "HelveticaNeue-Bold"
    # )
    # @matchSetupTeamOnePlayerFourRank.add @matchSetupTeamOnePlayerFourRankLabel
    # @matchSetupTeamOnePlayerFourRank.add @matchSetupTeamOnePlayerFourRankText
    # @matchSetupTableExtender.add @matchSetupTeamOnePlayerFourRank
    # @matchSetupTeamTwoPlayerFourName = Ti.UI.createView(
      # backgroundImage: "images/match/layout/bg-demosetup-field.png"
      # top: 1083
      # left: 2
      # height: 42
      # width: 258
    # )
    # @matchSetupTeamTwoPlayerFourNameLabel = Ti.UI.createLabel(
      # text: "T2 P4 Name"
      # color: "#ffff00"
      # top: 12
      # left: 6
      # height: 20
      # width: 100
      # font:
        # fontSize: 13
        # fontWeight: "bold"
        # fontFamily: "HelveticaNeue-Bold"
    # )
    # @matchSetupTeamTwoPlayerFourNameText = Ti.UI.createTextField(
      # hintText: "Player Four Name"
      # backgroundColor: "#ffffff"
      # top: 12
      # left: 110
      # height: 20
      # width: 130
      # suppressReturn: true
      # font:
        # fontSize: 13
        # fontWeight: "bold"
        # fontFamily: "HelveticaNeue-Bold"
    # )
    # @matchSetupTeamTwoPlayerFourNa@add @matchSetupTeamTwoPlayerFourNameLabel
    # @matchSetupTeamTwoPlayerFourNa@add @matchSetupTeamTwoPlayerFourNameText
    # @matchSetupTableExtender.add @matchSetupTeamTwoPlayerFourName
    # @matchSetupTeamTwoPlayerFourNumber = Ti.UI.createView(
      # backgroundImage: "images/match/layout/bg-demosetup-field.png"
      # top: 1128
      # left: 2
      # height: 42
      # width: 258
    # )
    # @matchSetupTeamTwoPlayerFourNumberLabel = Ti.UI.createLabel(
      # text: "T2 P4 Num"
      # color: "#ffff00"
      # top: 12
      # left: 6
      # height: 20
      # width: 100
      # font:
        # fontSize: 13
        # fontWeight: "bold"
        # fontFamily: "HelveticaNeue-Bold"
    # )
    # @matchSetupTeamTwoPlayerFourNumberText = Ti.UI.createTextField(
      # hintText: "Player Four Number"
      # backgroundColor: "#ffffff"
      # top: 12
      # left: 110
      # height: 20
      # width: 130
      # suppressReturn: true
      # font:
        # fontSize: 13
        # fontWeight: "bold"
        # fontFamily: "HelveticaNeue-Bold"
    # )
    # @matchSetupTeamTwoPlayerFourNumber.add @matchSetupTeamTwoPlayerFourNumberLabel
    # @matchSetupTeamTwoPlayerFourNumber.add @matchSetupTeamTwoPlayerFourNumberText
    # @matchSetupTableExtender.add @matchSetupTeamTwoPlayerFourNumber
    # @matchSetupTeamTwoPlayerFourRank = Ti.UI.createView(
      # backgroundImage: "images/match/layout/bg-demosetup-field.png"
      # top: 1173
      # left: 2
      # height: 42
      # width: 258
    # )
    # @matchSetupTeamTwoPlayerFourRankLabel = Ti.UI.createLabel(
      # text: "T2 P4 Rank"
      # color: "#ffff00"
      # top: 12
      # left: 6
      # height: 20
      # width: 100
      # font:
        # fontSize: 13
        # fontWeight: "bold"
        # fontFamily: "HelveticaNeue-Bold"
    # )
    # @matchSetupTeamTwoPlayerFourRankText = Ti.UI.createTextField(
      # hintText: "Player Four Rank"
      # backgroundColor: "#ffffff"
      # top: 12
      # left: 110
      # height: 20
      # width: 130
      # suppressReturn: true
      # font:
        # fontSize: 13
        # fontWeight: "bold"
        # fontFamily: "HelveticaNeue-Bold"
    # )
    # @matchSetupTeamTwoPlayerFourRank.add @matchSetupTeamTwoPlayerFourRankLabel
    # @matchSetupTeamTwoPlayerFourRank.add @matchSetupTeamTwoPlayerFourRankText
    # @matchSetupTableExtender.add @matchSetupTeamTwoPlayerFourRank
    # @matchSetupTeamOnePlayerFiveName = Ti.UI.createView(
      # backgroundImage: "images/match/layout/bg-demosetup-field.png"
      # top: 1218
      # left: 2
      # height: 42
      # width: 258
    # )
    # @matchSetupTeamOnePlayerFiveNameLabel = Ti.UI.createLabel(
      # text: "T1 P5 Name"
      # color: "#ffff00"
      # top: 12
      # left: 6
      # height: 20
      # width: 100
      # font:
        # fontSize: 13
        # fontWeight: "bold"
        # fontFamily: "HelveticaNeue-Bold"
    # )
    # @matchSetupTeamOnePlayerFiveNameText = Ti.UI.createTextField(
      # hintText: "Player Five Name"
      # backgroundColor: "#ffffff"
      # top: 12
      # left: 110
      # height: 20
      # width: 130
      # suppressReturn: true
      # font:
        # fontSize: 13
        # fontWeight: "bold"
        # fontFamily: "HelveticaNeue-Bold"
    # )
    # @matchSetupTeamOnePlayerFiveNa@add @matchSetupTeamOnePlayerFiveNameLabel
    # @matchSetupTeamOnePlayerFiveNa@add @matchSetupTeamOnePlayerFiveNameText
    # @matchSetupTableExtender.add @matchSetupTeamOnePlayerFiveName
    # @matchSetupTeamOnePlayerFiveNumber = Ti.UI.createView(
      # backgroundImage: "images/match/layout/bg-demosetup-field.png"
      # top: 1263
      # left: 2
      # height: 42
      # width: 258
    # )
    # @matchSetupTeamOnePlayerFiveNumberLabel = Ti.UI.createLabel(
      # text: "T1 P5 Num"
      # color: "#ffff00"
      # top: 12
      # left: 6
      # height: 20
      # width: 100
      # font:
        # fontSize: 13
        # fontWeight: "bold"
        # fontFamily: "HelveticaNeue-Bold"
    # )
    # @matchSetupTeamOnePlayerFiveNumberText = Ti.UI.createTextField(
      # hintText: "Player Five Number"
      # backgroundColor: "#ffffff"
      # top: 12
      # left: 110
      # height: 20
      # width: 130
      # suppressReturn: true
      # font:
        # fontSize: 13
        # fontWeight: "bold"
        # fontFamily: "HelveticaNeue-Bold"
    # )
    # @matchSetupTeamOnePlayerFiveNumber.add @matchSetupTeamOnePlayerFiveNumberLabel
    # @matchSetupTeamOnePlayerFiveNumber.add @matchSetupTeamOnePlayerFiveNumberText
    # @matchSetupTableExtender.add @matchSetupTeamOnePlayerFiveNumber
    # @matchSetupTeamOnePlayerFiveRank = Ti.UI.createView(
      # backgroundImage: "images/match/layout/bg-demosetup-field.png"
      # top: 1308
      # left: 2
      # height: 42
      # width: 258
    # )
    # @matchSetupTeamOnePlayerFiveRankLabel = Ti.UI.createLabel(
      # text: "T1 P5 Rank"
      # color: "#ffff00"
      # top: 12
      # left: 6
      # height: 20
      # width: 100
      # font:
        # fontSize: 13
        # fontWeight: "bold"
        # fontFamily: "HelveticaNeue-Bold"
    # )
    # @matchSetupTeamOnePlayerFiveRankText = Ti.UI.createTextField(
      # hintText: "Player Five Rank"
      # backgroundColor: "#ffffff"
      # top: 12
      # left: 110
      # height: 20
      # width: 130
      # suppressReturn: true
      # font:
        # fontSize: 13
        # fontWeight: "bold"
        # fontFamily: "HelveticaNeue-Bold"
    # )
    # @matchSetupTeamOnePlayerFiveRank.add @matchSetupTeamOnePlayerFiveRankLabel
    # @matchSetupTeamOnePlayerFiveRank.add @matchSetupTeamOnePlayerFiveRankText
    # @matchSetupTableExtender.add @matchSetupTeamOnePlayerFiveRank
    # @matchSetupTeamTwoPlayerFiveName = Ti.UI.createView(
      # backgroundImage: "images/match/layout/bg-demosetup-field.png"
      # top: 1353
      # left: 2
      # height: 42
      # width: 258
    # )
    # @matchSetupTeamTwoPlayerFiveNameLabel = Ti.UI.createLabel(
      # text: "T2 P5 Name"
      # color: "#ffff00"
      # top: 12
      # left: 6
      # height: 20
      # width: 100
      # font:
        # fontSize: 13
        # fontWeight: "bold"
        # fontFamily: "HelveticaNeue-Bold"
    # )
    # @matchSetupTeamTwoPlayerFiveNameText = Ti.UI.createTextField(
      # hintText: "Player Five Name"
      # backgroundColor: "#ffffff"
      # top: 12
      # left: 110
      # height: 20
      # width: 130
      # suppressReturn: true
      # font:
        # fontSize: 13
        # fontWeight: "bold"
        # fontFamily: "HelveticaNeue-Bold"
    # )
    # @matchSetupTeamTwoPlayerFiveNa@add @matchSetupTeamTwoPlayerFiveNameLabel
    # @matchSetupTeamTwoPlayerFiveNa@add @matchSetupTeamTwoPlayerFiveNameText
    # @matchSetupTableExtender.add @matchSetupTeamTwoPlayerFiveName
    # @matchSetupTeamTwoPlayerFiveNumber = Ti.UI.createView(
      # backgroundImage: "images/match/layout/bg-demosetup-field.png"
      # top: 1398
      # left: 2
      # height: 42
      # width: 258
    # )
    # @matchSetupTeamTwoPlayerFiveNumberLabel = Ti.UI.createLabel(
      # text: "T2 P5 Num"
      # color: "#ffff00"
      # top: 12
      # left: 6
      # height: 20
      # width: 100
      # font:
        # fontSize: 13
        # fontWeight: "bold"
        # fontFamily: "HelveticaNeue-Bold"
    # )
    # @matchSetupTeamTwoPlayerFiveNumberText = Ti.UI.createTextField(
      # hintText: "Player Five Number"
      # backgroundColor: "#ffffff"
      # top: 12
      # left: 110
      # height: 20
      # width: 130
      # suppressReturn: true
      # font:
        # fontSize: 13
        # fontWeight: "bold"
        # fontFamily: "HelveticaNeue-Bold"
    # )
    # @matchSetupTeamTwoPlayerFiveNumber.add @matchSetupTeamTwoPlayerFiveNumberLabel
    # @matchSetupTeamTwoPlayerFiveNumber.add @matchSetupTeamTwoPlayerFiveNumberText
    # @matchSetupTableExtender.add @matchSetupTeamTwoPlayerFiveNumber
    # @matchSetupTeamTwoPlayerFiveRank = Ti.UI.createView(
      # backgroundImage: "images/match/layout/bg-demosetup-field.png"
      # top: 1443
      # left: 2
      # height: 42
      # width: 258
    # )
    # @matchSetupTeamTwoPlayerFiveRankLabel = Ti.UI.createLabel(
      # text: "T2 P5 Rank"
      # color: "#ffff00"
      # top: 12
      # left: 6
      # height: 20
      # width: 100
      # font:
        # fontSize: 13
        # fontWeight: "bold"
        # fontFamily: "HelveticaNeue-Bold"
    # )
    # @matchSetupTeamTwoPlayerFiveRankText = Ti.UI.createTextField(
      # hintText: "Player Five Rank"
      # backgroundColor: "#ffffff"
      # top: 12
      # left: 110
      # height: 20
      # width: 130
      # suppressReturn: true
      # font:
        # fontSize: 13
        # fontWeight: "bold"
        # fontFamily: "HelveticaNeue-Bold"
    # )
    # @matchSetupTeamTwoPlayerFiveRank.add @matchSetupTeamTwoPlayerFiveRankLabel
    # @matchSetupTeamTwoPlayerFiveRank.add @matchSetupTeamTwoPlayerFiveRankText
    # @matchSetupTableExtender.add @matchSetupTeamTwoPlayerFiveRank
    # @matchSetupView.add @matchSetupTableExtender
    # @matchSetupView.add @gameTypeLabel
    # @matchSetupView.add @matchTypeContainer
    # @matchSetupContainer.add @matchSetupView
    # @matchSetupWindow.add @matchSetupTitleBar
    # @matchSetupWindow.add @matchSetupContainer
    # @showMatchSetup = ->
      # unless Ti.Platform.name is "android"
        # Ti.UI.iPhone.showStatusBar()
        # @matchSetupWindow.open fullscreen: false
      # else
        # @matchSetupWindow.open fullscreen: true
#   
    # showMatchSetup()
    # this
#   
    # indWin = null
    # actInd = null
#     
  # doneButtonClick: ->
    # leagueMatch = null
    # showIndicator "Loading..."
    # DataService.setupLocalDatabase()
    # DataService.email = @matchSetupEmailText.value  unless @matchSetupEmailText.value is ""
    # if @nineBallTypeButtonActive.visible is true
      # if @matchSetupTeamOneNumberText.value is ""
        # leagueMatch = new NineBallLeagueMatch("123", "456", "HomeTeam", "AwayTeam", "1:00 am", "Coin-Operated")
        # leagueMatch.setMatchOne new NineBallMatch("Isaac Wooten", "James Armstead", 1, 3, "123456", "234567", "123", "456")
        # leagueMatch.setMatchTwo new NineBallMatch("Dude 1", "Chick 1", 2, 3, "123456", "234567", "123", "456")
        # leagueMatch.setMatchThree new NineBallMatch("Dude 2", "Chick 2", 1, 2, "234567", "123456", "123", "456")
        # leagueMatch.setMatchFour new NineBallMatch("Dude 3", "Chick 3", 1, 2, "123456", "234567", "123", "456")
        # leagueMatch.setMatchFive new NineBallMatch("Dude 4", "Chick 4", 1, 1, "234567", "123456", "123", "456")
      # else
        # leagueMatch = new NineBallLeagueMatch(@matchSetupTeamOneNumberText.value, @matchSetupTeamTwoNumberText.value, "HomeTeam", "AwayTeam", "1:00 am", "Coin-Operated")
        # leagueMatch.setMatchOne new NineBallMatch(@matchSetupTeamOnePlayerOneNameText.value, @matchSetupTeamTwoPlayerOneNameText.value, parseInt(@matchSetupTeamOnePlayerOneRankText.value), parseInt(@matchSetupTeamTwoPlayerOneRankText.value), @matchSetupTeamOnePlayerOneNumberText.value, @matchSetupTeamTwoPlayerOneNumberText.value, @matchSetupTeamOneNumberText.value, @matchSetupTeamTwoNumberText.value)
        # leagueMatch.setMatchTwo new NineBallMatch(@matchSetupTeamOnePlayerTwoNameText.value, @matchSetupTeamTwoPlayerTwoNameText.value, parseInt(@matchSetupTeamOnePlayerTwoRankText.value), parseInt(@matchSetupTeamTwoPlayerTwoRankText.value), @matchSetupTeamOnePlayerTwoNumberText.value, @matchSetupTeamTwoPlayerTwoNumberText.value, @matchSetupTeamOneNumberText.value, @matchSetupTeamTwoNumberText.value)
        # leagueMatch.setMatchThree new NineBallMatch(@matchSetupTeamOnePlayerThreeNameText.value, @matchSetupTeamTwoPlayerThreeNameText.value, parseInt(@matchSetupTeamOnePlayerThreeRankText.value), parseInt(@matchSetupTeamTwoPlayerThreeRankText.value), @matchSetupTeamOnePlayerThreeNumberText.value, @matchSetupTeamTwoPlayerThreeNumberText.value, @matchSetupTeamOneNumberText.value, @matchSetupTeamTwoNumberText.value)
        # leagueMatch.setMatchFour new NineBallMatch(@matchSetupTeamOnePlayerFourNameText.value, @matchSetupTeamTwoPlayerFourNameText.value, parseInt(@matchSetupTeamOnePlayerFourRankText.value), parseInt(@matchSetupTeamTwoPlayerFourRankText.value), @matchSetupTeamOnePlayerFourNumberText.value, @matchSetupTeamTwoPlayerFourNumberText.value, @matchSetupTeamOneNumberText.value, @matchSetupTeamTwoNumberText.value)
        # leagueMatch.setMatchFive new NineBallMatch(@matchSetupTeamOnePlayerFiveNameText.value, @matchSetupTeamTwoPlayerFiveNameText.value, parseInt(@matchSetupTeamOnePlayerFiveRankText.value), parseInt(@matchSetupTeamTwoPlayerFiveRankText.value), @matchSetupTeamOnePlayerFiveNumberText.value, @matchSetupTeamTwoPlayerFiveNumberText.value, @matchSetupTeamOneNumberText.value, @matchSetupTeamTwoNumberText.value)
    # else
      # if @matchSetupTeamOneNumberText.value is ""
        # leagueMatch = new EightBallLeagueMatch("123", "345", "HomeTeam", "AwayTeam", "1:00 am", "Coin-Operated")
        # leagueMatch.setMatchOne new EightBallMatch("Isaac Wooten", "James Armstead", 2, 3, "1", "2", "123", "345")
        # leagueMatch.setMatchTwo new EightBallMatch("Dude 1", "Chick 1", 2, 3, "3", "4", "123", "345")
        # leagueMatch.setMatchThree new EightBallMatch("Dude 2", "Chick 2", 2, 2, "5", "6", "123", "345")
        # leagueMatch.setMatchFour new EightBallMatch("Dude 3", "Chick 3", 2, 2, "7", "8", "123", "345")
        # leagueMatch.setMatchFive new EightBallMatch("Dude 4", "Chick 4", 2, 2, "9", "10", "123", "345")
      # else
        # leagueMatch = new EightBallLeagueMatch(@matchSetupTeamOneNumberText.value, @matchSetupTeamTwoNumberText.value, "HomeTeam", "AwayTeam", "1:00 am", "Coin-Operated")
        # leagueMatch.setMatchOne new EightBallMatch(@matchSetupTeamOnePlayerOneNameText.value, @matchSetupTeamTwoPlayerOneNameText.value, parseInt(@matchSetupTeamOnePlayerOneRankText.value), parseInt(@matchSetupTeamTwoPlayerOneRankText.value), @matchSetupTeamOnePlayerOneNumberText.value, @matchSetupTeamTwoPlayerOneNumberText.value, @matchSetupTeamOneNumberText.value, @matchSetupTeamTwoNumberText.value)
        # leagueMatch.setMatchTwo new EightBallMatch(@matchSetupTeamOnePlayerTwoNameText.value, @matchSetupTeamTwoPlayerTwoNameText.value, parseInt(@matchSetupTeamOnePlayerTwoRankText.value), parseInt(@matchSetupTeamTwoPlayerTwoRankText.value), @matchSetupTeamOnePlayerTwoNumberText.value, @matchSetupTeamTwoPlayerTwoNumberText.value, @matchSetupTeamOneNumberText.value, @matchSetupTeamTwoNumberText.value)
        # leagueMatch.setMatchThree new EightBallMatch(@matchSetupTeamOnePlayerThreeNameText.value, @matchSetupTeamTwoPlayerThreeNameText.value, parseInt(@matchSetupTeamOnePlayerThreeRankText.value), parseInt(@matchSetupTeamTwoPlayerThreeRankText.value), @matchSetupTeamOnePlayerThreeNumberText.value, @matchSetupTeamTwoPlayerThreeNumberText.value, @matchSetupTeamOneNumberText.value, @matchSetupTeamTwoNumberText.value)
        # leagueMatch.setMatchFour new EightBallMatch(@matchSetupTeamOnePlayerFourNameText.value, @matchSetupTeamTwoPlayerFourNameText.value, parseInt(@matchSetupTeamOnePlayerFourRankText.value), parseInt(@matchSetupTeamTwoPlayerFourRankText.value), @matchSetupTeamOnePlayerFourNumberText.value, @matchSetupTeamTwoPlayerFourNumberText.value, @matchSetupTeamOneNumberText.value, @matchSetupTeamTwoNumberText.value)
        # leagueMatch.setMatchFive new EightBallMatch(@matchSetupTeamOnePlayerFiveNameText.value, @matchSetupTeamTwoPlayerFiveNameText.value, parseInt(@matchSetupTeamOnePlayerFiveRankText.value), parseInt(@matchSetupTeamTwoPlayerFiveRankText.value), @matchSetupTeamOnePlayerFiveNumberText.value, @matchSetupTeamTwoPlayerFiveNumberText.value, @matchSetupTeamOneNumberText.value, @matchSetupTeamTwoNumberText.value)
    # play leagueMatch
#   
#     
#   
# $CS.Controllers.MatchSetupController = MatchSetupController
