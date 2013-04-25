/*!
contentAccordion v1.0.2 (http://okize.github.com/)
Copyright (c) 2013 | Licensed under the MIT license
http://www.opensource.org/licenses/mit-license.php
*/


(function() {
  (function(factory) {
    if (typeof define === 'function' && define.amd) {
      return define(['jquery'], factory);
    } else {
      return factory(jQuery);
    }
  })(function($) {
    'use strict';
    var Accordion, defaults, pluginName;

    pluginName = 'contentAccordion';
    defaults = {
      indexOfOpenItem: 0,
      maintainState: false
    };
    Accordion = (function() {
      function Accordion(element, options) {
        this.element = element;
        this.el = $(this.element);
        this.options = $.extend({}, defaults, options);
        this._defaults = defaults;
        this._name = pluginName;
        this.items = null;
        this.activeItem = this.options.indexOfOpenItem;
        this.stateKey = 'accordionState';
        this.hashObject = null;
        this.init();
      }

      Accordion.prototype.init = function() {
        var items,
          _this = this;

        if (this.options.maintainState && (this.getStateFromHash() != null)) {
          this.updateState(this.activeItem);
        }
        items = this.getItems();
        if (this.activeItem >= items.length) {
          this.activeItem = 0;
        }
        items.eq(this.activeItem).addClass('active');
        return items.on('click', '.contentAccordionItemTitle', function(e) {
          e.preventDefault();
          return _this.updateState($(e.currentTarget).parent().index());
        });
      };

      Accordion.prototype.getStateFromHash = function() {
        var state, _ref;

        this.hashObject = this.getHashObject();
        if (!this.hashObject) {
          return null;
        }
        state = (_ref = this.hashObject[this.stateKey]) != null ? _ref : null;
        if (!state) {
          return null;
        }
        return this.activeItem = this.hashObject[this.stateKey];
      };

      Accordion.prototype.getHashObject = function() {
        var arg, args, arr, hash, item, _i, _len;

        hash = this.getUrlHash();
        if (!hash) {
          return null;
        }
        args = {};
        arr = hash.split('&');
        for (_i = 0, _len = arr.length; _i < _len; _i++) {
          item = arr[_i];
          arg = item.split('=');
          if (arg.length > 1) {
            args[arg[0]] = arg[1];
          } else {
            args[arg[0]] = void 0;
          }
        }
        return args;
      };

      Accordion.prototype.buildHashObject = function() {
        return $.param(this.hashObject);
      };

      Accordion.prototype.updateHash = function(eq) {
        eq += '';
        this.hashObject = this.getHashObject();
        if (!this.hashObject) {
          this.hashObject = {};
        }
        this.hashObject[this.stateKey] = eq;
        return this.setUrlHash(this.buildHashObject());
      };

      Accordion.prototype.getUrlHash = function() {
        if (window.location.hash) {
          return window.location.hash.substring(1);
        } else {
          return null;
        }
      };

      Accordion.prototype.setUrlHash = function(hash) {
        return window.location.hash = hash;
      };

      Accordion.prototype.getItems = function() {
        if (!this.items) {
          this.items = this.el.find('.contentAccordionItem');
        }
        return this.items;
      };

      Accordion.prototype.selectItem = function(eq) {
        if (this.options.maintainState) {
          this.updateHash(eq);
        }
        return this.getItems().removeClass('active').eq(eq).addClass('active');
      };

      Accordion.prototype.updateState = function(eq) {
        this.activeItem = eq;
        return this.selectItem(eq);
      };

      return Accordion;

    })();
    $.fn[pluginName] = function(options) {
      return this.each(function() {
        if (!$.data(this, 'plugin_#{pluginName}')) {
          $.data(this, 'plugin_#{pluginName}', new Accordion(this, options));
        }
      });
    };
  });

}).call(this);
