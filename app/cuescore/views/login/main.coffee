$CS.Views.Login.createLoginWindow = (options={}) ->
  window = Ti.UI.createWindow(options)

  button = Titanium.UI.createButton
    title: 'I am a Button'
    height: 40
    width: 200
    top: 10
  window.add button

  # methods
  say = (msg) ->
    alert(msg)

  # event handlers
  button.addEventListener 'click', ->
    say('hello')

  window