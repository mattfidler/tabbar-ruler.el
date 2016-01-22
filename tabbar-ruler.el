;;; tabbar-ruler.el --- Pretty tabbar, autohide, use both tabbar/ruler
;;
;; Filename: tabbar-ruler.el
;; Description: Changes tabbar setup to be similar to Aquaemacs.
;; Author: Matthew Fidler, Ta Quang Trung, Nathaniel Cunningham
;; Maintainer: Matthew L. Fidler
;; Created: Mon Oct 18 17:06:07 2010 (-0500)
;; Version: 0.45
;; Last-Updated: Sat Dec 15 15:44:34 2012 (+0800)
;;           By: Matthew L. Fidler
;;     Update #: 663
;; URL: http://github.com/mlf176f2/tabbar-ruler.el
;; Keywords: Tabbar, Ruler Mode, Menu, Tool Bar.
;; Compatibility: Windows Emacs 23.x
;; Package-Requires: ((tabbar "2.0.1") (powerline "2.3") (mode-icons "0.1.0"))
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;; Commentary:
;; 
;; * Introduction
;; Tabbar ruler is an emacs package that allows both the tabbar and the
;; ruler to be used together.  In addition it allows auto-hiding of the
;; menu-bar and tool-bar.
;; 
;; 
;; Tabbar appearance based on reverse engineering Aquaemacs code and
;; changing to my preferences, and Emacs Wiki.
;; 
;; Tabbar/Ruler integration is new. Tabbar should be active on mouse
;; move.  Ruler should be active on self-insert commands.
;; 
;; Also allows auto-hiding of toolbar and menu.
;; 
;; To use this, put the library in your load path and use
;; 
;; 
;;   (setq tabbar-ruler-global-tabbar t) ; If you want tabbar
;;   (setq tabbar-ruler-global-ruler t) ; if you want a global ruler
;;   (setq tabbar-ruler-popup-menu t) ; If you want a popup menu.
;;   (setq tabbar-ruler-popup-toolbar t) ; If you want a popup toolbar
;;   (setq tabbar-ruler-popup-scrollbar t) ; If you want to only show the
;;                                         ; scroll bar when your mouse is moving.
;;   (require 'tabbar-ruler)
;;   
;; 
;; 
;; 
;; * Changing how tabbar groups files/buffers
;; The default behavior for tabbar-ruler is to group the tabs by frame.
;; You can change this back to the old-behavior by:
;; 
;;   (tabbar-ruler-group-buffer-groups)
;; 
;; or by issuing the following code:
;; 
;; 
;;   (setq tabbar-buffer-groups-function 'tabbar-buffer-groups)
;; 
;; 
;; In addition, you can also group by projectile project easily by:
;; 
;; 
;;   (tabbar-ruler-group-by-projectile-project)
;; 
;; * Adding key-bindings to tabbar-ruler
;; You can add key-bindings to change the current tab.  The easiest way
;; to add the bindings is to add a key like:
;; 
;; 
;;   (global-set-key (kbd "C-c t") 'tabbar-ruler-move)
;; 
;; 
;; After that, all you would need to press is Control+c t and then the
;; arrow keys will allow you to change the buffer quite easily.  To exit
;; the buffer movement you can press enter or space.
;; 
;; * Known issues
;; the left arrow is text instead of an image.
;; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;; Change Log:
;; 13-Sep-2014    Matthew L. Fidler  
;;    Last-Updated: Sat Dec 15 15:44:34 2012 (+0800) #663 (Matthew L. Fidler)
;;    Version bump
;; 1-Jul-2013    Matthew L. Fidler  
;;    Last-Updated: Sat Dec 15 15:44:34 2012 (+0800) #663 (Matthew L. Fidler)
;;    Fix variable misspecification
;; 28-Jun-2013    Matthew L. Fidler  
;;    Last-Updated: Sat Dec 15 15:44:34 2012 (+0800) #663 (Matthew L. Fidler)
;;    Fixed strange org-readme issue
;; 28-Jun-2013    Matthew L. Fidler  
;;    Last-Updated: Tue Oct 19 15:37:53 2010 (-0500) (us041375) #663 (Matthew L. Fidler)
;;    Added popup scrollbarbar 
;; 27-Jun-2013    Matthew L. Fidler  
;;    Last-Updated: Sat Dec 15 15:44:34 2012 (+0800) #663 (Matthew L. Fidler)
;;    Added autoload for tabbar-install-faces.  That way ergoemacs and other
;;    packages can load the tabbar-ruler by just calling (tabbar-install-faces)
;; 6-Jun-2013    Matthew L. Fidler  
;;    Last-Updated: Sat Dec 15 15:44:34 2012 (+0800) #663 (Matthew L. Fidler)
;;    Added left-char and right char to tabbar-ruler-move-keymap so that
;;    keybindings in emacs 24.3 work correctly.
;; 6-Jun-2013    Matthew L. Fidler  
;;    Last-Updated: Sat Dec 15 15:44:34 2012 (+0800) #663 (Matthew L. Fidler)
;;    Changed movement commands.  The movement commands are simpler (in my opinion)
;; 4-Jun-2013    Matthew L. Fidler  
;;    Last-Updated: Sat Dec 15 15:44:34 2012 (+0800) #663 (Matthew L. Fidler)
;;    Change package description.  Fixed the documentation to actually
;;    change to the old tabbar method of grouping buffers.
;; 4-Jun-2013    Matthew L. Fidler  
;;    Last-Updated: Sat Dec 15 15:44:34 2012 (+0800) #663 (Matthew L. Fidler)
;;    Turn off ruler mode in the next buffer (if necessary)
;; 4-Jun-2013    Matthew L. Fidler  
;;    Last-Updated: Sat Dec 15 15:44:34 2012 (+0800) #663 (Matthew L. Fidler)
;;    Add movement keys.  Also add toggles for different groupings.
;; 1-May-2013    Matthew L. Fidler  
;;    Last-Updated: Sat Dec 15 15:44:34 2012 (+0800) #663 (Matthew L. Fidler)
;;    Try to address issue #4
;; 1-May-2013    Matthew L. Fidler  
;;    Last-Updated: Sat Dec 15 15:44:34 2012 (+0800) #663 (Matthew L. Fidler)
;;    Changed the modified font to italics.  Made the modified symbol
;;    customizable, but off by default.  Should address issue #5.
;; 5-Apr-2013    Matthew L. Fidler  
;;    Last-Updated: Sat Dec 15 15:44:34 2012 (+0800) #663 (Matthew L. Fidler)
;;    Trying to update upstream sources.
;; 5-Apr-2013    Matthew L. Fidler  
;;    Last-Updated: Sat Dec 15 15:44:34 2012 (+0800) #663 (Matthew L. Fidler)
;;    Fixed speed issues on windows.  It wasn't a redraw that was causing
;;    the speed issues, it was the constant recreation of the right-click
;;    menus... 
;; 27-Mar-2013    Matthew L. Fidler  
;;    Last-Updated: Sat Dec 15 15:44:34 2012 (+0800) #663 (Matthew L. Fidler)
;;    Fixed typo to fix issue #2.
;; 27-Mar-2013    Matthew L. Fidler  
;;    Last-Updated: Sat Dec 15 15:44:34 2012 (+0800) #663 (Matthew L. Fidler)
;;    Attempt to fix issue #2.  Whenever the color is not a string, assume
;;    that it should be transparent.  I'm unsure if the mac osx puts the
;;    translated color to a string.  However, it seems that the undefined
;;    should be the same as transparent.  Therefore, this fix *should* work...
;; 20-Mar-2013    Matthew L. Fidler  
;;    Last-Updated: Sat Dec 15 15:44:34 2012 (+0800) #663 (Matthew L. Fidler)
;;    Add inverse video option for unselected tabbar.  Made it the default.
;;    has better contrast between the selected and unselected tabs.
;; 20-Mar-2013    Matthew L. Fidler  
;;    Last-Updated: Sat Dec 15 15:44:34 2012 (+0800) #663 (Matthew L. Fidler)
;;    Changed emacs 24.3 to support the times character.  Also removed
;;    starred documentation strings.
;; 20-Mar-2013    Matthew L. Fidler  
;;    Last-Updated: Sat Dec 15 15:44:34 2012 (+0800) #663 (Matthew L. Fidler)
;;    Emacs 24.3 had an error when using ucs-insert.  Added fallbacks so
;;    that this works when ucs-insert does not work.
;; 20-Feb-2013    Matthew L. Fidler  
;;    Last-Updated: Sat Dec 15 15:44:34 2012 (+0800) #663 (Matthew L. Fidler)
;;    Changed so that the separators do not need to be fancy images.  I
;;    found that when the separators were images, it slowed down emacs on
;;    windows.  Therefore, the fancy images are disabled by default.  This
;;    also includes the stylized close symbols.
;; 19-Dec-2012    Matthew L. Fidler  
;;    Last-Updated: Sat Dec 15 15:44:34 2012 (+0800) #663 (Matthew L. Fidler)
;;    Added back popup-menu
;; 19-Dec-2012    Matthew L. Fidler
;;    Last-Updated: Sat Dec 15 15:44:34 2012 (+0800) #663 (Matthew L. Fidler)
;;    Upload to marmalade
;; 19-Dec-2012    Matthew L. Fidler  
;;    Last-Updated: Sat Dec 15 15:44:34 2012 (+0800) #663 (Matthew L. Fidler)
;;    Changed slope.  Made the background color the default background color
;;    if unspecified.  Made tabbar-hex-color return "None" if not defined
;; 15-Dec-2012    Matthew L. Fidler  
;;    Last-Updated: Sat Dec 15 15:44:34 2012 (+0800) #663 (Matthew L. Fidler)
;;    Made sure that the tabbr-ruler-separator-image is at least 17 pixels high
;; 15-Dec-2012    Matthew L. Fidler  
;;    Last-Updated: Sat Dec 15 15:44:34 2012 (+0800) #663 (Matthew L. Fidler)
;;    Attempt to fix another bug on load
;; 14-Dec-2012    Matthew L. Fidler  
;;    Last-Updated: Thu Mar  1 09:02:56 2012 (-0600) #659 (Matthew L. Fidler)
;;    Fixed tabbar ruler so that it loads cold.
;; 14-Dec-2012    Matthew L. Fidler  
;;    Last-Updated: Thu Mar  1 09:02:56 2012 (-0600) #659 (Matthew L. Fidler)
;;    Memoized the tabbar images to speed things up
;; 14-Dec-2012    Matthew L. Fidler  
;;    Last-Updated: Thu Mar  1 09:02:56 2012 (-0600) #659 (Mat`'thew L. Fidler)
;;    Upload to Marmalade 
;; 14-Dec-2012    Matthew L. Fidler  
;;    Last-Updated: Thu Mar  1 09:02:56 2012 (-0600) #659 (Matthew L. Fidler)
;;    Fancy tabs
;; 13-Dec-2012    Matthew L. Fidler  
;;    Last-Updated: Thu Mar  1 09:02:56 2012 (-0600) #659 (Matthew L. Fidler)
;;    Added Bug fix for coloring.  Made the selected tab match the default
;;    color in the buffer.  Everything else is grayed out.
;; 10-Dec-2012    Matthew L. Fidler  
;;    Last-Updated: Thu Mar  1 09:02:56 2012 (-0600) #659 (Matthew L. Fidler)
;;    Took out a statement that may fix the left-scrolling bug?
;; 10-Dec-2012    Matthew L. Fidler  
;;    Last-Updated: Thu Mar  1 09:02:56 2012 (-0600) #659 (Matthew L. Fidler)
;;    Added package-menu-mode to the excluded tabbar-ruler fight modes.
;; 07-Dec-2012    Matthew L. Fidler  
;;    Last-Updated: Thu Mar  1 09:02:56 2012 (-0600) #659 (Matthew L. Fidler)
;;    Will no longer take over editing of org source blocks or info blocks.
;; 07-Dec-2012    Matthew L. Fidler
;;    Last-Updated: Thu Mar  1 09:02:56 2012 (-0600) #659 (Matthew L. Fidler)
;;    Changed the order of checking so that helm will work when you move a mouse.
;; 07-Dec-2012    Matthew L. Fidler  
;;    Last-Updated: Thu Mar  1 09:02:56 2012 (-0600) #659 (Matthew L. Fidler)
;;    Now works with Helm.  Should fix issue #1
;; 06-Dec-2012    Matthew L. Fidler  
;;    Last-Updated: Thu Mar  1 09:02:56 2012 (-0600) #659 (Matthew L. Fidler)
;;    Now colors are based on loaded theme (from minibar).  Also added
;;    bug-fix for setting tabbar colors every time a frame opens.  Also
;;    added a bug fix for right-clicking a frame that is not associated with
;;    a buffer.
;; 1-Mar-2012    Matthew L. Fidler
;;    Last-Updated: Thu Mar  1 08:38:09 2012 (-0600) #656 (Matthew L. Fidler)
;;    Will not change tool-bar-mode in Mac.  It causes some funny
;;    things to happen.
;; 9-Feb-2012    Matthew L. Fidler  
;;    Last-Updated: Thu Feb  9 19:18:21 2012 (-0600) #651 (Matthew L. Fidler)
;;    Will not change the menu bar in a Mac.  Its always there.
;; 14-Jan-2012    Matthew L. Fidler  
;;    Last-Updated: Sat Jan 14 21:58:51 2012 (-0600) #648 (Matthew L. Fidler)
;;    Added more commands that trigger the ruler.
;; 14-Jan-2012    Matthew L. Fidler  
;;    Last-Updated: Sat Jan 14 21:44:32 2012 (-0600) #641 (Matthew L. Fidler)
;;    Added more ruler commands.   It works a bit better
;;    now. Additionally I have changed the ep- to tabbar-ruler-.
;; 14-Jan-2012    Matthew L. Fidler  
;;    Last-Updated: Tue Feb  8 15:01:27 2011 (-0600) #639 (Matthew L. Fidler)
;;    Changed EmacsPortable to tabbar-ruler
;; 08-Feb-2011    Matthew L. Fidler  
;;    Last-Updated: Tue Feb  8 14:59:57 2011 (-0600) #638 (Matthew L. Fidler)
;;    Added ELPA tags.  
;; 08-Feb-2011    Matthew L. Fidler  
;;    Last-Updated: Tue Feb  8 12:47:09 2011 (-0600) #604 (Matthew L. Fidler)
;;    Removed xpm dependencies.  Now no images are required, they are built by the library.
;; 04-Dec-2010    Matthew L. Fidler  
;;    Last-Updated: Sat Dec  4 16:27:07 2010 (-0600) #551 (Matthew L. Fidler)
;;    Added context menu.
;; 01-Dec-2010    Matthew L. Fidler  
;;    Last-Updated: Wed Dec  1 15:26:37 2010 (-0600) #341 (Matthew L. Fidler)
;;    Added scratch buffers to list.
;; 04-Nov-2010
;;    Last-Updated: Thu Nov  4 09:39:14 2010 (-0500) (us041375)
;;    Made tabbar mode default.
;; 02-Nov-2010    Matthew L. Fidler
;;    Last-Updated: Tue Nov  2 10:14:12 2010 (-0500) (Matthew L. Fidler)
;;    Make post-command-hook handle errors gracefully.
;; 20-Oct-2010    Matthew L. Fidler
;;    Last-Updated: Tue Oct 19 15:37:53 2010 (-0500) (us041375)
;;
;;    Changed behavior when outside the window to assume the last
;;    known mouse position. This fixes the two problems below.
;;
;; 20-Oct-2010    Matthew L. Fidler
;;    Last-Updated: Tue Oct 19 15:37:53 2010 (-0500) (us041375)
;;
;;    As it turns out when the toolbar is hidden when the mouse is
;;    outside of the emacs window, it also hides when navigating the
;;    menu.  Switching behavior back.
;;
;; 20-Oct-2010    Matthew L. Fidler
;;    Last-Updated: Tue Oct 19 15:37:53 2010 (-0500) (us041375)
;;    Made popup menu and toolbar be hidden when mouse is oustide of emacs window.
;; 20-Oct-2010    Matthew L. Fidler
;;    Last-Updated: Tue Oct 19 15:37:53 2010 (-0500) (us041375)
;;    Changed to popup ruler-mode if tabbar and ruler are not displayed.
;; 19-Oct-2010    Matthew L. Fidler
;;    Last-Updated: Tue Oct 19 15:37:53 2010 (-0500) (us041375)
;;    Changed tabbar, menu, toolbar and ruler variables to be buffer
;;    or frame local.
;;
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; This program is free software; you can redistribute it and/or
;; modify it under the terms of the GNU General Public License as
;; published by the Free Software Foundation; either version 3, or
;; (at your option) any later version.
;;
;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
;; General Public License for more details.
;;
;; You should have received a copy of the GNU General Public License
;; along with this program; see the file COPYING.  If not, write to
;; the Free Software Foundation, Inc., 51 Franklin Street, Fifth
;; Floor, Boston, MA 02110-1301, USA.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;; Code:

(add-to-list 'load-path (file-name-directory (or load-file-name (buffer-file-name))))

(require 'cl)
(require 'tabbar)
(require 'easymenu)
(require 'powerline)
(require 'mode-icons nil t)

(defgroup tabbar-ruler nil
  "Pretty tabbar, autohide, use both tabbar/ruler."
  :group 'tabbar)

(defcustom tabbar-ruler-global-tabbar 't
  "Should tabbar-ruler have a global tabbar?"
  :type 'boolean
  :group 'tabbar-ruler)
(defcustom tabbar-ruler-global-ruler nil
  "Should tabbar-ruler have a global ruler?"
  :type 'boolean
  :group 'tabbar-ruler)
(defcustom tabbar-ruler-popup-menu nil
  "Should tabbar-ruler have a popup menu.  As mouse moves toward top of window, the menu pops up."
  :type 'boolean
  :group 'tabbar-ruler)
(defcustom tabbar-ruler-popup-toolbar nil
  "Should tabbar-ruler have a popup toolbar.  As mouse moves toward top of window, the toolbar pops up."
  :type 'boolean
  :group 'tabbar-ruler)

(defcustom tabbar-ruler-popup-scrollbar nil
  "Should tabbas-ruler have popup scrollbar.  As mouse moves, the scroll-bar pops up.  Otherwise the sroll-bar is turned off."
  :type 'boolean
  :group 'tabbar-ruler)

(defcustom tabbar-ruler-popup-menu-min-y 5 ;
  "Minimum number of pixels from the top before a menu/toolbar pops up."
  :type 'integer
  :group 'tabbar-ruler)
(defcustom tabbar-ruler-popup-menu-min-y-leave 50
  "Minimum number of pixels form the top before a menu/toolbar disappears."
  :type 'integer
  :group 'tabbar-ruler)
(defcustom tabbar-ruler-do-not-switch-on-ruler-when-tabbar-is-on-y 75
  "Minimum number of pixels to switch on ruler when tabbar is on."
  :type 'integer
  :group 'tabbar-ruler)

(defcustom tabbar-ruler-excluded-buffers '("*Messages*" "*Completions*" "*ESS*")
  "Excluded buffers in tabbar."
  :type '(repeat (string :tag "Buffer Name"))
  :group 'tabbar-ruler)

(defcustom tabbar-ruler-fight-igore-modes '(info-mode helm-mode package-menu-mode)
  "Exclude these mode when changing between tabbar and ruler."
  :type '(repeat (symbol :tag "Major Mode"))
  :group 'tabbar-ruler)

(defcustom tabbar-ruler-use-mode-icons t
  "Use Mode icons for tabbar-ruler"
  :type 'boolean
  :group 'tabbar-ruler)

(defcustom tabbar-ruler-mode-icon-for-unknown-modes nil
  "Use mode icons for unknown modes."
  :type 'boolean
  :group 'tabbar-ruler)

(defcustom tabbar-ruler-fancy-tab-separator nil
  "Separate each tab with a fancy generated image."
  :type '(choice
	  (const :tag "Text" nil)
	  (const :tag "Alternate" alternate)
	  (const :tag "arrow" arrow)
	  (const :tag "arrow-fade" arrow-fade)
	  (const :tag "bar" bar)
	  (const :tag "box" box)
	  (const :tag "brace" brace)
	  (const :tag "butt" butt)
	  (const :tag "chamfer" chamfer)
	  (const :tag "contour" contour)
	  (const :tag "curve" curve)
	  (const :tag "rounded" rounded)
	  (const :tag "roundstub" roundstub)
	  (const :tag "slant" slant)
	  (const :tag "wave" wave)
	  (const :tag "zigzag" zigzag))
  :group 'tabbar-ruler)


(defcustom tabbar-ruler-fancy-current-tab-separator 'inherit
  "The current tab can have a different separator."
  :type '(choice
	  (const :tag "Inherit" inherit)
	  (const :tag "Text" nil)
	  (const :tag "Alternate" alternate)
	  (const :tag "arrow" arrow)
	  (const :tag "arrow-fade" arrow-fade)
	  (const :tag "bar" bar)
	  (const :tag "box" box)
	  (const :tag "brace" brace)
	  (const :tag "butt" butt)
	  (const :tag "chamfer" chamfer)
	  (const :tag "contour" contour)
	  (const :tag "curve" curve)
	  (const :tag "rounded" rounded)
	  (const :tag "roundstub" roundstub)
	  (const :tag "slant" slant)
	  (const :tag "wave" wave)
	  (const :tag "zigzag" zigzag))
  :group 'tabbar-ruler)

(defcustom tabbar-ruler-tab-padding 2
  "Separate each tab with this padding.
This is only enabled whin `tabbar-ruler-fancy-tab-separator' is non-nil"
  :type '(choice
	  (const :tag "No padding" nil)
	  (integer :tag "Padding in pixels"))
  :group 'tabbar-ruler)

(defcustom tabbar-ruler-padding-face nil
  "Color/Face of padding."
  :type '(choice
	  (face :tag "Face")
	  (const :tag "Background color" nil)
	  (color :tag "Color"))
  :group 'tabbar-ruler)

(defcustom tabbar-ruler-pad-selected t
  "Pad selected tab."
  :type 'boolean
  :group 'tabbar-ruler)

(defcustom tabbar-ruler-tab-height 25
  "Height for tabbar-ruler's separations."
  :type '(choice
	  (const :tag "Height of Text" nil)
	  (integer :tag "Overriding Height"))
  :group 'tabbar-ruler)


(defcustom tabbar-ruler-fancy-close-image nil
  "Use an image for the close"
  :type 'boolean
  :group 'tabbar-ruler)

(defcustom tabbar-ruler-movement-timer-delay 0.1
  "Timer Delay for `tabbar-ruler-movement-timer'"
  :type 'number
  :group 'tabbar-ruler)

(defvar tabbar-close-tab-function nil
  "Function to call to close a tabbar tab.  Passed a single argument, the tab
construct to be closed.")

(defvar tabbar-new-tab-function nil
  "Function to call to create a new buffer in tabbar-mode.  Optional single
argument is the MODE for the new buffer.")

(defvar tabbar-last-tab nil)
(defvar tabbar-ruler-keep-tabbar nil)


(defvar mode-icon-unknown
  "/* XPM */
static char * c:\tmp\emacs_xpm[] = {
\"16 16 103 2\",
\"  	c None\",
\". 	c #707070\",
\"+ 	c #717171\",
\"@ 	c #727272\",
\"# 	c #6C6C6C\",
\"$ 	c #696969\",
\"% 	c #6E6E6E\",
\"& 	c #7C7C7C\",
\"* 	c #858585\",
\"= 	c #969696\",
\"- 	c #A3A3A3\",
\"; 	c #A7A7A7\",
\"> 	c #9A9A9A\",
\", 	c #747474\",
\"' 	c #838383\",
\") 	c #A5A5A5\",
\"! 	c #ACACAC\",
\"~ 	c #A8A8A8\",
\"{ 	c #A9A9A9\",
\"] 	c #B0B0B0\",
\"^ 	c #C5C5C5\",
\"/ 	c #F5F5F5\",
\"( 	c #D8D8D8\",
\"_ 	c #777777\",
\": 	c #C6C6C6\",
\"< 	c #F7F7F7\",
\"[ 	c #F1F1F1\",
\"} 	c #F2F2F2\",
\"| 	c #ECECEC\",
\"1 	c #E4E4E4\",
\"2 	c #DEDEDE\",
\"3 	c #F4F4F4\",
\"4 	c #FBFBFB\",
\"5 	c #8F8F8F\",
\"6 	c #6B6B6B\",
\"7 	c #AFAFAF\",
\"8 	c #F3F3F3\",
\"9 	c #E8E8E8\",
\"0 	c #C4C4C4\",
\"a 	c #CCCCCC\",
\"b 	c #D3D3D3\",
\"c 	c #B7B7B7\",
\"d 	c #737373\",
\"e 	c #757575\",
\"f 	c #828282\",
\"g 	c #909090\",
\"h 	c #C3C3C3\",
\"i 	c #EEEEEE\",
\"j 	c #BDBDBD\",
\"k 	c #A1A1A1\",
\"l 	c #979797\",
\"m 	c #888888\",
\"n 	c #8B8B8B\",
\"o 	c #959595\",
\"p 	c #BCBCBC\",
\"q 	c #E6E6E6\",
\"r 	c #C7C7C7\",
\"s 	c #8A8A8A\",
\"t 	c #818181\",
\"u 	c #7A7A7A\",
\"v 	c #BABABA\",
\"w 	c #D1D1D1\",
\"x 	c #DBDBDB\",
\"y 	c #D7D7D7\",
\"z 	c #DCDCDC\",
\"A 	c #F0F0F0\",
\"B 	c #7E7E7E\",
\"C 	c #6F6F6F\",
\"D 	c #A2A2A2\",
\"E 	c #F6F6F6\",
\"F 	c #EBEBEB\",
\"G 	c #D0D0D0\",
\"H 	c #BEBEBE\",
\"I 	c #BFBFBF\",
\"J 	c #A6A6A6\",
\"K 	c #7D7D7D\",
\"L 	c #787878\",
\"M 	c #6D6D6D\",
\"N 	c #D2D2D2\",
\"O 	c #8C8C8C\",
\"P 	c #868686\",
\"Q 	c #878787\",
\"R 	c #848484\",
\"S 	c #C2C2C2\",
\"T 	c #7F7F7F\",
\"U 	c #949494\",
\"V 	c #8D8D8D\",
\"W 	c #C0C0C0\",
\"X 	c #EDEDED\",
\"Y 	c #E0E0E0\",
\"Z 	c #9C9C9C\",
\"` 	c #939393\",
\" .	c #8E8E8E\",
\"..	c #767676\",
\"+.	c #E9E9E9\",
\"@.	c #E5E5E5\",
\"#.	c #D6D6D6\",
\"$.	c #9D9D9D\",
\"%.	c #B8B8B8\",
\"&.	c #D5D5D5\",
\"*.	c #FFFFFF\",
\"=.	c #929292\",
\"-.	c #B1B1B1\",
\"          . + @ . # $           \",
\"      + % . & * = - ; > ,       \",
\"    + . ' ) ! ~ { ] ^ / ( _     \",
\"  @ @ @ : < [ } | 1 2 3 4 5 6   \",
\"  @ , & 7 8 9 0 0 : a b c _ .   \",
\"d d e f g h i j k k l m _ , @ + \",
\"d , . _ n o p q r l s t u e d @ \",
\", . 5 v w x y z A w g B u e , @ \",
\"C D / E / F G h H I J K L e , d \",
\"M I E 8 N O ' P Q * t & _ e e d \",
\"@ R ( 3 S T P g U U V R u e e d \",
\"  + t W X Y j { Z `  .s f ..,   \",
\"  ..d + Z w +.X @.#.p $.T e ,   \",
\"    e u s D %.0 &.< *.F P @     \",
\"      _ ' =.k ! -.7 -  ...      \",
\"          @ + + + . C           \"};
")

(defun tabbar-popup-menu ()
  "Keymap for pop-up menu.  Emacs only."
  `(,(format "%s" (nth 0 tabbar-last-tab))
    ["Buffer Clone" tabbar-popup-clone-indirect-buffer]
    "--"
    ["Close" tabbar-popup-close]
    ["Close all BUT this" tabbar-popup-close-but]
    "--"
    ["Save" tabbar-popup-save]
    ["Save As" tabbar-popup-save-as]
    "--"
    ["Rename File" tabbar-popup-rename
     :active (and (buffer-file-name (tabbar-tab-value tabbar-last-tab))
                  (file-exists-p (buffer-file-name (tabbar-tab-value tabbar-last-tab))))]
    ["Delete File" tabbar-popup-delete
     :active (and (buffer-file-name (tabbar-tab-value tabbar-last-tab))
                  (file-exists-p (buffer-file-name (tabbar-tab-value tabbar-last-tab))))]
    "--"
    ["Copy full path" tabbar-popup-copy-path
     :active (and (buffer-file-name (tabbar-tab-value tabbar-last-tab))
                  (file-exists-p (buffer-file-name (tabbar-tab-value tabbar-last-tab))))
     ]
    ["Copy directory path" tabbar-popup-copy-dir
     :active (and (buffer-file-name (tabbar-tab-value tabbar-last-tab))
                  (file-exists-p (buffer-file-name (tabbar-tab-value tabbar-last-tab))))
     ]
    ["Copy file-name" tabbar-popup-copy-file
     :active (and (buffer-file-name (tabbar-tab-value tabbar-last-tab))
                  (file-exists-p (buffer-file-name (tabbar-tab-value tabbar-last-tab))))
     ]
    "--"
    ["Gzip File" tabbar-popup-gz
     :active (and (executable-find "gzip")
                  (buffer-file-name (tabbar-tab-value tabbar-last-tab))
                  (file-exists-p (buffer-file-name (tabbar-tab-value tabbar-last-tab)))
                  (not (string-match "\\.gz\\(?:~\\|\\.~[0-9]+~\\)?\\'" (buffer-file-name (tabbar-tab-value tabbar-last-tab)))))]
    ["Bzip File" tabbar-popup-bz2
     :active (and (executable-find "bzip2")
                  (buffer-file-name (tabbar-tab-value tabbar-last-tab))
                  (file-exists-p (buffer-file-name (tabbar-tab-value tabbar-last-tab)))
                  (not (string-match "\\.bz2\\(?:~\\|\\.~[0-9]+~\\)?\\'" (buffer-file-name (tabbar-tab-value tabbar-last-tab)))))]
    ["Decompress File" tabbar-popup-decompress
     :active (and
              (buffer-file-name (tabbar-tab-value tabbar-last-tab))
              (file-exists-p (buffer-file-name (tabbar-tab-value tabbar-last-tab)))
              (string-match "\\(?:\\.\\(?:Z\\|gz\\|bz2\\|tbz2?\\|tgz\\|svgz\\|sifz\\|xz\\|dz\\)\\)\\(\\(?:~\\|\\.~[0-9]+~\\)?\\)\\'"
                            (buffer-file-name (tabbar-tab-value tabbar-last-tab))))
     ]
    ;;    "--"
    ;;    ["Print" tabbar-popup-print]
    ))

(defun tabbar-popup-print ()
  "Print Buffer"
  (interactive))

(defun tabbar-popup-clone-indirect-buffer ()
  "Tab-bar pop up clone indirect-buffer"
  (interactive)
  (let ((buffer (tabbar-tab-value tabbar-last-tab)))
    (with-current-buffer buffer
      (call-interactively 'clone-indirect-buffer))))

(defun tabbar-popup-close ()
  "Tab-bar pop up close"
  (interactive)
  (funcall tabbar-close-tab-function tabbar-last-tab))

(defun tabbar-popup-close-but ()
  "Tab-bar close all BUT this buffer"
  (interactive)
  (let ((cur (symbol-value (funcall tabbar-current-tabset-function))))
    (mapc (lambda(tab)
            (unless (eq tab tabbar-last-tab)
              (funcall tabbar-close-tab-function tab)))
          cur)))

(defun tabbar-popup-save-as ()
  "Tab-bar save as"
  (interactive)
  (let* ((buf (tabbar-tab-value tabbar-last-tab)))
    (save-excursion
      (set-buffer buf)
      (call-interactively 'write-file))))

(defun tabbar-popup-rename ()
  "Tab-bar rename"
  (interactive)
  (let* ((buf (tabbar-tab-value tabbar-last-tab))
         (fn (buffer-file-name buf)))
    (save-excursion
      (set-buffer buf)
      (when (call-interactively 'write-file)
        (if (string= fn (buffer-file-name (current-buffer)))
            (error "Buffer has same name.  Just saved instead.")
          (delete-file fn))))))

(defun tabbar-popup-delete ()
  "Tab-bar delete file"
  (interactive)
  (let* ((buf (tabbar-tab-value tabbar-last-tab))
         (fn (buffer-file-name buf)))
    (when (yes-or-no-p (format "Are you sure you want to delete %s?" buf))
      (save-excursion
        (set-buffer buf)
        (set-buffer-modified-p nil)
        (kill-buffer (current-buffer))
        (delete-file fn)))))


(defun tabbar-popup-copy-path ()
  "Tab-bar copy path"
  (interactive)
  (let* ((buf (tabbar-tab-value tabbar-last-tab))
         (fn (buffer-file-name buf)))
    (kill-new fn)))


(defun tabbar-popup-copy-file ()
  "Tab-bar copy file name"
  (interactive)
  (let* ((buf (tabbar-tab-value tabbar-last-tab))
         (fn (buffer-file-name buf)))
    (kill-new (file-name-nondirectory fn))))


(defun tabbar-popup-copy-dir ()
  "Tab-bar copy directory"
  (interactive)
  (let* ((buf (tabbar-tab-value tabbar-last-tab))
         (fn (buffer-file-name buf)))
    (kill-new (file-name-directory fn))))

(defun tabbar-popup-remove-compression-ext (file-name &optional new-compression)
  "Removes compression extension, and possibly adds a new extension"
  (let ((ret file-name))
    (when (string-match "\\(\\(?:\\.\\(?:Z\\|gz\\|bz2\\|tbz2?\\|tgz\\|svgz\\|sifz\\|xz\\|dz\\)\\)?\\)\\(\\(?:~\\|\\.~[0-9]+~\\)?\\)\\'" ret)
      (setq ret (replace-match (concat (or new-compression "") (match-string 2 ret)) t t ret)))
    (symbol-value 'ret)))

(defun tabbar-popup-gz (&optional ext err)
  "Gzips the file"
  (interactive)
  (let* ((buf (tabbar-tab-value tabbar-last-tab))
         (fn (buffer-file-name buf))
         (nfn (tabbar-popup-remove-compression-ext fn (or ext ".gz"))))
    (if (string= fn nfn)
        (error "Already has that compression!")
      (save-excursion
        (set-buffer buf)
        (write-file nfn)
        (if (not (file-exists-p nfn))
            (error "%s" (or err "Could not gzip file!"))
          (when (file-exists-p fn)
            (delete-file fn)))))))

(defun tabbar-popup-bz2 ()
  "Bzip file"
  (interactive)
  (tabbar-popup-gz ".bz2" "Could not bzip the file!"))

(defun tabbar-popup-decompress ()
  "Decompress file"
  (interactive)
  (tabbar-popup-gz "" "Could not decompress the file!"))

(defun tabbar-context-menu ()
  "Pop up a context menu."
  (interactive)
  (popup-menu (tabbar-popup-menu)))


(defun tabbar-hex-color (color)
  "Gets the hexadecimal value of a color"
  (let ((ret color))
    (cond
     ((not (eq (type-of color) 'string))
      (setq ret "None"))
     ((string= "#" (substring color 0 1))
      (setq ret (upcase ret)))
     ((color-defined-p color)
      (setq ret (concat "#"
                        (mapconcat
                         (lambda(val)
                           (format "%02X" (* val 255)))
                         (color-name-to-rgb color) ""))))
     (t (setq ret "None")))
    (symbol-value 'ret)))

(defcustom tabbar-ruler-swap-faces nil
  "Swap the selected / unselected tab colors"
  :type 'boolean
  :group 'tabbar-ruler)

(defcustom tabbar-ruler-invert-deselected t
  "Invert deselected tabs"
  :type 'boolean
  :group 'tabbar-ruler)

(defcustom tabbar-ruler-modified-symbol nil
  "Add modified symbol in addition to changing the face."
  :type 'boolean
  :group 'tabbar-ruler)


(defcustom tabbar-ruler-style nil
  "Style of tabbar ruler."
  :type '(choice
	  (const :tag "Let variables decide" nil)
	  (const :tag "Text-mode tabbar" 'text)
	  (const :tag "Firefox style" 'firefox)
	  (const :tag "Firefox with circle close" 'firefox-circle))
  :group 'tabbar-ruler)

(defcustom tabbar-ruler-use-variable-pitch t
  "Use variable pich font.

This copies the :family and :foundry from the `variable-pitch' face."
  :type 'boolean
  :group 'tabbar-ruler)

(defun tabbar-ruler-style-firefox (&optional frame)
  "Setup firefox style for FRAME."
  (setq tabbar-ruler-tab-padding 1
	tabbar-ruler-pad-selected nil
	tabbar-ruler-padding-face (tabbar-foreground 'tabbar-default)
	tabbar-ruler-fancy-current-tab-separator 'wave
	tabbar-ruler-fancy-tab-separator 'bar
	tabbar-ruler-fancy-close-image nil)
  (dolist (face '(tabbar-button
		    tabbar-separator
		    tabbar-unselected
		    tabbar-unselected-highlight
		    tabbar-unselected-modified))
      (set-face-attribute face frame
			  :background (tabbar-background 'tabbar-default)
			  :foreground (tabbar-foreground 'tabbar-default)))
  (dolist (face '(tabbar-button
  		  tabbar-separator
  		  tabbar-selected
  		  tabbar-selected-highlight
  		  tabbar-selected-modified
  		  tabbar-unselected
  		  tabbar-unselected-highlight
  		  tabbar-unselected-modified))
    (set-face-attribute face frame
  			:height 100)))

(defun tabbar-ruler-style-firefox-circle (&optional frame)
  "Setup firefox with closed image for FRAME."
  (tabbar-ruler-style-firefox)
  (setq tabbar-ruler-fancy-close-image t))

(defun tabbar-ruler-style-text (&optional frame)
  "Setup text style."
  (setq tabbar-ruler-tab-padding nil
	tabbar-ruler-pad-selected nil
	tabbar-ruler-padding-face nil
	tabbar-ruler-fancy-current-tab-separator 'inherit
	tabbar-ruler-fancy-tab-separator nil
	tabbar-ruler-fancy-close-image nil))

;;;###autoload
(defun tabbar-install-faces (&optional frame)
  "Installs faces for a frame."
  (interactive)
  (copy-face 'mode-line 'tabbar-default frame)
  (if tabbar-ruler-swap-faces
      (progn
        (copy-face 'default 'tabbar-selected frame)
        (copy-face 'shadow 'tabbar-unselected frame)
        (if tabbar-ruler-invert-deselected
            (progn
              (copy-face 'tabbar-selected 'tabbar-unselected)
              (set-face-attribute 'tabbar-selected frame)
              (invert-face 'tabbar-selected))
          (set-face-attribute 'tabbar-selected frame
                              :inherit 'mode-line-buffer-id
                              :background (face-attribute 'mode-line-inactive :background)))
        (copy-face 'mode-line-buffer-id 'tabbar-unselected-highlight frame)
        (copy-face 'mode-line-inactive 'tabbar-selected-highlight frame))
  (copy-face 'default 'tabbar-selected frame)
  (copy-face 'shadow 'tabbar-unselected frame)
  
  (if tabbar-ruler-invert-deselected
      (progn
        (copy-face 'tabbar-selected 'tabbar-unselected)
        (set-face-attribute 'tabbar-unselected frame)
        (invert-face 'tabbar-unselected))
    (set-face-attribute 'tabbar-unselected frame
                        :inherit 'mode-line-buffer-id
                        :background (face-attribute 'mode-line-inactive :background)))
  
  
  (copy-face 'mode-line-buffer-id 'tabbar-selected-highlight frame)
  (copy-face 'mode-line-inactive 'tabbar-unselected-highlight frame))
  
  (set-face-attribute 'tabbar-separator frame
                      :inherit 'tabbar-default)
  
  (set-face-attribute 'tabbar-button frame
                      :inherit 'tabbar-default)
  (dolist (face '(tabbar-button
		  tabbar-separator
		  tabbar-selected
		  tabbar-selected-highlight
		  tabbar-selected-modified
		  tabbar-unselected
		  tabbar-unselected-highlight
		  tabbar-unselected-modified))
    (set-face-attribute face frame
			:box nil
			:height (face-attribute 'default :height frame)
			:width (face-attribute 'default :width frame))
    (when tabbar-ruler-use-variable-pitch
      (set-face-attribute face frame
			  :family (face-attribute 'variable-pitch :family)
			  :foundry (face-attribute 'variable-pitch :foundry))))
  (tabbar-ruler-remove-caches)
  (when tabbar-ruler-style
    (let ((fun (intern (format "tabbar-ruler-style-%s" tabbar-ruler-style))))
      (when (fboundp fun)
	(funcall fun frame)))))

(add-hook 'after-make-frame-functions 'tabbar-install-faces)
(add-hook 'emacs-startup-hook 'tabbar-install-faces)

;; Taken from powerline

(defun tabbar-create-or-get-tabbar-cache ()
  "Return a frame-local hash table that acts as a memoization
cache for tabbar. Create one if the frame doesn't have one
yet."
  (or (frame-parameter nil 'tabbar-cache)
      (let ((table (make-hash-table :test 'equal)))
        ;; Store it as a frame-local variable
        (modify-frame-parameters nil `((tabbar-cache . ,table)))
        table)))

;; from memoize.el @ http://nullprogram.com/blog/2010/07/26/
(defun tabbar-memoize (func)
  "Memoize FUNC.
If argument is a symbol then install the tabbar-memoized function over
the original function.  Use frame-local memoization."
  (typecase func
    (symbol (fset func (tabbar-memoize-wrap-frame-local (symbol-function func))) func)
    (function (tabbar-memoize-wrap-frame-local func))))

(defun tabbar-memoize-wrap-frame-local (func)
  "Return the tabbar-memoized version of FUNC.  The memoization cache is
frame-local."
  (let ((cache-sym (gensym))
        (val-sym (gensym))
        (args-sym (gensym)))
    `(lambda (&rest ,args-sym)
       ,(concat (documentation func) "\n(tabbar-memoized function)")
       (let* ((,cache-sym (tabbar-create-or-get-tabbar-cache))
              (,val-sym (gethash ,args-sym ,cache-sym)))
         (if ,val-sym
             ,val-sym
           (puthash ,args-sym (apply ,func ,args-sym) ,cache-sym))))))

(defun* tabbar-ruler-image (&key type disabled color face)
  "Returns the scroll-images"
  (let ((clr2 (or (and face (facep face) (tabbar-background face))
		  (and disabled (tabbar-hex-color (face-attribute 'mode-line-inactive :background)))
		  (tabbar-hex-color (face-attribute 'mode-line :background))))
        (clr (or color
		 (and face (facep face) (tabbar-foreground face))
		 (and disabled (tabbar-hex-color (face-attribute 'mode-line-inactive :foreground)))
		 (tabbar-hex-color (face-attribute 'mode-line :foreground)))))
    (if (eq type 'close)
        (format "/* XPM */
        static char * close_tab_xpm[] = {
        \"14 11 3 1\",
        \"       c None\",
        \".      c %s\",
        \"+      c %s\",
        \"     .....    \",
        \"    .......   \",
        \"   .........  \",
        \"  ... ... ... \",
        \"  .... . .... \",
        \"  ..... ..... \",
        \"  .... . .... \",
        \"  ... ... ... \",
        \"   .........  \",
        \"    .......   \",
        \"     .....    \"};" clr clr2)
      
      (format
       "/* XPM */
static char * scroll_%s_%s_xpm[] = {
\"17 17 2 1\",
\"       c None\",
\".      c %s\",
\"                 \",
\"                 \",
\"                 \",
\"                 \",
\"                 \",
%s
\"                 \",
\"                 \",
\"                 \",
\"                 \",
\"                 \",
\"                 \"};
" (symbol-name type)
(if disabled "disabled" "enabled")
clr
(cond
 ((eq 'right type)
  "\"                 \",
\"     ..          \",
\"     ....        \",
\"     ......      \",
\"     .....       \",
\"     ...         \",
"
  )
 ((eq 'left type)
  "\"                 \",
\"          ..     \",
\"        ....     \",
\"      ......     \",
\"       .....     \",
\"         ...     \","
  )
 ((eq 'up type)
  "\"        .        \",
\"       ..        \",
\"       ...       \",
\"      ....       \",
\"      .....      \",
\"      .....      \",")
 ((eq 'down type)
  "\"      .....      \",
\"      .....      \",
\"      ....       \",
\"       ...       \",
\"       ..        \",
\"        .        \","))))))


(defconst tabbar-home-button-enabled-image
  `((:type xpm :data ,(tabbar-ruler-image :type 'down)))
  "Default image for the enabled home button.")

(defconst tabbar-home-button-disabled-image
  `((:type xpm :data ,(tabbar-ruler-image :type 'up)))
  "Default image for the disabled home button")


(defconst tabbar-home-button
  (cons (cons "[o]" tabbar-home-button-enabled-image)
            (cons "[x]" tabbar-home-button-disabled-image)))

(defvar tabbar-buffer-home-button
  (cons (cons "[+]" tabbar-home-button-enabled-image)
        (cons "[-]" tabbar-home-button-disabled-image)))

(defvar tabbar-scroll-left-button-enabled-image
  `((:type xpm :data ,(tabbar-ruler-image :type 'left))))

(defvar tabbar-scroll-left-button-disabled-image
  `((:type xpm :data ,(tabbar-ruler-image :type 'left :disabled t))))

(defvar tabbar-scroll-left-button
  (cons (cons " <" tabbar-scroll-left-button-enabled-image)
        (cons " =" tabbar-scroll-left-button-disabled-image)))

(defvar tabbar-scroll-right-button-enabled-image
  `((:type xpm :data ,(tabbar-ruler-image :type 'right))))

(defvar tabbar-scroll-right-button-disabled-image
  `((:type xpm :data  ,(tabbar-ruler-image :type 'right :disabled t))))

(defvar tabbar-scroll-right-button
  (cons (cons " >" tabbar-scroll-right-button-enabled-image)
        (cons " =" tabbar-scroll-right-button-disabled-image)))

(defsubst tabbar-normalize-image (image &optional margin face mask)
  "Make IMAGE centered and transparent.
If optional MARGIN is non-nil, it must be a number of pixels to add as
an extra margin around the image.  If optional MASK is non-nil, mask
property is included."
  (let ((plist (cdr image))
	(face (or face 'tabbar-default)))
    (or (plist-get plist :ascent)
        (setq plist (plist-put plist :ascent 'center)))
    (or (plist-get plist :mask)
        (when mask
          (setq plist (plist-put plist :mask '(heuristic t)))))
    (or (not (natnump margin))
        ;; (plist-get plist :margin)
        (plist-put plist :margin margin))
    (and (facep face)
	 (plist-put plist :face face))
    (setcdr image plist))
  image)

;; for buffer tabs, use the usual command to close/kill a buffer
(defun tabbar-buffer-close-tab (tab)
  (let ((buffer (tabbar-tab-value tab)))
    (with-current-buffer buffer
      (kill-buffer buffer))))

(setq tabbar-close-tab-function 'tabbar-buffer-close-tab)

(defsubst tabbar-click-on-tab (tab &optional type action)
  "Handle a mouse click event on tab TAB.
Call `tabbar-select-tab-function' with the received, or simulated
mouse click event, and TAB.
Optional argument TYPE is a mouse click event type (see the function
`tabbar-make-mouse-event' for details)."
  (let* ((mouse-event (tabbar-make-mouse-event type))
         (mouse-button (event-basic-type mouse-event))
	 tmp map)
    (cond
	 ((eq mouse-button 'mouse-3)
	  (setq tabbar-last-tab tab)
	  (tabbar-context-menu))
       ((eq action 'close-tab)
	(when (and (eq mouse-button 'mouse-1) tabbar-close-tab-function)
	  (funcall tabbar-close-tab-function tab)))
       ((and (eq action 'icon) (setq tmp (key-binding [menu-bar languages])))
	(with-current-buffer (tabbar-tab-value tab)
	  (setq map (copy-keymap tmp)
		tmp (mouse-menu-major-mode-map))
	  (define-key map [major-mode-sep-b] '(menu-item  "---"))
	  (define-key map [major-mode] (cons (nth 1 tmp) tmp))
	  ;; (setq tmp (make-composed-map tmp (mouse-menu-major-mode-map)))
	  ;; (popup-menug tmp)
	  (popup-menu map))
	(tabbar-ruler-modification-state-change)
	(tabbar-display-update))
       (t (when tabbar-select-tab-function
	    (funcall tabbar-select-tab-function
		     (tabbar-make-mouse-event type) tab)
	    (tabbar-display-update))))))

(defun tabbar-reset ()
  "Reset memoized functions."
  (interactive)
  (tabbar-memoize 'tabbar-make-tab-keymap)
  (tabbar-memoize 'tabbar-ruler-image))
(tabbar-reset)

(defsubst tabbar-drag-p (event)
  "Return non-nil if EVENT is a mouse drag event."
  (memq 'drag (event-modifiers event)))

(defun tabbar-select-tab-callback (event)
  "Handle a mouse EVENT on a tab.
Pass mouse click events on a tab to `tabbar-click-on-tab'."
  (interactive "@e")
  (cond 
    ((tabbar-click-p event)
      (let ((target (posn-string (event-start event))))
        (tabbar-click-on-tab
          (get-text-property (cdr target) 'tabbar-tab (car target))
          event
          (get-text-property (cdr target) 'tabbar-action (car target)))))
    ((tabbar-drag-p event)
      (let ((start-target (posn-string (event-start event)))
            (end-target (posn-string (event-end event))))
        (tabbar-drag-tab
          (get-text-property (cdr start-target) 'tabbar-tab (car start-target))
          (get-text-property (cdr end-target) 'tabbar-tab (car end-target))
          event)))
  ))

(defun tabbar-drag-tab (dragged-tab dropped-tab event)
  "Handle DRAGGED-TAB dragged-and-dropped onto DROPPED-TAB.
   Include full mouse EVENT from drag-and-drop action."
  (let ((start-tabset (tabbar-tab-tabset dragged-tab)))
    (when (and (eq start-tabset (tabbar-tab-tabset dropped-tab))
           (not (eq dragged-tab dropped-tab)))
      (let* ((tabs (tabbar-tabs start-tabset))
         (drop-tail-length (length (memq dropped-tab tabs)))
         (drag-tail-length (length (memq dragged-tab tabs)))
         (dragdrop-pair (list dragged-tab dropped-tab))
         new-tablist)
    (when (> drag-tail-length drop-tail-length)
      (setq dragdrop-pair (reverse dragdrop-pair)))
    (dolist (thistab (reverse tabs))
      ;; build list of tabs.  When we hit dragged-tab, don't append it.
      ;; When we hit dropped-tab, append dragdrop-pair
      (cond
        ((eq thistab dragged-tab))
        ((eq thistab dropped-tab)
         (setq new-tablist (append dragdrop-pair new-tablist)))
        (t (add-to-list 'new-tablist thistab))
      ))
    (set start-tabset new-tablist)
    ;; (setq tabbar-window-cache nil)  ;; didn't help
    (tabbar-set-template start-tabset nil)
    ;; open the dragged tab
    (funcall tabbar-select-tab-function
             (tabbar-make-mouse-event event) dragged-tab)
    (tabbar-display-update)
    ))))

(defun tabbar-ruler-pad-xpm (width color &optional height)
  "Generate padding xpm of WIDTH and COLOR with optional HEIGHT."
  (let* ((height (or height tabbar-ruler-tab-height (pl/separator-height)))
         (data nil)
         (i 0))
    (while (< i height)
      (setq data (cons
		  (append (make-list width 1))
                  data))
      (setq i (+ i 1)))
    (pl/make-xpm "sep" color color data)))

(defun tabbar-background-- (int)
  "Convert INT to 2 digit hex."
  (substring (format "%02X" int) -2))

(defun tabbar-background (face &optional foreground)
  "Gets hex background of FACE.
When FOREGROUND is non-nil, get the foreground instead."
  (let ((color (or (and (facep face)
			(or (and foreground (face-foreground face nil 'default))
			    (face-background face nil 'default)))
		   (and (stringp face) face))))
    (when (member color (x-defined-colors))
      (setq color (x-color-values color)
	    color (concat"#"
			 (tabbar-background--(nth 0 color))
			 (tabbar-background--(nth 1 color))
			 (tabbar-background--(nth 2 color)))))
    color))

(defun tabbar-foreground (face)
  "Gets hex foreground of FACE."
  (tabbar-background face t))


(defun tabbar-line-right-separator (selected-p face background-face &optional dir
					       normalize-face)
  "Right separator for tabbar.
SELECTED-P tells if the item is seleceted."
  (when tabbar-ruler-fancy-tab-separator
    (let* ((dir (or dir "right"))
	   (fun
	    (if (and selected-p (not (eq tabbar-ruler-fancy-current-tab-separator 'inherit))) 
		(intern (format "powerline-%s-%s" tabbar-ruler-fancy-current-tab-separator dir))
	      (intern (format "powerline-%s-%s" tabbar-ruler-fancy-tab-separator dir))))
	   (normalize-face (or normalize-face face)))
      (propertize "|"
		  'display (tabbar-normalize-image (funcall fun background-face face tabbar-ruler-tab-height) 0 normalize-face)
		  'face normalize-face))))

(defun tabbar-line-left-separator (selected-p face background-face)
  "Left separator for tabbar."
  (or (tabbar-line-right-separator selected-p background-face face "left" face)
      tabbar-separator-value))

(defvar tabbar-line-mode-icon nil)
(defun tabbar-line-mode-icon (tab face keymap)
  "Create mode icon for TAB using FACE and KEYMAP"
  (setq tabbar-line-mode-icon nil)
  (when (and window-system tabbar-ruler-use-mode-icons (featurep 'mode-icons))
    (let ((mode-icon (with-current-buffer (tabbar-tab-value tab)
		       (assoc mode-name mode-icons))))
      (setq tabbar-line-mode-icon (propertize " " 'face face
						  'tabbar-tab tab
						  'local-map keymap
						  'help-echo 'tabbar-help-on-tab
						  'face face
						  'pointer 'hand
						  'tabbar-action 'icon))
      (if mode-icon
	  (propertize " "
		      'display (create-image
				(mode-icons-get-icon-file
				 (concat (nth 1 mode-icon) "." (symbol-name (nth 2 mode-icon))))
				(nth 2 mode-icon) nil
				:ascent 'center
				:face face)
		      'face face
		      'tabbar-tab tab
		      'local-map keymap
		      'help-echo 'tabbar-help-on-tab
		      'pointer 'hand
		      'tabbar-action 'icon)
	(if tabbar-ruler-mode-icon-for-unknown-modes
	    (propertize " "
			'display (create-image mode-icon-unknown 'xpm t
					       :ascent 'center
					       :face face)
			'face face
			'tabbar-tab tab
			'local-map keymap
			'help-echo 'tabbar-help-on-tab
			'pointer 'hand
			'tabbar-action 'icon)
	  (setq tabbar-line-mode-icon nil))))))

(defun tabbar-line-padding (selected-p next-selected-p background-face)
  (when (and tabbar-ruler-fancy-tab-separator tabbar-ruler-tab-padding
	     (or (not selected-p) (and selected-p tabbar-ruler-pad-selected))
	     (or (not next-selected-p) (and next-selected-p tabbar-ruler-pad-selected)))
    (propertize " " 'display (tabbar-normalize-image
			      (tabbar-ruler-pad-xpm
			       tabbar-ruler-tab-padding
			       (tabbar-background (or tabbar-ruler-padding-face background-face))) 0 background-face)
		'face background-face)))

(defsubst tabbar-line-tab (tab &optional not-last sel)
  "Return the display representation of tab TAB.
That is, a propertized string used as an `header-line-format' template
element.
Call `tabbar-tab-label-function' to obtain a label for TAB."
  (let* ((selected-p (tabbar-selected-p tab (tabbar-current-tabset)))
	 (next-selected-p (and not-last (tabbar-selected-p (car not-last) (tabbar-current-tabset))))
	 (modified-p (buffer-modified-p (tabbar-tab-value tab)))
	 (keymap (tabbar-make-tab-keymap tab))
	 (left-fun
	  (if (and selected-p (not (eq tabbar-ruler-fancy-current-tab-separator 'inherit)))
	      (intern (format "powerline-%s-left" tabbar-ruler-fancy-current-tab-separator))
	    (intern (format "powerline-%s-left" tabbar-ruler-fancy-tab-separator))))
	 (face (if selected-p
		   (if modified-p
		       'tabbar-selected-modified
		     'tabbar-selected)
		 (if modified-p
		     'tabbar-unselected-modified
		   'tabbar-unselected)))
	 (close-button-image (tabbar-find-image 
			      `((:type xpm :data ,(tabbar-ruler-image :type 'close :disabled (not modified-p)
								      :face face)))))
	 (background-face 'tabbar-default)
	 (next-background-face 'tabbar-default)
	 (mode-icon (and (featurep 'mode-icons)
			 (with-current-buffer (tabbar-tab-value tab)
			   (assoc mode-name mode-icons))))
	 (pad-face (or tabbar-ruler-padding-face background-face)))
    (setq close-button-image (tabbar-normalize-image close-button-image 0 face))
    (concat
     (tabbar-line-right-separator selected-p face background-face)
     (propertize " " 'face face
                 'tabbar-tab tab
                 'local-map keymap
                 'help-echo 'tabbar-help-on-tab
                 'face face
                 'pointer 'hand)
     
     (tabbar-line-mode-icon tab face keymap)
     tabbar-line-mode-icon
     (propertize 
      (if tabbar-tab-label-function
          (funcall tabbar-tab-label-function tab)
        tab)
      'tabbar-tab tab
      'local-map keymap
      'help-echo 'tabbar-help-on-tab
      'mouse-face 'tabbar-highlight
      'face face
      'pointer 'hand)
     (propertize (if (and modified-p tabbar-ruler-modified-symbol)
                     (with-temp-buffer
                       (condition-case err
                           (ucs-insert "207A")
                         (error
                          (condition-case err
                              (insert-char #x207A)
                            (error (insert "*")))))
                       (insert " ")
                       (buffer-substring (point-min) (point-max))) " ")
                 'face face
                 'tabbar-tab tab
                 'local-map keymap
                 'help-echo 'tabbar-help-on-tab
                 'face face
                 'pointer 'hand)
     (if tabbar-ruler-fancy-close-image
         (propertize (with-temp-buffer
                       (condition-case err
                           (ucs-insert "00D7")
                         (error
                          (condition-case err
                              (insert-char #x00D7)
                            (error (insert "x")))))
                       (buffer-string))
                     'display close-button-image
                     'face face
                     'pointer 'hand
                     'tabbar-tab tab
                     'local-map keymap
                     'tabbar-action 'close-tab)
       (propertize
        (with-temp-buffer
          (condition-case err
              (ucs-insert "00D7")
            (error (condition-case err
                       (insert-char #x00D7)
                     (error (insert "x")))))
          (insert " ")
          (buffer-string))
        'face face
        'pointer 'hand
        'tabbar-tab tab
        'local-map keymap
        'tabbar-action 'close-tab))
     (tabbar-line-left-separator selected-p face background-face)
     (tabbar-line-padding selected-p next-selected-p 'tabbar-default)
     )))

(defsubst tabbar-line-format (tabset)
  "Return the `header-line-format' value to display TABSET."
  (let* ((sel (tabbar-selected-tab tabset))
         (tabs (tabbar-view tabset))
         (padcolor (tabbar-background-color))
         atsel elts)
    ;; Initialize buttons and separator values.
    (or tabbar-separator-value
        (tabbar-line-separator))
    (or tabbar-home-button-value
        (tabbar-line-button 'home))
    (or tabbar-scroll-left-button-value
        (tabbar-line-button 'scroll-left))
    (or tabbar-scroll-right-button-value
        (tabbar-line-button 'scroll-right))
    ;; Track the selected tab to ensure it is always visible.
    (when tabbar--track-selected
      (while (not (memq sel tabs))
        (tabbar-scroll tabset -1)
        (setq tabs (tabbar-view tabset)))
      (while (and tabs (not atsel))
	(setq elts  (cons (tabbar-line-tab (car tabs) (cdr tabs)) elts)
                atsel (eq (car tabs) sel)
                tabs  (cdr tabs)))
      (setq elts (nreverse elts))
      ;; At this point the selected tab is the last elt in ELTS.
      ;; Scroll TABSET and ELTS until the selected tab becomes
      ;; visible.
      (with-temp-buffer
        (let ((truncate-partial-width-windows nil)
              (inhibit-modification-hooks t)
              deactivate-mark ;; Prevent deactivation of the mark!
              start)
          (setq truncate-lines nil
                buffer-undo-list t)
          (apply 'insert (tabbar-line-buttons tabset))
          (setq start (point))
          (while (and (cdr elts) ;; Always show the selected tab!
                      (progn
                        (delete-region start (point-max))
                        (goto-char (point-max))
                        (apply 'insert elts)
                        (goto-char (point-min))
                        (> (vertical-motion 1) 0)))
            (tabbar-scroll tabset 1)
            (setq elts (cdr elts)))))
      (setq elts (nreverse elts))
      (setq tabbar--track-selected nil))
    ;; Format remaining tabs.
    (while tabs
      (setq elts (cons (tabbar-line-tab (car tabs) (cdr tabs)) elts)
              tabs (cdr tabs)))
    ;; Cache and return the new tab bar.
    (setq elts (nreverse elts))
    (tabbar-set-template
       tabset
       (list (tabbar-line-buttons tabset)
	     (cond
	      (tabbar-ruler-fancy-tab-separator
	       (propertize " " 'display (funcall (intern (format "powerline-%s-right" tabbar-ruler-fancy-tab-separator))
						 nil (get-text-property 0 'face (car elts)) tabbar-ruler-tab-height)))
	      (t ""))
             elts
             (propertize "%-"
                         'face (list :background padcolor
                                     :foreground padcolor)
                         'pointer 'arrow)))))

(defface tabbar-selected-modified
  '((t
     :inherit tabbar-selected
     :foreground "DarkOrange3"
     :weight bold))
   "Face used for selected tabs."
  :group 'tabbar)

(defface tabbar-unselected-modified
  '((t
     :inherit tabbar-unselected
     :foreground "DarkOrange3"
     :weight bold))
   "Face used for unselected tabs."
  :group 'tabbar)

(defface tabbar-key-binding '((t
                               :foreground "white"))
  "Face for unselected, highlighted tabs."
  :group 'tabbar)

;; Hooks based on yswzing's hooks, but modified for this function state.
;; called each time the modification state of the buffer changed
(defun tabbar-ruler-modification-state-change ()
  (tabbar-set-template tabbar-current-tabset nil)
  (tabbar-display-update))

;; first-change-hook is called BEFORE the change is made
(defun tabbar-ruler-on-buffer-modification ()
  (set-buffer-modified-p t)
  (tabbar-ruler-modification-state-change))
(add-hook 'after-save-hook 'tabbar-ruler-modification-state-change)

(defvar tabbar-ruler-tabbar-off 't)
(defvar tabbar-ruler-ruler-off 't)
(set (make-variable-buffer-local 'tabbar-ruler-toolbar-off) nil)
(set (make-variable-buffer-local 'tabbar-ruler-ruler-off) nil)

(defvar tabbar-ruler-toolbar-off nil)
(defvar tabbar-ruler-menu-off nil)
(add-hook 'find-file-hook
          (lambda()
            (interactive)
            (tabbar-ruler-tabbar-ruler-fight 't)))

(defcustom tabbar-ruler-ruler-display-commands
  '(ac-trigger-commands
    esn-upcase-char-self-insert
    esn-magic-$
    right-char
    left-char
    previous-line
    next-line
    backward-paragraph
    forward-paragraph
    cua-scroll-down
    cua-scroll-up
    cua-paste
    cua-paste-pop
    scroll-up
    scroll-down
    autopair-newline
    autopair-insert-opening
    autopair-skip-close-maybe
    autopair-backspace
    backward-delete-char-untabify
    delete-backward-char
    self-insert-command)
  "Ruler display commands."
  :group 'tabbar-ruler
  :type '(repeat symbol))

(defun tabbar-ruler-tabbar-ruler-fight (&optional initialize)
  "Defines the fighting behavior of the tabbar-ruler ruler and tabbar."
  (condition-case error
      (progn
        (cond
         ((minibufferp)
          nil)
         (tabbar-ruler-keep-tabbar
          (setq tabbar-ruler-keep-tabbar nil)
          nil)
         ((and (save-match-data (string-match "^[*]Org Src " (buffer-name))))
          nil)
         ((member major-mode tabbar-ruler-fight-igore-modes)
          nil)
         ( (eq major-mode 'helm-mode)
           nil)
         ( (eq last-command 'mouse-drag-region)
           (tabbar-ruler-mouse-movement))
         ( (and tabbar-ruler-global-ruler tabbar-ruler-global-tabbar)
           (cond
            ( (memq last-command tabbar-ruler-ruler-display-commands)
              (when tabbar-ruler-popup-scrollbar
                (scroll-bar-mode -1))
              (when tabbar-ruler-ruler-off
                (ruler-mode 1)
                (setq tabbar-ruler-ruler-off nil))
              (unless tabbar-ruler-tabbar-off
                (tabbar-mode -1)
                (setq tabbar-ruler-tabbar-off 't))
              (when tabbar-ruler-popup-menu
                (unless tabbar-ruler-menu-off
                  (unless (eq system-type 'darwin)
		    (menu-bar-mode -1))
                  (setq tabbar-ruler-menu-off 't)))
              (when tabbar-ruler-popup-toolbar
                (unless (eq system-type 'darwin)
                  (unless tabbar-ruler-toolbar-off
                    (tool-bar-mode -1)
                    (setq tabbar-ruler-toolbar-off 't)))))
            ( (save-match-data (string-match "\\(mouse\\|ignore\\|window\\|frame\\)" (format "%s" last-command)))
              (when nil ;; Took this out;  Afterward it works much better...
                (unless tabbar-ruler-ruler-off
                  (ruler-mode -1)
                  (setq tabbar-ruler-ruler-off 't))
                (when tabbar-ruler-tabbar-off
                  (tabbar-mode 1)
                  (setq tabbar-ruler-tabbar-off nil))))
            ( 't
              (when (or initialize (and tabbar-ruler-ruler-off tabbar-ruler-tabbar-off))
                (when tabbar-ruler-popup-scrollbar
                  (scroll-bar-mode -1))
                (when tabbar-ruler-ruler-off
                  (ruler-mode 1)
                  (setq tabbar-ruler-ruler-off nil))
                (unless tabbar-ruler-tabbar-off
                  (tabbar-mode -1)
                  (setq tabbar-ruler-tabbar-off 't))))))
         ( tabbar-ruler-global-ruler
           (when tabbar-ruler-ruler-off
             (ruler-mode 1)
             (setq tabbar-ruler-ruler-off nil)))
         ( tabbar-ruler-global-tabbar
           (when tabbar-ruler-tabbar-off
             (tabbar-mode 1)
             (setq tabbar-ruler-tabbar-off nil)))))
    (error
     (message "Error in post-command-hook for Ruler/Tabbar: %s" (error-message-string error)))))

(add-hook 'post-command-hook 'tabbar-ruler-tabbar-ruler-fight)
(defvar tabbar-ruler-movement-timer nil)
(defvar tabbar-ruler-movement-x nil)
(defvar tabbar-ruler-movement-y nil)

(defun tabbar-ruler-mouse-movement ()
  "Mouse Movement function"
  (interactive)
  (when tabbar-ruler-movement-timer
    (cancel-timer tabbar-ruler-movement-timer))  
  (let* ((y-pos (cddr (mouse-pixel-position)))
         (x-pos (cadr (mouse-pixel-position))))
    (unless y-pos
      (setq y-pos tabbar-ruler-movement-y))
    (unless x-pos
      (setq x-pos tabbar-ruler-movement-x))
    (when (or (not tabbar-ruler-movement-x) (not tabbar-ruler-movement-y)
              (and tabbar-ruler-movement-x tabbar-ruler-movement-y
                   (not
                    (and
                     (= tabbar-ruler-movement-x x-pos)
                     (= tabbar-ruler-movement-y y-pos)))))
      (when (and x-pos y-pos)
        (when tabbar-ruler-popup-scrollbar
          (scroll-bar-mode 1))
        (setq tabbar-ruler-movement-x x-pos)
        (setq tabbar-ruler-movement-y y-pos)
        (unless tabbar-ruler-ruler-off
          (ruler-mode -1)
          (setq tabbar-ruler-ruler-off 't))
        (when tabbar-ruler-tabbar-off
          (tabbar-mode 1)
          (setq tabbar-ruler-tabbar-off nil))
        (if (>= (if (or tabbar-ruler-menu-off tabbar-ruler-toolbar-off)
                    tabbar-ruler-popup-menu-min-y
                  tabbar-ruler-popup-menu-min-y-leave) y-pos)
            (progn
              (when tabbar-ruler-popup-menu
                (when tabbar-ruler-menu-off
                  (unless (eq system-type 'darwin)
		    (menu-bar-mode 1))
                  (setq tabbar-ruler-menu-off nil)))
              (when tabbar-ruler-popup-toolbar
                (unless (eq system-type 'darwin)
                  (when tabbar-ruler-toolbar-off
                    (tool-bar-mode 1)
                    (setq tabbar-ruler-toolbar-off nil)))))
          (when tabbar-ruler-popup-menu
            (unless tabbar-ruler-menu-off
              (unless (eq system-type 'darwin)
		(menu-bar-mode -1))
              (setq tabbar-ruler-menu-off 't)))
          (when tabbar-ruler-popup-toolbar
            (unless (eq system-type 'darwin)
              (unless tabbar-ruler-toolbar-off
                (tool-bar-mode -1)
                (setq tabbar-ruler-toolbar-off 't)))))))
    (setq tabbar-ruler-movement-timer (run-with-idle-timer
                                       (time-add
                                        (if
                                            (current-idle-time)
                                            (current-idle-time)
                                            (seconds-to-time 0))
                                        (seconds-to-time
                                         tabbar-ruler-movement-timer-delay))
                                       nil
                                       'tabbar-ruler-mouse-movement))))
(tabbar-ruler-mouse-movement)

(defun tabbar-ruler-movement-timer-reset ()
  "Mouse movement timer reset"
  (interactive)
  (when tabbar-ruler-movement-timer
    (cancel-timer tabbar-ruler-movement-timer))
  (setq tabbar-ruler-movement-timer (run-with-idle-timer
                                    (seconds-to-time
                                     tabbar-ruler-movement-timer-delay)
                                     nil
                                     'tabbar-ruler-mouse-movement)))

(add-hook 'post-command-hook 'tabbar-ruler-movement-timer-reset)

(defvar tabbar-buffer-groups-function 'tabbar-buffer-groups)

(defun last-tabbar-ruler-tabbar-buffer-groups nil)

(defun tabbar-ruler-tabbar-buffer-groups ()
  "Return the list of group names the current buffer belongs to.
Return a list of one element based on major mode."
  (setq last-tabbar-ruler-tabbar-buffer-groups
        (list
         (cond
          ;;          ((or (get-buffer-process (current-buffer))
          ;;               ;; Check if the major mode derives from `comint-mode' or
          ;;               ;; `compilation-mode'.
          ;;               (tabbar-buffer-mode-derived-p
          ;;                major-mode '(comint-mode compilation-mode)))
          ;;           "Process")
          ;;    ((string-match "^ *[*]" (buffer-name))
          ;;     "Common"
          ;;     )
          ((eq major-mode 'dired-mode)
           "Dired")
          ((memq major-mode
                 '(help-mode apropos-mode Info-mode Man-mode))
           "Help")
          ((memq major-mode
                 '(rmail-mode
                   rmail-edit-mode vm-summary-mode vm-mode mail-mode
                   mh-letter-mode mh-show-mode mh-folder-mode
                   gnus-summary-mode message-mode gnus-group-mode
                   gnus-article-mode score-mode gnus-browse-killed-mode))
           "Mail")
          (t
           "Files"
           ))))
  (symbol-value 'last-tabbar-ruler-tabbar-buffer-groups))


(defun tabbar-ruler-tabbar-buffer-list ()
  "Return the list of buffers to show in tabs.
Exclude buffers whose name starts with a space or *, when they are not
visiting a file.  The current buffer is always included."
  (delq nil
        (mapcar #'(lambda (b)
                    (cond
                     ;; Always include the current buffer.
                     ((eq (current-buffer) b) b)
                     ((buffer-file-name b) b)
                     ((member (buffer-name b) tabbar-ruler-excluded-buffers) nil)
                     ;; ((string= "*Messages*" (format "%s" (buffer-name b))))
                     ((char-equal ?\  (aref (buffer-name b) 0)) nil)
                     ;;((char-equal ?* (aref (buffer-name b) 0)) nil)
                     ((buffer-live-p b) b)))
                (buffer-list))))

(defvar tabbar-ruler-projectile-tabbar-buffer-group-calc nil
  "Buffer group for projectile.  Should be buffer local and speed up calculation of buffer groups.")
(defun tabbar-ruler-projectile-tabbar-buffer-groups ()
  "Return the list of group names BUFFER belongs to.
    Return only one group for each buffer."
  
  (if tabbar-ruler-projectile-tabbar-buffer-group-calc
      (symbol-value 'tabbar-ruler-projectile-tabbar-buffer-group-calc)
    (set (make-local-variable 'tabbar-ruler-projectile-tabbar-buffer-group-calc)
         
         (cond
          ((or (get-buffer-process (current-buffer)) (memq major-mode '(comint-mode compilation-mode))) '("Term"))
          ((string-equal "*" (substring (buffer-name) 0 1)) '("Misc"))
          ((condition-case err
               (projectile-project-root)
             (error nil)) (list (projectile-project-name)))
          ((memq major-mode '(emacs-lisp-mode python-mode emacs-lisp-mode c-mode c++-mode makefile-mode lua-mode vala-mode)) '("Coding"))
          ((memq major-mode '(javascript-mode js-mode nxhtml-mode html-mode css-mode)) '("HTML"))
          ((memq major-mode '(org-mode calendar-mode diary-mode)) '("Org"))
          ((memq major-mode '(dired-mode)) '("Dir"))
          (t '("Main"))))
    (symbol-value 'tabbar-ruler-projectile-tabbar-buffer-group-calc)))

(defun tabbar-ruler-group-by-projectile-project()
  "Group by projectile project."
  (interactive)
  (setq tabbar-buffer-groups-function 'tabbar-ruler-projectile-tabbar-buffer-groups))

(defun tabbar-ruler-group-user-buffers-helper ()
   ;; customize tabbar to have only 2 groups: emacs's and user's buffers
   ;; all normal files will be shown in group user's buffers
   (list (cond ((string-equal "*" (substring (buffer-name) 0 1)) "emacs's buffers")
               ((eq major-mode 'dired-mode) "emacs's buffers")
               (t "user's buffers"))))

(defun tabbar-ruler-group-user-buffers ()
   (interactive)
   (setq tabbar-buffer-groups-function 'tabbar-ruler-group-user-buffers-helper))

(defun tabbar-ruler-group-buffer-groups ()
  "Use tabbar's major-mode grouping of buffers."
  (interactive)
  (setq tabbar-buffer-groups-function 'tabbar-buffer-groups))

;; default group mode
(tabbar-ruler-group-user-buffers)

;;; Adapted from auto-hide in EmacsWiki

(defvar tabbar-display-functions
  '(tabbar-press-home
    tabbar-backward
    tabbar-forward
    tabbar-backward-tab
    tabbar-forward-tab
    tabbar-backward-group
    tabbar-forward-group
    tabbar-press-scroll-left
    tabbar-press-scroll-right)
  "Tabbar movement functions")

(mapc
 (lambda(x)
   (eval `(defun ,(intern (concat "tabbar-ruler-" (symbol-name x))) (&optional arg)
            ,(concat "Turn on tabbar before running `" (symbol-name x) "'")
            (interactive "p")
            (setq tabbar-ruler-keep-tabbar t)
            (unless tabbar-ruler-ruler-off
              (ruler-mode -1)
              (setq tabbar-ruler-ruler-off 't))
            (when tabbar-ruler-tabbar-off
              (tabbar-mode 1)
              (setq tabbar-ruler-tabbar-off nil))
            (setq current-prefix-arg current-prefix-arg)
            (call-interactively ',x)
            (setq tabbar-ruler-keep-tabbar t)
            (unless tabbar-ruler-ruler-off
              (ruler-mode -1)
              (setq tabbar-ruler-ruler-off 't))
            (when tabbar-ruler-tabbar-off
              (tabbar-mode 1)
              (setq tabbar-ruler-tabbar-off nil)))))
 tabbar-display-functions)

;;;###autoload
(defun tabbar-ruler-up (&optional arg)
  "Tabbar press up key."
  (interactive "p")
  (setq current-prefix-arg current-prefix-arg)
  (call-interactively 'tabbar-ruler-tabbar-press-home))

;;;###autoload
(defun tabbar-ruler-forward (&optional arg)
  "Forward ruler. Takes into consideration if the home-key was pressed.
This is based on the variable `tabbar--buffer-show-groups'"
  (interactive "p")
  (cond
   (tabbar--buffer-show-groups
    (setq current-prefix-arg current-prefix-arg)
    (call-interactively 'tabbar-ruler-tabbar-forward-group)
    (tabbar-ruler-tabbar-press-home))
   (t
    (setq current-prefix-arg current-prefix-arg)
    (call-interactively 'tabbar-ruler-tabbar-forward-tab))))

;;;###autoload
(defun tabbar-ruler-backward (&optional arg)
  "Backward ruler.  Takes into consideration if the home-key was pressed."
  (interactive "p")
  (cond
   (tabbar--buffer-show-groups
    (setq current-prefix-arg current-prefix-arg)
    (call-interactively 'tabbar-ruler-tabbar-backward-group)
    (tabbar-ruler-tabbar-press-home))
   (t
    (setq current-prefix-arg current-prefix-arg)
    (call-interactively 'tabbar-ruler-tabbar-backward-tab))))

(when (not (fboundp 'set-temporary-overlay-map))
  ;; Backport this function from newer emacs versions
  (defun set-temporary-overlay-map (map &optional keep-pred)
    "Set a new keymap that will only exist for a short period of time.
The new keymap to use must be given in the MAP variable. When to
remove the keymap depends on user input and KEEP-PRED:

- if KEEP-PRED is nil (the default), the keymap disappears as
  soon as any key is pressed, whether or not the key is in MAP;

- if KEEP-PRED is t, the keymap disappears as soon as a key *not*
 i in MAP is pressed;

- otherwise, KEEP-PRED must be a 0-arguments predicate that will
  decide if the keymap should be removed (if predicate returns
  nil) or kept (otherwise). The predicate will be called after
  each key sequence."
    
    (let* ((clearfunsym (make-symbol "clear-temporary-overlay-map"))
           (overlaysym (make-symbol "t"))
           (alist (list (cons overlaysym map)))
           (clearfun
            `(lambda ()
               (unless ,(cond ((null keep-pred) nil)
                              ((eq t keep-pred)
                               `(eq this-command
                                    (lookup-key ',map
                                                (this-command-keys-vector))))
                              (t `(funcall ',keep-pred)))
                 (remove-hook 'pre-command-hook ',clearfunsym)
                 (setq emulation-mode-map-alists
                       (delq ',alist emulation-mode-map-alists))))))
      (set overlaysym overlaysym)
      (fset clearfunsym clearfun)
      (add-hook 'pre-command-hook clearfunsym)
      
      (push alist emulation-mode-map-alists))))

(defvar tabbar-ruler-move-keymap (make-sparse-keymap)
  "Keymap for tabbar-ruler movement")

(define-key tabbar-ruler-move-keymap [remap previous-line] 'tabbar-ruler-up)
(define-key tabbar-ruler-move-keymap [remap next-line] 'tabbar-ruler-up)
(define-key tabbar-ruler-move-keymap [remap backward-char] 'tabbar-ruler-backward)
(define-key tabbar-ruler-move-keymap [remap forward-char] 'tabbar-ruler-forward)
(define-key tabbar-ruler-move-keymap [remap left-char] 'tabbar-ruler-backward)
(define-key tabbar-ruler-move-keymap [remap right-char] 'tabbar-ruler-forward)
(define-key tabbar-ruler-move-keymap (kbd "SPC") (lambda() (interactive) (message "Exited tabbar-movement")))
(define-key tabbar-ruler-move-keymap (kbd "<return>") (lambda() (interactive) (message "Exited tabbar-movement")))

(defun tabbar-ruler-move-pred ()
  "Determines if emacs should keep the temporary keymap
  `tabbar-ruler-move-keymap' when running `tabbar-ruler-move'."
  (memq this-command '(tabbar-ruler-up tabbar-ruler-backward tabbar-ruler-forward)))

;;;###autoload
(defun tabbar-ruler-move ()
  "Start the movement for the tabbar"
  (interactive)
  (setq tabbar-ruler-keep-tabbar t)
  (unless tabbar-ruler-ruler-off
    (ruler-mode -1)
    (setq tabbar-ruler-ruler-off 't))
  (when tabbar-ruler-tabbar-off
    (tabbar-mode 1)
    (setq tabbar-ruler-tabbar-off nil))
  (message "Use arrow keys to change buffers (or line movement commands).  Exit with space/return or any other key.")
  (set-temporary-overlay-map tabbar-ruler-move-keymap 'tabbar-ruler-move-pred))

;; Hook save and change events to show modified buffers in tabbar
(defun on-saving-buffer ()
  (tabbar-set-template tabbar-current-tabset nil)
  (tabbar-display-update))
(defun on-modifying-buffer ()
  (set-buffer-modified-p (buffer-modified-p))
  (tabbar-set-template tabbar-current-tabset nil)
  (tabbar-display-update))
(defun after-modifying-buffer (begin end length)
  (set-buffer-modified-p (buffer-modified-p))
  (tabbar-set-template tabbar-current-tabset nil)
  (tabbar-display-update))
(add-hook 'after-save-hook 'on-saving-buffer)
(add-hook 'first-change-hook 'on-modifying-buffer)
(add-hook 'after-change-functions 'after-modifying-buffer)

(defun tabbar-ruler-remove-caches ()
  "Remove caches for tabbar-ruler."
  ;; Courtesy of Ba Manzi
  ;; https://bitbucket.org/bamanzi/dotemacs-elite/issue/24/tabbar-ruler-not-work-in-emacs-244-keep
  (mapc #'(lambda (frame)
            (modify-frame-parameters frame '((tabbar-cache . nil))))
        (frame-list)))

(add-hook 'desktop-after-read-hook 'tabbar-ruler-remove-caches)

(defadvice enable-theme (after tabbar-ruler-enable-theme-after activate)
  "Fix the tabbar faces when you change themes."
  (tabbar-install-faces))

(defadvice disable-theme (after tabbar-ruler-disable-theme-after activate)
  "Fix the tabbar faces when you change themes."
  (tabbar-install-faces))


(defmacro tabbar-ruler-save-buffer-state (&rest body)
  "Eval BODY,
then restore the buffer state under the assumption that no significant
modification has been made in BODY.  A change is considered
significant if it affects the buffer text in any way that isn't
completely restored again.  Changes in text properties like `face' or
`syntax-table' are considered insignificant.  This macro allows text
properties to be changed, even in a read-only buffer.

This macro should be placed around all calculations which set
\"insignificant\" text properties in a buffer, even when the buffer is
known to be writeable.  That way, these text properties remain set
even if the user undoes the command which set them.

This macro should ALWAYS be placed around \"temporary\" internal buffer
changes \(like adding a newline to calculate a text-property then
deleting it again\), so that the user never sees them on his
`buffer-undo-list'.  

However, any user-visible changes to the buffer \(like auto-newlines\)
must not be within a `ergoemacs-save-buffer-state', since the user then
wouldn't be able to undo them.

The return value is the value of the last form in BODY.

This was stole/modified from `c-save-buffer-state'"
  `(let* ((modified (buffer-modified-p)) (buffer-undo-list t)
          (inhibit-read-only t) (inhibit-point-motion-hooks t)
          before-change-functions after-change-functions
          deactivate-mark
          buffer-file-name buffer-file-truename ; Prevent primitives checking
                                        ; for file modification
          )
     (unwind-protect
         (progn ,@body)
       (and (not modified)
            (buffer-modified-p)
            (set-buffer-modified-p nil)))))

(defadvice tabbar-display-update (around tabbar-ruler-fix-select-word activate)
  "Fix the tabbar selection of a word with the mouse."
  (tabbar-ruler-save-buffer-state
   ad-do-it))


(tabbar-install-faces)


(provide 'tabbar-ruler)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; tabbar-ruler.el ends here
