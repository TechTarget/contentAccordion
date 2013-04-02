###!
contentAccordion v0.0.1 (http://okize.github.com/)
Copyright (c) 2013 | Licensed under the MIT license - http://www.opensource.org/licenses/mit-license.php
###

((factory) ->

  # use AMD or browser globals to create a jQuery plugin.
  if typeof define is 'function' and define.amd
    define [ 'jquery' ], factory
  else
    factory jQuery

) ($) ->

  'use strict'

  pluginName = 'contentAccordion'

  # default plugin options
  defaults =
    eqOfOpenPanel: 0,
    alwaysOnePanelOpen: true,

  # plugin constructor
  class Plugin

    constructor: (@element, options) ->
      @el = $(@element)
      @options = $.extend({}, defaults, options)
      @_defaults = defaults
      @_name = pluginName
      @items = null
      @currentItem = @options.eqOfOpenPanel
      @init()

    # initialize plugin
    init: ->

      # cache items
      items = @getItems()

      # apply 'active' class to first item or overrided item
      items.eq(@currentItem).addClass 'active'

      # bind click handler to items
      items.on 'click', '.contentAccordionItemTitle', (e) =>
        e.preventDefault()
        @currentItem = $(e.currentTarget).parent().index()
        @selectItem @currentItem

    # returns jq collection of tab elements
    # will return from cache if called previously
    getItems: ->
      @items = @el.find('.contentAccordionItem') unless @items
      @items

    # 'selects' an item by applying 'active' class
    selectItem: (eq) ->
      @getItems().removeClass('active').eq(eq).addClass 'active'


  # lightweight wrapper around the constructor that prevents multiple instantiations
  $.fn[pluginName] = (options) ->
    @each ->
      if !$.data(@, 'plugin_#{pluginName}')
        $.data(@, 'plugin_#{pluginName}', new Plugin(@, options))
      return
  return
