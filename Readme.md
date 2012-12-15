#  Tabbar Ruler
 Matthew L. Fidler
## Library Information
 _tabbar-ruler.el_ --- Setup tabbar to look pretty...

- __Filename__ --  tabbar-ruler.el
- __Description__ --  Changes tabbar setup to be similar to Aquaemacs.
- __Author__ --  Matthew Fidler, Nathaniel Cunningham
- __Maintainer__ --  Matthew L. Fidler
- __Created__ --  Mon Oct 18 17:06:07 2010 (-0500)
- __Version__ --  0.15
- __Last-Updated__ --  Sat Dec 15 15:44:34 2012 (+0800)
- __By__ --  Matthew L. Fidler
- __Update #__ --  663
- __URL__ --  http:__github.com_mlf176f2_tabbar-ruler.el
- __Keywords__ --  Tabbar, Ruler Mode, Menu, Tool Bar.
- __Compatibility__ --  Windows Emacs 23.x
- __Package-Requires__ --  ((tabbar "2.0.1"))

## Introduction
Tabbar ruler is an emacs package that allows both the tabbar and the
ruler to be used together.  In addition it allows auto-hiding of the
menu-bar and tool-bar.


Tabbar appearance based on reverse engineering Aquaemacs code and
changing to my preferences, and Emacs Wiki.

Tabbar/Ruler integration is new. Tabbar should be active on mouse
move.  Ruler should be active on self-insert commands.

Also allows auto-hiding of toolbar and menu.

To use this, put the library in your load path and use


  (setq tabbar-ruler-global-tabbar 't) ; If you want tabbar
  (setq tabbar-ruler-global-ruler 't) ; if you want a global ruler
  (setq tabbar-ruler-popup-menu 't) ; If you want a popup menu.
  (setq tabbar-ruler-popup-toolbar 't) ; If you want a popup toolbar
  
  (require 'tabbar-ruler)
  



## Known issues
the left arrow is text instead of an image.
## History

- __15-Dec-2012__ --   Attempt to fix another bug on load (Matthew L. Fidler)
- __14-Dec-2012__ --   Fixed tabbar ruler so that it loads cold. (Matthew L. Fidler)
- __14-Dec-2012__ --   Memoized the tabbar images to speed things up (Matthew L. Fidler)
- __14-Dec-2012__ --   Upload to Marmalade  (Mat``thew L. Fidler)
- __14-Dec-2012__ --   Fancy tabs (Matthew L. Fidler)
- __13-Dec-2012__ --   Added Bug fix for coloring. Made the selected tab match the default color in the buffer. Everything else is grayed out. (Matthew L. Fidler)
- __10-Dec-2012__ --   Took out a statement that may fix the left-scrolling bug? (Matthew L. Fidler)
- __10-Dec-2012__ --   Added package-menu-mode to the excluded tabbar-ruler fight modes. (Matthew L. Fidler)
- __07-Dec-2012__ --   Will no longer take over editing of org source blocks or info blocks. (Matthew L. Fidler)
- __07-Dec-2012__ --   Changed the order of checking so that helm will work when you move a mouse. (Matthew L. Fidler)
- __07-Dec-2012__ --   Now works with Helm. Should fix issue #1 (Matthew L. Fidler)
- __06-Dec-2012__ --   Now colors are based on loaded theme (from minibar). Also added bug-fix for setting tabbar colors every time a frame opens. Also added a bug fix for right-clicking a frame that is not associated with a buffer. 1-Mar-2012 Matthew L. Fidler Last-Updated: Thu Mar 1 08:38:09 2012 (-0600) #656 (Matthew L. Fidler) Will not change tool-bar-mode in Mac. It causes some funny things to happen. 9-Feb-2012 Matthew L. Fidler Last-Updated: Thu Feb 9 19:18:21 2012 (-0600) #651 (Matthew L. Fidler) Will not change the menu bar in a Mac. Its always there. (Matthew L. Fidler)
- __14-Jan-2012__ --   Added more commands that trigger the ruler. (Matthew L. Fidler)
- __14-Jan-2012__ --   Added more ruler commands. It works a bit better now. Additionally I have changed the ep- to tabbar-ruler-. (Matthew L. Fidler)
- __14-Jan-2012__ --   Changed EmacsPortable to tabbar-ruler (Matthew L. Fidler)
- __08-Feb-2011__ --   Added ELPA tags.  (Matthew L. Fidler)
- __08-Feb-2011__ --   Removed xpm dependencies. Now no images are required, they are built by the library. (Matthew L. Fidler)
- __04-Dec-2010__ --   Added context menu. (Matthew L. Fidler)
- __01-Dec-2010__ --   Added scratch buffers to list. (Matthew L. Fidler)
- __04-Nov-2010__ --   Made tabbar mode default. (us041375)
- __02-Nov-2010__ --   Make post-command-hook handle errors gracefully. (Matthew L. Fidler)
- __20-Oct-2010__ --   Changed behavior when outside the window to assume the last known mouse position. This fixes the two problems below.  (us041375)
- __20-Oct-2010__ --   As it turns out when the toolbar is hidden when the mouse is outside of the emacs window, it also hides when navigating the menu. Switching behavior back.  (us041375)
- __20-Oct-2010__ --   Made popup menu and toolbar be hidden when mouse is oustide of emacs window. (us041375)
- __20-Oct-2010__ --   Changed to popup ruler-mode if tabbar and ruler are not displayed. (us041375)
- __19-Oct-2010__ --   Changed tabbar, menu, toolbar and ruler variables to be buffer or frame local.  (Matthew L. Fidler)
