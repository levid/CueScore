tabGroup = Ti.UI.createTabGroup({ barColor:'#336699'})
Ti.UI.setBackgroundColor('#000')
 
# Attach the window instance to root so we can get to it from anywhere 
root.Win1 = new root.GenericWindow('Win1','I am Window 1')
 
tab1 = Ti.UI.createTab({
  icon:'KS_nav_views.png',
  title:'Win1',
  window: root.Win1.win
})
tabGroup.addTab(tab1)
 
# Attach the window instance to root so we can get to it from anywhere 
root.Win2 = new root.GenericWindow('Win2','I am Window 2')
 
tab2 = Ti.UI.createTab({
  icon:'KS_nav_views.png',
  title:'Win2',
  window: root.Win2.win
})
tabGroup.addTab(tab2)
 
tabGroup.open({transition:Ti.UI.iPhone.AnimationStyle.FLIP_FROM_LEFT})
