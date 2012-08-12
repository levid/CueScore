class ListView extends $CS.Views.Dashboard
  defaults: {}
  
  constructor: () ->
    _.extend @, @defaults
    
    listView = Ti.UI.createView(
      backgroundColor: "#000000"
      top: 0
      isNinePatch: false
    )
    
$CS.Views.Dashboard.ListView = ListView