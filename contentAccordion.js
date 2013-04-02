// Generated by CoffeeScript 1.6.2
/*!
contentAccordion v0.0.1 (http://okize.github.com/)
Copyright (c) 2013 | Licensed under the MIT license - http://www.opensource.org/licenses/mit-license.php
*/
(function(factory) {
  if (typeof define === 'function' && define.amd) {
    return define(['jquery'], factory);
  } else {
    return factory(jQuery);
  }
})(function($) {
  'use strict';
  var Plugin, defaults, pluginName;

  pluginName = 'contentAccordion';
  defaults = {
    eqOfOpenPanel: 0,
    alwaysOnePanelOpen: true
  };
  Plugin = (function() {
    function Plugin(element, options) {
      this.element = element;
      this.el = $(this.element);
      this.options = $.extend({}, defaults, options);
      this._defaults = defaults;
      this._name = pluginName;
      this.items = null;
      this.currentItem = this.options.eqOfOpenPanel;
      this.init();
    }

    Plugin.prototype.init = function() {
      var items,
        _this = this;

      items = this.getItems();
      items.eq(this.currentItem).addClass('active');
      return items.on('click', '.contentAccordionItemTitle', function(e) {
        e.preventDefault();
        _this.currentItem = $(e.currentTarget).parent().index();
        return _this.selectItem(_this.currentItem);
      });
    };

    Plugin.prototype.getItems = function() {
      if (!this.items) {
        this.items = this.el.find('.contentAccordionItem');
      }
      return this.items;
    };

    Plugin.prototype.selectItem = function(eq) {
      return this.getItems().removeClass('active').eq(eq).addClass('active');
    };

    return Plugin;

  })();
  $.fn[pluginName] = function(options) {
    return this.each(function() {
      if (!$.data(this, 'plugin_#{pluginName}')) {
        $.data(this, 'plugin_#{pluginName}', new Plugin(this, options));
      }
    });
  };
});
