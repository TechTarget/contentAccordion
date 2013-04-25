###!
contentAccordion v1.0.2 (http://okize.github.com/)
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
    indexOfOpenItem: 0, # which accordion item will be open on load
    maintainState: false # manages which item is active through url hashes

  # plugin constructor
  class Accordion

    # plugin constructor
    constructor: (@element, options) ->
      @el = $(@element)
      @options = $.extend({}, defaults, options)
      @_defaults = defaults
      @_name = pluginName
      @items = null
      @activeItem = @options.indexOfOpenItem
      @stateKey = 'accordionState'
      @hashObject = null
      @init()

    # plugin initializer
    init: ->

      # will update the component state if passed via url hash
      @updateState(@activeItem) if @options.maintainState and @getStateFromHash()?

      # cache items
      items = @getItems()

      # if the currentItem, as set in the options, is greater than the
      # total count of items, set it to the first item
      @activeItem = 0 if @activeItem >= items.length

      # apply 'active' class to first item or overridden item
      items.eq(@activeItem).addClass('active')

      # bind click handler to items
      items.on 'click', '.contentAccordionItemTitle', (e) =>
        e.preventDefault()
        @updateState( $(e.currentTarget).parent().index() )

    # checks if there's a hash for tab state maintenance
    # if there is, set activeTab var to hash state
    getStateFromHash: ->

      @hashObject = @getHashObject()
      return null if !@hashObject
      state = @hashObject[@stateKey] ? null
      return null if !state
      @activeItem = @hashObject[@stateKey]

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

    # caches the hash from the current window and returns an object of the hash
    getUrlHash: ->

      if window.location.hash then window.location.hash.substring(1) else null

    # updates url hash with tab identifier
    setUrlHash: (hash) ->

      window.location.hash = hash

    # returns jq collection of accordion items
    # will return from cache if called previously
    getItems: ->

      @items = @el.find('.contentAccordionItem') unless @items
      @items

    # 'selects' an item by applying 'active' class
    selectItem: (eq) ->

      @updateHash(eq) if (@options.maintainState)
      @getItems().removeClass('active').eq(eq).addClass('active')

    # updates the state of the component
    updateState: (eq) ->

      @activeItem = eq
      @selectItem(eq)

  # wrapper around the constructor that prevents multiple instantiations
  $.fn[pluginName] = (options) ->
    @each ->
      if !$.data(@, 'plugin_#{pluginName}')
        $.data(@, 'plugin_#{pluginName}', new Accordion(@, options))
      return
  return
