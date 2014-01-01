###!
contentAccordion v1.0.3 (https://github.com/TechTarget/contentAccordion)
Author: Morgan Wigmanich <okize123@gmail.com> (http://github.com/okize)
Copyright (c) 2013 | Licensed under the MIT license
http://www.opensource.org/licenses/mit-license.php
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
    maintainState: false # manages which item is active through url hashes
    allCollapsible: false # allows all sections to be closed at same time
    activeItem: 0 # index of which accordion is open; -1 for all closed
    allowDataAttrOverride: false

  # plugin constructor
  class Accordion

    # plugin constructor
    constructor: (@element, options) ->
      @el = $(@element)
      @options = $.extend({}, defaults, options)
      @_defaults = defaults
      @_name = pluginName
      @items = null
      @activeItem = @options.activeItem
      @stateKey = 'accordionState'
      @hashObject = null
      @init()

    # plugin initializer
    init: ->

      items = @getItems()

      # add class to container when all sections can be collapsed
      @el.addClass('allCollapsible') if @options.allCollapsible

      # if accordion maintains state, get active item from url
      if @options.maintainState
        hashState = @getStateFromHash()
        if hashState != null
          @activeItem = hashState

      # inline data attribute override
      if @options.allowDataAttrOverride
        items.each (i) =>
          if items.eq(i).data('accordionOpen') is true
            @activeItem = i
            return

      # select the active section
      @selectItem(@activeItem)

      # bind click handler to items
      items.on 'click', '.contentAccordionItemTitle', (e) =>
        e.preventDefault()
        @updateState( $(e.currentTarget).parent().index() )

    # returns jq collection of accordion items
    # will return from cache if called previously
    getItems: ->

      @items = @el.find('.contentAccordionItem') unless @items
      @items

    # 'selects' an item by applying 'active' class
    selectItem: (eq) ->

      items = @getItems()
      item = items.eq(eq)

      # if -1 then all sections should be collapsed
      if eq == -1
        items.removeClass('active')
      else if item.hasClass('active') and @options.allCollapsible
        item.removeClass('active')
        eq = -1
      else
        items.removeClass('active')
        item.addClass('active')

      @activeItem = eq

    # updates the state of the component
    updateState: (eq) ->

      # if -1 then every section should be closed
      @selectItem(eq) if eq != -1
      @updateHash(eq) if @options.maintainState
      @activeItem = eq

    # checks if there's a hash for tab state maintenance
    getStateFromHash: ->

      @hashObject = @getHashObject()
      return null if !@hashObject

      state = @hashObject[@stateKey] ? null
      return null if !state

      return parseInt(@hashObject[@stateKey], 10)

    # returns null if no hashes, otherwise returns object created from hash
    getHashObject: ->

      hash = @getUrlHash()
      return null if !hash
      args = {}
      arr = hash.split('&')
      for item in arr
        arg = item.split('=')
        if (arg.length > 1)
          args[arg[0]] = arg[1]
        else
          args[arg[0]] = undefined
      args

    # converts the hash object into a string for the url hash
    buildHashObject: () ->

      $.param(@hashObject)

    # updates the cached hash object and then updates url
    updateHash: (eq) ->

      # convert to string
      eq += ''

      # get fresh hash obj in case another component has altered it
      @hashObject = @getHashObject()

      # if @hashObject is null, create it
      @hashObject = {} if !@hashObject

      # update hash
      @hashObject[@stateKey] = eq
      @setUrlHash(@buildHashObject())

    # returns the hash from the current window or null
    getUrlHash: ->

      if window.location.hash then window.location.hash.substring(1) else null

    # updates url hash with tab identifier
    setUrlHash: (hash) ->

      window.location.hash = hash

  # wrapper around the constructor that prevents multiple instantiations
  $.fn[pluginName] = (options) ->
    @each ->
      if !$.data(@, 'plugin_#{pluginName}')
        $.data(@, 'plugin_#{pluginName}', new Accordion(@, options))
      return
  return
