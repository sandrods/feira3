/*
 * Autotab for prototype.js Ver.0.1
 * http://ajax-world.sakura.ne.jp/blog/prototype-autotab
 *
 * This program is based on Autotab - jQuery plugin 1.0(http://dev.lousyllama.com/auto-tab),
 * rewritten for use with prototype.js
 * 
 * Copyright (c) 2008 Matthew Miller
 * 
 * Dual licensed under the MIT and GPL licenses:
 *   http://www.opensource.org/licenses/mit-license.php
 *   http://www.gnu.org/licenses/gpl.html
 * 
 * Revised: 2008/05/22 01:23:25
 * Updated: 2010/05/10 by Sandro Duarte
 */

(function() {
  var utils = {
    autotab: function(element, options) {
      var value = null;
      
      // default settings
      var defaults = {
        format: 'all',  // text, numeric, alphanumeric, all
        maxlength: 2147483647,  // Defaults to maxlength value
        uppercase: false,  // Converts a string to UPPERCASE
        lowercase: false,  // Converts a string to lowecase
        nospace: false,  // Remove spaces in the user input
        target: null,  // Where to auto tab to
        previous: null,  // Backwards auto tab when all data is backspaced
        form: null  // Backwards auto tab when all data is backspaced
      };
      
      Object.extend(defaults, options);
      
      var getElement = function(name) {
        var el = null;
        var elByID = $$('#' + name)[0];
        var elByName = $$('input[name=' + name + ']')[0];
        
        if (elByID != undefined) {
          el = $(elByID);
        } else if (elByName != undefined) {
          el = $(elByName);
        }
        
        return el;      
      };
      
      var getKeyCode = function(e) {
        if (!e) {
          e = window.event;
        }
        
        return e.keyCode;
      };
      
      // Sets targets to element based on the name or ID passed
      if (typeof defaults.target == 'string') {
        defaults.target = getElement(defaults.target);
      }
      
      if (typeof defaults.previous == 'string') {
        defaults.previous = getElement(defaults.previous);
      }

      if (typeof defaults.form == 'string') {
        defaults.form = getElement(defaults.form);
      }
      
      var maxlength = element.readAttribute('maxlength');
      
      // Each text field has a maximum character limit of 2147483647
      
      // defaults.maxlength has not changed and maxlength was specified
      if (defaults.maxlength == 2147483647 && maxlength != 2147483647) {
        defaults.maxlength = maxlength;
      }
      // defaults.maxlength overrides maxlength
      else if (defaults.maxlength > 0) {
        element.writeAttribute('maxlength', defaults.maxlength);
      }
      // defaults.maxlength and maxlength have not been specified
      // A target cannot be used since there is no defined maxlength
      else {
        defaults.target = null;
      }
       
      // IE does not recognize the backspace key
      // with keypress in a blank input box
      if (Prototype.Browser.IE) {
        element.observe('keydown', function(e) {
          if (getKeyCode(e) == 8) {
            value = element.value;
            
            if (value.length == 0 && defaults.previous) {
              defaults.previous.focus();
            }
          }
        });
      }
      
      return element.observe('keypress', function(e) {
        if (getKeyCode(e) == 8) {
          value = element.value;
          
          if (value.length == 0 && defaults.previous) {
            defaults.previous.focus();
          }
        }
      }).observe('keyup', function(e) {
        value = element.value;
        
        switch (defaults.format) {
          case 'text':
            var pattern = new RegExp('[0-9]+', 'g');
            value = value.replace(pattern, '');
            break;
          
          case 'alpha':
            var pattern = new RegExp('[^a-zA-Z]+', 'g');
            value = value.replace(pattern, '');
            break;
          
          case 'number':
          case 'numeric':
            var pattern = new RegExp('[^0-9]+', 'g');
            value = value.replace(pattern, '');
            break;
          
          case 'alphanumeric':
            var pattern = new RegExp('[^0-9a-zA-Z]+', 'g');
            value = value.replace(pattern, '');
            break;
          
          case 'all':
          default:
          break;
        }
        
        if (defaults.nospace) {
          pattern = new RegExp('[ ]+', 'g');
          value = value.replace(pattern, '');
        }
        
        if (defaults.uppercase) {
          value = value.toUpperCase();
        }
        
        if (defaults.lowercase) {
          value = value.toLowerCase();
        }
        
        element.value = value;
        
        /**
         * Do not auto tab when the following keys are pressed
         * 8: Backspace
         * 9: Tab
         * 16: Shift
         * 17: Ctrl
         * 18: Alt
         * 19: Pause Break
         * 20: Caps Lock
         * 27: Esc
         * 33: Page Up
         * 34: Page Down
         * 35: End
         * 36: Home
         * 37: Left Arrow
         * 38: Up Arrow
         * 39: Right Arrow
         * 40: Down Arroww
         * 45: Insert
         * 46: Delete
         * 144: Num Lock
         * 145: Scroll Lock
        */
        var keys = [8, 9, 16, 17, 18, 19, 20, 27, 33, 34, 35, 36, 37, 38, 39, 40, 45, 46, 144, 145];
        var string = keys.toString();
        
        if (string.indexOf(getKeyCode(e)) == -1 && value.length == defaults.maxlength) {
					if (defaults.target) { defaults.target.focus(); }
					if (defaults.form) { 
						if (defaults.form.onsubmit) {
							defaults.form.onsubmit();
						} else {
							defaults.form.submit();
						}
					}
        }
      });
    }
  };
  
  Element.addMethods(utils);
})();
