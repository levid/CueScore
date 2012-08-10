root = @

# This file is the entry point for the application. It sets up the four main
# tab windows.
# The `CueScore` object provides common access to app data, API wrapper and UI utilities

# CueScore
CueScore = root.CueScore =
  API: {}
  App: {}
  Controllers: 
    DashboardController: {}
  Models:
    Game: {}
  Helpers:  {}
  Views:
    Dashboard: {}
    Settings: {}
    Sample: {}
    Play: {}
    Teams: {}
    Activity: {}
    Profile: {}
    News: {}
    Events: {}
    Login: {}
    Live: {}
    Rules: {}
    PostView: {}
    PostsView: {}
  Utils:
    QueryStringBuilder: {}
  Window: {}

# Alias, so you could do $.App.init() below. If you have an API class,
# make sure to either use the full app name or declare the below at the top
# and use $.API for the class name. Uncomment to use.
$CS = CueScore

# Include your libraries like:
# Ti.include('vendor/date.js')
# Ti.include('vendor/underscore.js')
# Ti.include('vendor/backbone.js')
Ti.include('vendor/tiquery/tiquery.js')
Ti.include('vendor/underscore/underscore-min.js')
Ti.include('vendor/backbone/backbone-min.js')
Ti.include('vendor/backbone/backbone.sync.js')
Ti.include('js/utils/query_string_builder.js')

# Include main app
Ti.include('cuescore.js')

# Initialize App
# $CS.App.initTabGroup()
$CS.App.init()

# window = $.Views.Login.createLoginWindow()
# window.open()
