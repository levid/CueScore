class GridView
  constructor: () ->
    playWindowHolder = null
    teamsWindowHolder = null
    activityWindowHolder = null
    profileWindowHolder = null
    newsWindowHolder = null
    eventsWindowHolder = null
    liveWindowHolder = null
    rulesWindowHolder = null
    settingsWindowHolder = null
    @gridView = Ti.UI.createView(
      top: 12
      left: 12
      height: 390
      width: 295
      isNinePatch: false
    )
    playIconContainer = Ti.UI.createView(
      left: 13
      top: 16
      height: 102
      width: 82
    )
    playIconBackground = Ti.UI.createView(
      backgroundImage: "images/match/layout/bg-dashboard-buttons-gridview.png"
      top: 0
      left: 0
      height: 83
      width: 82
    )
    playIcon = Ti.UI.createView(
      backgroundImage: "images/match/buttons/btn-dashboard-play-large.png"
      top: 5
      left: 6
      height: 71
      width: 70
    )
    playIconLabel = Ti.UI.createLabel(
      color: "#ffffff"
      backgroundColor: "transparent"
      text: "Play"
      top: 80
      height: 20
      width: 82
      textAlign: "center"
      font:
        fontSize: 14
        fontWeight: "bold"
        fontFamily: "HelveticaNeue-Bold"
    )
    playIcon.addEventListener "click", ->
      unless playWindowHolder?
        playWindowHolder = matchSetup()
      else
        playWindowHolder.showMatchSetup()
      dashboardWindow.hide()
    
    playIconBackground.add playIcon
    playIconContainer.add playIconBackground
    playIconContainer.add playIconLabel
    teamsIconContainer = Ti.UI.createView(
      left: 108
      top: 16
      height: 102
      width: 82
    )
    teamsIconBackground = Ti.UI.createView(
      backgroundImage: "images/match/layout/bg-dashboard-buttons-gridview.png"
      top: 0
      left: 0
      height: 83
      width: 82
    )
    teamsIcon = Ti.UI.createView(
      backgroundImage: "images/match/buttons/btn-dashboard-leagues-large.png"
      top: 5
      left: 6
      height: 71
      width: 70
    )
    teamsIconLabel = Ti.UI.createLabel(
      color: "#ffffff"
      backgroundColor: "transparent"
      text: "Teams"
      top: 80
      height: 20
      width: 82
      textAlign: "center"
      font:
        fontSize: 14
        fontWeight: "bold"
        fontFamily: "HelveticaNeue-Bold"
    )
    teamsIcon.addEventListener "click", ->
      unless teamsWindowHolder?
        teamsWindowHolder = teams()
      else
        teamsWindowHolder.showTeams()
      dashboardWindow.hide()
    
    teamsIconBackground.add teamsIcon
    teamsIconContainer.add teamsIconBackground
    teamsIconContainer.add teamsIconLabel
    activityIconContainer = Ti.UI.createView(
      left: 203
      top: 16
      height: 102
      width: 82
    )
    activityIconBackground = Ti.UI.createView(
      backgroundImage: "images/match/layout/bg-dashboard-buttons-gridview.png"
      top: 0
      left: 0
      height: 83
      width: 82
    )
    activityIcon = Ti.UI.createView(
      backgroundImage: "images/match/buttons/btn-dashboard-activity-large.png"
      top: 5
      left: 6
      height: 71
      width: 70
    )
    activityIconLabel = Ti.UI.createLabel(
      color: "#ffffff"
      backgroundColor: "transparent"
      text: "Activity"
      top: 80
      height: 20
      width: 82
      textAlign: "center"
      font:
        fontSize: 14
        fontWeight: "bold"
        fontFamily: "HelveticaNeue-Bold"
    )
    activityIcon.addEventListener "click", ->
      unless activityWindowHolder?
        activityWindowHolder = activity()
      else
        activityWindowHolder.showActivity()
      dashboardWindow.hide()
    
    activityIconBackground.add activityIcon
    activityIconContainer.add activityIconBackground
    activityIconContainer.add activityIconLabel
    profileIconContainer = Ti.UI.createView(
      left: 13
      top: 137
      height: 102
      width: 82
    )
    profileIconBackground = Ti.UI.createView(
      backgroundImage: "images/match/layout/bg-dashboard-buttons-gridview.png"
      top: 0
      left: 0
      height: 83
      width: 82
    )
    profileIcon = Ti.UI.createView(
      backgroundImage: "images/match/buttons/btn-dashboard-profile-large.png"
      top: 5
      left: 6
      height: 71
      width: 70
    )
    profileIconLabel = Ti.UI.createLabel(
      color: "#ffffff"
      backgroundColor: "transparent"
      text: "Profile"
      top: 80
      height: 20
      width: 82
      textAlign: "center"
      font:
        fontSize: 14
        fontWeight: "bold"
        fontFamily: "HelveticaNeue-Bold"
    )
    profileIcon.addEventListener "click", ->
      unless profileWindowHolder?
        profileWindowHolder = profile()
      else
        profileWindowHolder.showProfile()
      dashboardWindow.hide()
    
    profileIconBackground.add profileIcon
    profileIconContainer.add profileIconBackground
    profileIconContainer.add profileIconLabel
    newsIconContainer = Ti.UI.createView(
      left: 108
      top: 137
      height: 102
      width: 82
    )
    newsIconBackground = Ti.UI.createView(
      backgroundImage: "images/match/layout/bg-dashboard-buttons-gridview.png"
      top: 0
      left: 0
      height: 83
      width: 82
    )
    newsIcon = Ti.UI.createView(
      backgroundImage: "images/match/buttons/btn-dashboard-news-large.png"
      top: 5
      left: 6
      height: 71
      width: 70
    )
    newsIconLabel = Ti.UI.createLabel(
      color: "#ffffff"
      backgroundColor: "transparent"
      text: "News"
      top: 80
      height: 20
      width: 82
      textAlign: "center"
      font:
        fontSize: 14
        fontWeight: "bold"
        fontFamily: "HelveticaNeue-Bold"
    )
    newsIcon.addEventListener "click", ->
      unless newsWindowHolder?
        newsWindowHolder = news()
      else
        newsWindowHolder.showNews()
      dashboardWindow.hide()
    
    newsIconBackground.add newsIcon
    newsIconContainer.add newsIconBackground
    newsIconContainer.add newsIconLabel
    eventsIconContainer = Ti.UI.createView(
      left: 203
      top: 137
      height: 102
      width: 82
    )
    eventsIconBackground = Ti.UI.createView(
      backgroundImage: "images/match/layout/bg-dashboard-buttons-gridview.png"
      top: 0
      left: 0
      height: 83
      width: 82
    )
    eventsIcon = Ti.UI.createView(
      backgroundImage: "images/match/buttons/btn-dashboard-events-large.png"
      top: 5
      left: 6
      height: 71
      width: 70
    )
    eventsIconLabel = Ti.UI.createLabel(
      color: "#ffffff"
      backgroundColor: "transparent"
      text: "Events"
      top: 80
      height: 20
      width: 82
      textAlign: "center"
      font:
        fontSize: 14
        fontWeight: "bold"
        fontFamily: "HelveticaNeue-Bold"
    )
    eventsIcon.addEventListener "click", ->
      unless eventsWindowHolder?
        eventsWindowHolder = events()
      else
        eventsWindowHolder.showEvents()
      dashboardWindow.hide()
    
    eventsIconBackground.add eventsIcon
    eventsIconContainer.add eventsIconBackground
    eventsIconContainer.add eventsIconLabel
    liveIconContainer = Ti.UI.createView(
      left: 13
      top: 255
      height: 102
      width: 82
    )
    liveIconBackground = Ti.UI.createView(
      backgroundImage: "images/match/layout/bg-dashboard-buttons-gridview.png"
      top: 0
      left: 0
      height: 83
      width: 82
    )
    liveIcon = Ti.UI.createView(
      backgroundImage: "images/match/buttons/btn-dashboard-live-large.png"
      top: 5
      left: 6
      height: 71
      width: 70
    )
    liveIconLabel = Ti.UI.createLabel(
      color: "#ffffff"
      backgroundColor: "transparent"
      text: "Live"
      top: 80
      height: 20
      width: 82
      textAlign: "center"
      font:
        fontSize: 14
        fontWeight: "bold"
        fontFamily: "HelveticaNeue-Bold"
    )
    liveIcon.addEventListener "click", ->
      unless liveWindowHolder?
        liveWindowHolder = live()
      else
        liveWindowHolder.showLive()
      dashboardWindow.hide()
    
    liveIconBackground.add liveIcon
    liveIconContainer.add liveIconBackground
    liveIconContainer.add liveIconLabel
    rulesIconContainer = Ti.UI.createView(
      left: 108
      top: 255
      height: 102
      width: 82
    )
    rulesIconBackground = Ti.UI.createView(
      backgroundImage: "images/match/layout/bg-dashboard-buttons-gridview.png"
      top: 0
      left: 0
      height: 83
      width: 82
    )
    rulesIcon = Ti.UI.createView(
      backgroundImage: "images/match/buttons/btn-dashboard-rules-large.png"
      top: 5
      left: 6
      height: 71
      width: 70
    )
    rulesIconLabel = Ti.UI.createLabel(
      color: "#ffffff"
      backgroundColor: "transparent"
      text: "Rules"
      top: 80
      height: 20
      width: 82
      textAlign: "center"
      font:
        fontSize: 14
        fontWeight: "bold"
        fontFamily: "HelveticaNeue-Bold"
    )
    rulesIcon.addEventListener "click", ->
      unless rulesWindowHolder?
        rulesWindowHolder = rules()
      else
        rulesWindowHolder.showRules()
      dashboardWindow.hide()
    
    rulesIconBackground.add rulesIcon
    rulesIconContainer.add rulesIconBackground
    rulesIconContainer.add rulesIconLabel
    settingsIconContainer = Ti.UI.createView(
      left: 203
      top: 255
      height: 102
      width: 82
    )
    settingsIconBackground = Ti.UI.createView(
      backgroundImage: "images/match/layout/bg-dashboard-buttons-gridview.png"
      top: 0
      left: 0
      height: 83
      width: 82
    )
    settingsIcon = Ti.UI.createView(
      backgroundImage: "images/match/buttons/btn-dashboard-settings-large.png"
      top: 5
      left: 6
      height: 71
      width: 70
    )
    settingsIconLabel = Ti.UI.createLabel(
      color: "#ffffff"
      backgroundColor: "transparent"
      text: "Settings"
      top: 80
      height: 20
      width: 82
      textAlign: "center"
      font:
        fontSize: 14
        fontWeight: "bold"
        fontFamily: "HelveticaNeue-Bold"
    )
    settingsIcon.addEventListener "click", ->
      unless settingsWindowHolder?
        settingsWindowHolder = settings()
      else
        settingsWindowHolder.showSettings()
      dashboardWindow.hide()
    
    settingsIconBackground.add settingsIcon
    settingsIconContainer.add settingsIconBackground
    settingsIconContainer.add settingsIconLabel
    @gridView.add playIconContainer
    @gridView.add teamsIconContainer
    @gridView.add activityIconContainer
    @gridView.add profileIconContainer
    @gridView.add newsIconContainer
    @gridView.add eventsIconContainer
    @gridView.add liveIconContainer
    @gridView.add rulesIconContainer
    @gridView.add settingsIconContainer
    
root.GridView = GridView