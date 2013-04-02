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
    alwaysOnePanelOpen: true

  # plugin constructor
  class Plugin

    constructor: (@element, options) ->
      @el = $(@element)
      @options = $.extend({}, defaults, options)
      @_defaults = defaults
      @_name = pluginName
      @items = null
      @currentItem = 0
      @init()

    # initialize plugin
    init: ->

      # cache items
      items = @getItems()

      # apply 'active' class to first item
      items.eq(0).addClass 'active'

      # bind click handler to items
      self = this
      eq = undefined
      items.on 'click', '.contentAccordionItemTitle', (e) ->
        e.preventDefault()
        eq = $(this).parent().index()
        self.selectItem eq

    # returns jq collection of tab elements
    # will return from cache if called previously
    getItems: ->
      @items = @el.find('.contentAccordionItem') unless @items
      @items

    # 'selects' an item by applying 'active' class to parent element
    selectItem: (eq) ->
      @getItems().removeClass('active').eq(eq).addClass 'active'


  # lightweight wrapper around the constructor that prevents multiple instantiations
  $.fn[pluginName] = (options) ->
    @each ->
      if !$.data(@, 'plugin_#{pluginName}')
        $.data(@, 'plugin_#{pluginName}', new Plugin(@, options))
      return
  return
