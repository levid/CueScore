class DataService
  defaults: {}

  constructor: (options = {}) ->
    _.extend @, @defaults
    
    email: "i.wooten@gmail.com"
    @db = @openDatabase()
    
  undoMatch: (originalId) ->
    try
      row = @db.execute("SELECT ID,OriginalId,Match FROM Matches WHERE OriginalId = " + originalId + " OR ID = " + originalId + " ORDER BY ID DESC LIMIT 1 OFFSET 1")
      unless row.isValidRow()
        row.close()
        @db.close()
        return null
      match = (new Function("return" + row.fieldByName("Match"))())
      match.OriginalId = originalId
      @db.execute "DELETE FROM Matches WHERE OriginalId = " + originalId + " AND ID > " + row.fieldByName("ID") + " AND ID != OriginalId"
      row.close()
      @db.close()
      return match
    catch e
      row.close()
      @db.close()

  saveMatch: (match, setOriginalIdCallback) ->
    try
      if not match.OriginalId? or match.OriginalId is 0
        leagueMatch.SmallJSON = true
        @db.execute "INSERT INTO Matches (Match, EnteredDateTime) VALUES(?, ?)", @convertToJSONString(match), "DATETIME(NOW)"
        setOriginalIdCallback @db.lastInsertRowId
        @db.execute "UPDATE Matches SET OriginalId = " + @db.lastInsertRowId + " WHERE ID = " + @db.lastInsertRowId
        @db.close()
        return
      Ti?.API.log "@db rounded OId", parseInt(match.OriginalId)
      @db.execute "INSERT INTO Matches (OriginalId, Match, EnteredDateTime) VALUES(?, ?, ?)", match.OriginalId.toString(), @convertToJSONString(match), "DATETIME(NOW)"
      @db.close()
      return
    catch e
      @db.close()

  getLeagueMatch: (leagueMatchId) ->
    try
      row = @db.execute("SELECT LeagueMatch FROM LeagueMatches WHERE ID = " + leagueMatchId)
      leagueMatch = (new Function("return" + row.fieldByName("LeagueMatch"))())
      leagueMatch.LeagueMatchId = leagueMatchId
      row.close()
      @db.close()
      return leagueMatch
    catch e
      row.close()
      @db.close()

  saveLeagueMatch: (leagueMatch, setLeagueMatchIdCallback) ->
    try
      Ti?.API.log @convertToJSONString(leagueMatch)
      if not leagueMatch.LeagueMatchId? or leagueMatch.LeagueMatchId is 0
        leagueMatch.SmallJSON = true
        @db.execute "INSERT INTO LeagueMatches (LeagueMatch, EnteredDateTime) VALUES(?, ?)", @convertToJSONString(leagueMatch), "DATETIME(NOW)"
        setLeagueMatchIdCallback @db.lastInsertRowId
        @db.close()
        return
      @db.execute "UPDATE LeagueMatches SET SET LeagueMatch = " + @convertToJSONString(leagueMatch) + " WHERE ID = " + leagueMatch.LeagueMatchId
      setLeagueMatchIdCallback @db.lastInsertRowId
      @db.close()
      return
    catch e
      @db.close()

  sendSignature: (imageData) ->
    xhr = Ti?.Network.createHTTPClient()
    xhr.setTimeout 9999999
    xhr.onload = ->
      Ti?.API.info "in utf-8 onload for POST"
      Ti?.API.info @responseText
      Ti?.UI.createAlertDialog(
        title: "Success:"
        message: @responseText
      ).show()

    xhr.onerror = (e) ->
      Ti?.API.info "in utf-8 error for POST"
      Ti?.API.info e.error
      Ti?.UI.createAlertDialog(
        title: "Error:"
        message: e.error
      ).show()

    xhr.open "POST", "http://cuescoreapp.com/signature/post/"
    xhr.send
      teamid: "new"
      matchid: "new"
      gametype: null
      playerid: "new"
      mimetype: "png"
      imagedata: imageData.data

  sendLeagueMatch: (leagueMatch) ->
    xhr = Ti?.Network.createHTTPClient(timeout: 9999999999999)
    xhr.onload = ->
      Ti?.API.info "in utf-8 onload for POST"
      Ti?.API.info @responseText
      Ti?.UI.createAlertDialog(
        title: "Success:"
        message: @responseText
      ).show()

    xhr.onerror = (e) ->
      Ti?.API.info "in utf-8 error for POST"
      Ti?.API.info e.error
      Ti?.UI.createAlertDialog(
        title: "Error:"
        message: e.error
      ).show()

    xhr.open "POST", "http://cuescoreapp.com/leaguematch/post/"
    xhr.send
      userid: "123"
      apikey: "secret"
      format: "json"
      sendToEmail: @email
      matchid: "new"
      matchdata: @convertToJSONString(leagueMatch)
      gametype: @.leagueMatch.GameType

  setupLocalDatabase: ->
    @db = @openDatabase()
    @db.execute "CREATE TABLE IF NOT EXISTS LeagueMatches (ID INTEGER PRIMARY KEY, LeagueMatch BLOB, Sent BOOLEAN, EnteredDateTime DATETIME)"
    @db.execute "CREATE TABLE IF NOT EXISTS Matches (ID INTEGER PRIMARY KEY, OriginalId Integer, LeagueMatchId Integer, Match BLOB, EnteredDateTime DATETIME)"
    @db.execute "DELETE FROM LeagueMatches"
    @db.execute "DELETE FROM Matches"
    @db.close()

  openDatabase: ->
    if Ti? then Ti.Database.open "CueScore" else close: ->
  convertToJSONString: (myObject) ->
    JSON.stringify myObject

  parseJSONString: (myJSONtext, emptyObject) ->
    emptyObject.fromJSON myJSONtext

  var_dump: (obj) ->
    if typeof obj is "object"
      "Type: " + typeof (obj) + (if (obj.constructor) then "\nConstructor: " + obj.constructor else "") + "\nValue: " + obj
    else
      "Type: " + typeof (obj) + "\nValue: " + obj
      
$CS.Utilities.DataService = DataService