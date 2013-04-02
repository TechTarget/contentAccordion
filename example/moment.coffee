# moment.js
# version : 2.0.0
# author : Tim Wood
# license : MIT
# momentjs.com

###
Constants
###

# internal storage for language config files

# check for nodeJS

# ASP.NET json date format regex

# format tokens

# parsing tokens

# parsing token regexes
# 0 - 99
# 0 - 999
# 000 - 999
# 0 - 9999
# -999,999 - 999,999
# any word (or two) characters or numbers including two word month in arabic.
# +00:00 -00:00 +0000 -0000 or Z
# T (ISO seperator)
# 123456789 123456789.123

# preliminary iso regex
# 0000-00-00 + T + 00 or 00:00 or 00:00:00 or 00:00:00.000 + +00:00 or +0000

# iso time formats and regexes

# timezone chunker "+10:00" > ["10", "00"] or "-1530" > ["-15", "30"]

# getter and setter names

# format function strings

# tokens to ordinalize and pad

###
Constructors
###

# Moment prototype object

# Duration Constructor

# representation for dateAddRemove
# 1000
# 1000 * 60
# 1000 * 60 * 60
# Because of dateAddRemove treats 24 hours as different from a
# day when working around DST, we need to store them separately

# It is impossible translate months into days without knowing
# which months you are are talking about, so we have to store
# it separately.

# The following code bubbles up values, see the tests for
# examples of what that means.

###
Helpers
###

# left zero fill a number
# see http://jsperf.com/left-zero-filling for performance comparison

# helper function for _.addTime and _.subtractTime

# check if is an array

# compare two arrays, return the number of differences

###
Languages
###

# make the regex if we don't have it already

# test the regex
# Sunday is the first day of the week.
# The week that contains Jan 1st is the first week of the year.

# Loads a language definition into the `languages` cache.  The function
# takes a key and optionally values.  If not in the browser and no values
# are provided, it will load the language file module.  As a convenience,
# this function also returns the language values.

# Determines which language definition to use and returns it.
#
# With no parameters, it will return the global language.  If you
# pass in a language key, such as 'en', it will return the
# definition for 'en', so long as 'en' has already been loaded using
# moment.lang.

###
Formatting
###

# format date using native date object

###
Parsing
###

# get the regex to find the next token

# function to convert string input to date

# MONTH
# fall through to MM
# fall through to MMMM

# if we didn't find a month name, mark the date as invalid.

# DAY OF MONTH
# fall through to DDDD
# fall through to DDDD
# fall through to DDDD

# YEAR

# AM / PM
# fall through to A

# 24 HOUR
# fall through to hh
# fall through to hh
# fall through to hh

# MINUTE
# fall through to mm

# SECOND
# fall through to ss

# MILLISECOND

# UNIX TIMESTAMP WITH MS

# TIMEZONE
# fall through to ZZ

# reverse offsets

# if the input is null, the date is not valid

# convert an array to a date.
# the array should mirror the parameters below
# note: all values past the year are optional and will default to the lowest possible value.
# [year, month, day , hour, minute, second, millisecond]

# add the offsets to the time to be parsed so that we can have a clean array for checking isValid

# date from string and format string

# This array is used to make a Date, either with `new Date` or `Date.UTC`

# don't parse if its not a known token

# handle am pm

# if is 12 am, change hours to 0

# return

# date from string and array of format strings

# date from iso format

###
Relative Time
###

# helper function for moment.fn.from, moment.fn.fromNow, and moment.duration.fn.humanize

###
Week of Year
###

# firstDayOfWeek       0 = sun, 6 = sat
#                      the day of the week that starts the week
#                      (usually sunday or monday)
# firstDayOfWeekOfYear 0 = sun, 6 = sat
#                      the first week is the week that contains the first
#                      of this day of the week
#                      (eg. ISO weeks use thursday (4))

###
Top Level Functions
###

# creating with utc

# creating with unix timestamp (in seconds)

# duration

# version number

# default format

# This function will load languages and then set the global language.  If
# no arguments are passed in, it will simply return the current global
# language key.

# returns language data

# compare moment object

# for typechecking Duration objects

###
Moment Prototype
###

# switch args to support add('s', 1) and add(1, 's')

# switch args to support subtract('s', 1) and subtract(1, 's')

# standardize on singular form
# 24 * 60 * 60 * 1000 / 2
# 1000
# 1000 * 60
# 1000 * 60 * 60
# 1000 * 60 * 60 * 24
# 1000 * 60 * 60 * 24 * 7

# the following switch intentionally omits break keywords
# to utilize falling through the cases.

# falls through

# falls through

# falls through

# falls through

# falls through

# falls through

# weeks are a special case

# If passed a language key, it will set the language for this
# instance.  Otherwise, it will return the language configuration
# variables for this instance.

# helper for adding shortcuts

# loop through and add shortcuts (Month, Date, Hours, Minutes, Seconds, Milliseconds)

# add shortcut for year (uses different syntax than the getter/setter 'year' == 'FullYear')

# add plural methods

###
Duration Prototype
###

###
Default Lang
###

# Set default language, other languages will inherit from English.

###
Exposing Moment
###

# CommonJS module is defined

#global ender:false

# here, `this` means `window` in the browser, or `global` on the server
# add `moment` as a global object via a string identifier,
# for Closure Compiler "advanced" mode

#global define:false
((undefined_) ->
  padToken = (func, count) ->
    (a) ->
      leftZeroFill func.call(this, a), count
  ordinalizeToken = (func) ->
    (a) ->
      @lang().ordinal func.call(this, a)
  Language = ->
  Moment = (config) ->
    extend this, config
  Duration = (duration) ->
    data = @_data = {}
    years = duration.years or duration.year or duration.y or 0
    months = duration.months or duration.month or duration.M or 0
    weeks = duration.weeks or duration.week or duration.w or 0
    days = duration.days or duration.day or duration.d or 0
    hours = duration.hours or duration.hour or duration.h or 0
    minutes = duration.minutes or duration.minute or duration.m or 0
    seconds = duration.seconds or duration.second or duration.s or 0
    milliseconds = duration.milliseconds or duration.millisecond or duration.ms or 0
    @_milliseconds = milliseconds + seconds * 1e3 + minutes * 6e4 + hours * 36e5
    @_days = days + weeks * 7
    @_months = months + years * 12
    data.milliseconds = milliseconds % 1000
    seconds += absRound(milliseconds / 1000)
    data.seconds = seconds % 60
    minutes += absRound(seconds / 60)
    data.minutes = minutes % 60
    hours += absRound(minutes / 60)
    data.hours = hours % 24
    days += absRound(hours / 24)
    days += weeks * 7
    data.days = days % 30
    months += absRound(days / 30)
    data.months = months % 12
    years += absRound(months / 12)
    data.years = years
  extend = (a, b) ->
    for i of b
      a[i] = b[i]  if b.hasOwnProperty(i)
    a
  absRound = (number) ->
    if number < 0
      Math.ceil number
    else
      Math.floor number
  leftZeroFill = (number, targetLength) ->
    output = number + ""
    output = "0" + output  while output.length < targetLength
    output
  addOrSubtractDurationFromMoment = (mom, duration, isAdding) ->
    ms = duration._milliseconds
    d = duration._days
    M = duration._months
    currentDate = undefined
    mom._d.setTime +mom + ms * isAdding  if ms
    mom.date mom.date() + d * isAdding  if d
    if M
      currentDate = mom.date()
      mom.date(1).month(mom.month() + M * isAdding).date Math.min(currentDate, mom.daysInMonth())
  isArray = (input) ->
    Object::toString.call(input) is "[object Array]"
  compareArrays = (array1, array2) ->
    len = Math.min(array1.length, array2.length)
    lengthDiff = Math.abs(array1.length - array2.length)
    diffs = 0
    i = undefined
    i = 0
    while i < len
      diffs++  if ~~array1[i] isnt ~~array2[i]
      i++
    diffs + lengthDiff
  loadLang = (key, values) ->
    values.abbr = key
    languages[key] = new Language()  unless languages[key]
    languages[key].set values
    languages[key]
  getLangDefinition = (key) ->
    return moment.fn._lang  unless key
    require "./lang/" + key  if not languages[key] and hasModule
    languages[key]
  removeFormattingTokens = (input) ->
    return input.replace(/^\[|\]$/g, "")  if input.match(/\[.*\]/)
    input.replace /\\/g, ""
  makeFormatFunction = (format) ->
    array = format.match(formattingTokens)
    i = undefined
    length = undefined
    i = 0
    length = array.length

    while i < length
      if formatTokenFunctions[array[i]]
        array[i] = formatTokenFunctions[array[i]]
      else
        array[i] = removeFormattingTokens(array[i])
      i++
    (mom) ->
      output = ""
      i = 0
      while i < length
        output += (if typeof array[i].call is "function" then array[i].call(mom, format) else array[i])
        i++
      output
  formatMoment = (m, format) ->
    replaceLongDateFormatTokens = (input) ->
      m.lang().longDateFormat(input) or input
    i = 5
    format = format.replace(localFormattingTokens, replaceLongDateFormatTokens)  while i-- and localFormattingTokens.test(format)
    formatFunctions[format] = makeFormatFunction(format)  unless formatFunctions[format]
    formatFunctions[format] m
  getParseRegexForToken = (token) ->
    switch token
      when "DDDD"
        parseTokenThreeDigits
      when "YYYY"
        parseTokenFourDigits
      when "YYYYY"
        parseTokenSixDigits
      when "S", "SS"
    , "SSS"
    , "DDD"
        parseTokenOneToThreeDigits
      when "MMM", "MMMM"
    , "dd"
    , "ddd"
    , "dddd"
    , "a"
    , "A"
        parseTokenWord
      when "X"
        parseTokenTimestampMs
      when "Z", "ZZ"
        parseTokenTimezone
      when "T"
        parseTokenT
      when "MM", "DD"
    , "YY"
    , "HH"
    , "hh"
    , "mm"
    , "ss"
    , "M"
    , "D"
    , "d"
    , "H"
    , "h"
    , "m"
    , "s"
        parseTokenOneOrTwoDigits
      else
        new RegExp(token.replace("\\", ""))
  addTimeToArrayFromToken = (token, input, config) ->
    a = undefined
    b = undefined
    datePartArray = config._a
    switch token
      when "M", "MM"
        datePartArray[1] = (if (not (input?)) then 0 else ~~input - 1)
      when "MMM", "MMMM"
        a = getLangDefinition(config._l).monthsParse(input)
        if a?
          datePartArray[1] = a
        else
          config._isValid = false
      when "D", "DD"
    , "DDD"
    , "DDDD"
        datePartArray[2] = ~~input  if input?
      when "YY"
        datePartArray[0] = ~~input + ((if ~~input > 68 then 1900 else 2000))
      when "YYYY", "YYYYY"
        datePartArray[0] = ~~input
      when "a", "A"
        config._isPm = ((input + "").toLowerCase() is "pm")
      when "H", "HH"
    , "h"
    , "hh"
        datePartArray[3] = ~~input
      when "m", "mm"
        datePartArray[4] = ~~input
      when "s", "ss"
        datePartArray[5] = ~~input
      when "S", "SS"
    , "SSS"
        datePartArray[6] = ~~(("0." + input) * 1000)
      when "X"
        config._d = new Date(parseFloat(input) * 1000)
      when "Z", "ZZ"
        config._useUTC = true
        a = (input + "").match(parseTimezoneChunker)
        config._tzh = ~~a[1]  if a and a[1]
        config._tzm = ~~a[2]  if a and a[2]
        if a and a[0] is "+"
          config._tzh = -config._tzh
          config._tzm = -config._tzm
    config._isValid = false  unless input?
  dateFromArray = (config) ->
    i = undefined
    date = undefined
    input = []
    return  if config._d
    i = 0
    while i < 7
      config._a[i] = input[i] = (if (not (config._a[i]?)) then ((if i is 2 then 1 else 0)) else config._a[i])
      i++
    input[3] += config._tzh or 0
    input[4] += config._tzm or 0
    date = new Date(0)
    if config._useUTC
      date.setUTCFullYear input[0], input[1], input[2]
      date.setUTCHours input[3], input[4], input[5], input[6]
    else
      date.setFullYear input[0], input[1], input[2]
      date.setHours input[3], input[4], input[5], input[6]
    config._d = date
  makeDateFromStringAndFormat = (config) ->
    tokens = config._f.match(formattingTokens)
    string = config._i
    i = undefined
    parsedInput = undefined
    config._a = []
    i = 0
    while i < tokens.length
      parsedInput = (getParseRegexForToken(tokens[i]).exec(string) or [])[0]
      string = string.slice(string.indexOf(parsedInput) + parsedInput.length)  if parsedInput
      addTimeToArrayFromToken tokens[i], parsedInput, config  if formatTokenFunctions[tokens[i]]
      i++
    config._a[3] += 12  if config._isPm and config._a[3] < 12
    config._a[3] = 0  if config._isPm is false and config._a[3] is 12
    dateFromArray config
  makeDateFromStringAndArray = (config) ->
    tempConfig = undefined
    tempMoment = undefined
    bestMoment = undefined
    scoreToBeat = 99
    i = undefined
    currentScore = undefined
    i = config._f.length
    while i > 0
      tempConfig = extend({}, config)
      tempConfig._f = config._f[i - 1]
      makeDateFromStringAndFormat tempConfig
      tempMoment = new Moment(tempConfig)
      if tempMoment.isValid()
        bestMoment = tempMoment
        break
      currentScore = compareArrays(tempConfig._a, tempMoment.toArray())
      if currentScore < scoreToBeat
        scoreToBeat = currentScore
        bestMoment = tempMoment
      i--
    extend config, bestMoment
  makeDateFromString = (config) ->
    i = undefined
    string = config._i
    if isoRegex.exec(string)
      config._f = "YYYY-MM-DDT"
      i = 0
      while i < 4
        if isoTimes[i][1].exec(string)
          config._f += isoTimes[i][0]
          break
        i++
      config._f += " Z"  if parseTokenTimezone.exec(string)
      makeDateFromStringAndFormat config
    else
      config._d = new Date(string)
  makeDateFromInput = (config) ->
    input = config._i
    matched = aspNetJsonRegex.exec(input)
    if input is `undefined`
      config._d = new Date()
    else if matched
      config._d = new Date(+matched[1])
    else if typeof input is "string"
      makeDateFromString config
    else if isArray(input)
      config._a = input.slice(0)
      dateFromArray config
    else
      config._d = (if input instanceof Date then new Date(+input) else new Date(input))
  substituteTimeAgo = (string, number, withoutSuffix, isFuture, lang) ->
    lang.relativeTime number or 1, !!withoutSuffix, string, isFuture
  relativeTime = (milliseconds, withoutSuffix, lang) ->
    seconds = round(Math.abs(milliseconds) / 1000)
    minutes = round(seconds / 60)
    hours = round(minutes / 60)
    days = round(hours / 24)
    years = round(days / 365)
    args = seconds < 45 and ["s", seconds] or minutes is 1 and ["m"] or minutes < 45 and ["mm", minutes] or hours is 1 and ["h"] or hours < 22 and ["hh", hours] or days is 1 and ["d"] or days <= 25 and ["dd", days] or days <= 45 and ["M"] or days < 345 and ["MM", round(days / 30)] or years is 1 and ["y"] or ["yy", years]
    args[2] = withoutSuffix
    args[3] = milliseconds > 0
    args[4] = lang
    substituteTimeAgo.apply {}, args
  weekOfYear = (mom, firstDayOfWeek, firstDayOfWeekOfYear) ->
    end = firstDayOfWeekOfYear - firstDayOfWeek
    daysToDayOfWeek = firstDayOfWeekOfYear - mom.day()
    daysToDayOfWeek -= 7  if daysToDayOfWeek > end
    daysToDayOfWeek += 7  if daysToDayOfWeek < end - 7
    Math.ceil moment(mom).add("d", daysToDayOfWeek).dayOfYear() / 7
  makeMoment = (config) ->
    input = config._i
    format = config._f
    return null  if input is null or input is ""
    config._i = input = getLangDefinition().preparse(input)  if typeof input is "string"
    if moment.isMoment(input)
      config = extend({}, input)
      config._d = new Date(+input._d)
    else if format
      if isArray(format)
        makeDateFromStringAndArray config
      else
        makeDateFromStringAndFormat config
    else
      makeDateFromInput config
    new Moment(config)
  makeGetterAndSetter = (name, key) ->
    moment.fn[name] = moment.fn[name + "s"] = (input) ->
      utc = (if @_isUTC then "UTC" else "")
      if input?
        @_d["set" + utc + key] input
        this
      else
        @_d["get" + utc + key]()
  makeDurationGetter = (name) ->
    moment.duration.fn[name] = ->
      @_data[name]
  makeDurationAsGetter = (name, factor) ->
    moment.duration.fn["as" + name] = ->
      +this / factor
  moment = undefined
  VERSION = "2.0.0"
  round = Math.round
  i = undefined
  languages = {}
  hasModule = (typeof module isnt "undefined" and module.exports)
  aspNetJsonRegex = /^\/?Date\((\-?\d+)/i
  formattingTokens = /(\[[^\[]*\])|(\\)?(Mo|MM?M?M?|Do|DDDo|DD?D?D?|ddd?d?|do?|w[o|w]?|W[o|W]?|YYYYY|YYYY|YY|a|A|hh?|HH?|mm?|ss?|SS?S?|X|zz?|ZZ?|.)/g
  localFormattingTokens = /(\[[^\[]*\])|(\\)?(LT|LL?L?L?|l{1,4})/g
  parseMultipleFormatChunker = /([0-9a-zA-Z\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]+)/g
  parseTokenOneOrTwoDigits = /\d\d?/
  parseTokenOneToThreeDigits = /\d{1,3}/
  parseTokenThreeDigits = /\d{3}/
  parseTokenFourDigits = /\d{1,4}/
  parseTokenSixDigits = /[+\-]?\d{1,6}/
  parseTokenWord = /[0-9]*[a-z\u00A0-\u05FF\u0700-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]+|[\u0600-\u06FF]+\s*?[\u0600-\u06FF]+/i
  parseTokenTimezone = /Z|[\+\-]\d\d:?\d\d/i
  parseTokenT = /T/i
  parseTokenTimestampMs = /[\+\-]?\d+(\.\d{1,3})?/
  isoRegex = /^\s*\d{4}-\d\d-\d\d((T| )(\d\d(:\d\d(:\d\d(\.\d\d?\d?)?)?)?)?([\+\-]\d\d:?\d\d)?)?/
  isoFormat = "YYYY-MM-DDTHH:mm:ssZ"
  isoTimes = [["HH:mm:ss.S", /(T| )\d\d:\d\d:\d\d\.\d{1,3}/], ["HH:mm:ss", /(T| )\d\d:\d\d:\d\d/], ["HH:mm", /(T| )\d\d:\d\d/], ["HH", /(T| )\d\d/]]
  parseTimezoneChunker = /([\+\-]|\d\d)/g
  proxyGettersAndSetters = "Month|Date|Hours|Minutes|Seconds|Milliseconds".split("|")
  unitMillisecondFactors =
    Milliseconds: 1
    Seconds: 1e3
    Minutes: 6e4
    Hours: 36e5
    Days: 864e5
    Months: 2592e6
    Years: 31536e6

  formatFunctions = {}
  ordinalizeTokens = "DDD w W M D d".split(" ")
  paddedTokens = "M D H h m s w W".split(" ")
  formatTokenFunctions =
    M: ->
      @month() + 1

    MMM: (format) ->
      @lang().monthsShort this, format

    MMMM: (format) ->
      @lang().months this, format

    D: ->
      @date()

    DDD: ->
      @dayOfYear()

    d: ->
      @day()

    dd: (format) ->
      @lang().weekdaysMin this, format

    ddd: (format) ->
      @lang().weekdaysShort this, format

    dddd: (format) ->
      @lang().weekdays this, format

    w: ->
      @week()

    W: ->
      @isoWeek()

    YY: ->
      leftZeroFill @year() % 100, 2

    YYYY: ->
      leftZeroFill @year(), 4

    YYYYY: ->
      leftZeroFill @year(), 5

    a: ->
      @lang().meridiem @hours(), @minutes(), true

    A: ->
      @lang().meridiem @hours(), @minutes(), false

    H: ->
      @hours()

    h: ->
      @hours() % 12 or 12

    m: ->
      @minutes()

    s: ->
      @seconds()

    S: ->
      ~~(@milliseconds() / 100)

    SS: ->
      leftZeroFill ~~(@milliseconds() / 10), 2

    SSS: ->
      leftZeroFill @milliseconds(), 3

    Z: ->
      a = -@zone()
      b = "+"
      if a < 0
        a = -a
        b = "-"
      b + leftZeroFill(~~(a / 60), 2) + ":" + leftZeroFill(~~a % 60, 2)

    ZZ: ->
      a = -@zone()
      b = "+"
      if a < 0
        a = -a
        b = "-"
      b + leftZeroFill(~~(10 * a / 6), 4)

    X: ->
      @unix()

  while ordinalizeTokens.length
    i = ordinalizeTokens.pop()
    formatTokenFunctions[i + "o"] = ordinalizeToken(formatTokenFunctions[i])
  while paddedTokens.length
    i = paddedTokens.pop()
    formatTokenFunctions[i + i] = padToken(formatTokenFunctions[i], 2)
  formatTokenFunctions.DDDD = padToken(formatTokenFunctions.DDD, 3)
  Language:: =
    set: (config) ->
      prop = undefined
      i = undefined
      for i of config
        prop = config[i]
        if typeof prop is "function"
          this[i] = prop
        else
          this["_" + i] = prop

    _months: "January_February_March_April_May_June_July_August_September_October_November_December".split("_")
    months: (m) ->
      @_months[m.month()]

    _monthsShort: "Jan_Feb_Mar_Apr_May_Jun_Jul_Aug_Sep_Oct_Nov_Dec".split("_")
    monthsShort: (m) ->
      @_monthsShort[m.month()]

    monthsParse: (monthName) ->
      i = undefined
      mom = undefined
      regex = undefined
      output = undefined
      @_monthsParse = []  unless @_monthsParse
      i = 0
      while i < 12
        unless @_monthsParse[i]
          mom = moment([2000, i])
          regex = "^" + @months(mom, "") + "|^" + @monthsShort(mom, "")
          @_monthsParse[i] = new RegExp(regex.replace(".", ""), "i")
        return i  if @_monthsParse[i].test(monthName)
        i++

    _weekdays: "Sunday_Monday_Tuesday_Wednesday_Thursday_Friday_Saturday".split("_")
    weekdays: (m) ->
      @_weekdays[m.day()]

    _weekdaysShort: "Sun_Mon_Tue_Wed_Thu_Fri_Sat".split("_")
    weekdaysShort: (m) ->
      @_weekdaysShort[m.day()]

    _weekdaysMin: "Su_Mo_Tu_We_Th_Fr_Sa".split("_")
    weekdaysMin: (m) ->
      @_weekdaysMin[m.day()]

    _longDateFormat:
      LT: "h:mm A"
      L: "MM/DD/YYYY"
      LL: "MMMM D YYYY"
      LLL: "MMMM D YYYY LT"
      LLLL: "dddd, MMMM D YYYY LT"

    longDateFormat: (key) ->
      output = @_longDateFormat[key]
      if not output and @_longDateFormat[key.toUpperCase()]
        output = @_longDateFormat[key.toUpperCase()].replace(/MMMM|MM|DD|dddd/g, (val) ->
          val.slice 1
        )
        @_longDateFormat[key] = output
      output

    meridiem: (hours, minutes, isLower) ->
      if hours > 11
        (if isLower then "pm" else "PM")
      else
        (if isLower then "am" else "AM")

    _calendar:
      sameDay: "[Today at] LT"
      nextDay: "[Tomorrow at] LT"
      nextWeek: "dddd [at] LT"
      lastDay: "[Yesterday at] LT"
      lastWeek: "[Last] dddd [at] LT"
      sameElse: "L"

    calendar: (key, mom) ->
      output = @_calendar[key]
      (if typeof output is "function" then output.apply(mom) else output)

    _relativeTime:
      future: "in %s"
      past: "%s ago"
      s: "a few seconds"
      m: "a minute"
      mm: "%d minutes"
      h: "an hour"
      hh: "%d hours"
      d: "a day"
      dd: "%d days"
      M: "a month"
      MM: "%d months"
      y: "a year"
      yy: "%d years"

    relativeTime: (number, withoutSuffix, string, isFuture) ->
      output = @_relativeTime[string]
      (if (typeof output is "function") then output(number, withoutSuffix, string, isFuture) else output.replace(/%d/i, number))

    pastFuture: (diff, output) ->
      format = @_relativeTime[(if diff > 0 then "future" else "past")]
      (if typeof format is "function" then format(output) else format.replace(/%s/i, output))

    ordinal: (number) ->
      @_ordinal.replace "%d", number

    _ordinal: "%d"
    preparse: (string) ->
      string

    postformat: (string) ->
      string

    week: (mom) ->
      weekOfYear mom, @_week.dow, @_week.doy

    _week:
      dow: 0
      doy: 6

  moment = (input, format, lang) ->
    makeMoment
      _i: input
      _f: format
      _l: lang
      _isUTC: false


  moment.utc = (input, format, lang) ->
    makeMoment
      _useUTC: true
      _isUTC: true
      _l: lang
      _i: input
      _f: format


  moment.unix = (input) ->
    moment input * 1000

  moment.duration = (input, key) ->
    isDuration = moment.isDuration(input)
    isNumber = (typeof input is "number")
    duration = ((if isDuration then input._data else ((if isNumber then {} else input))))
    ret = undefined
    if isNumber
      if key
        duration[key] = input
      else
        duration.milliseconds = input
    ret = new Duration(duration)
    ret._lang = input._lang  if isDuration and input.hasOwnProperty("_lang")
    ret

  moment.version = VERSION
  moment.defaultFormat = isoFormat
  moment.lang = (key, values) ->
    i = undefined
    return moment.fn._lang._abbr  unless key
    if values
      loadLang key, values
    else getLangDefinition key  unless languages[key]
    moment.duration.fn._lang = moment.fn._lang = getLangDefinition(key)

  moment.langData = (key) ->
    key = key._lang._abbr  if key and key._lang and key._lang._abbr
    getLangDefinition key

  moment.isMoment = (obj) ->
    obj instanceof Moment

  moment.isDuration = (obj) ->
    obj instanceof Duration

  moment.fn = Moment:: =
    clone: ->
      moment this

    valueOf: ->
      +@_d

    unix: ->
      Math.floor +@_d / 1000

    toString: ->
      @format "ddd MMM DD YYYY HH:mm:ss [GMT]ZZ"

    toDate: ->
      @_d

    toJSON: ->
      moment(this).utc().format "YYYY-MM-DD[T]HH:mm:ss.SSS[Z]"

    toArray: ->
      m = this
      [m.year(), m.month(), m.date(), m.hours(), m.minutes(), m.seconds(), m.milliseconds()]

    isValid: ->
      unless @_isValid?
        if @_a
          @_isValid = not compareArrays(@_a, ((if @_isUTC then moment.utc(@_a) else moment(@_a))).toArray())
        else
          @_isValid = not isNaN(@_d.getTime())
      !!@_isValid

    utc: ->
      @_isUTC = true
      this

    local: ->
      @_isUTC = false
      this

    format: (inputString) ->
      output = formatMoment(this, inputString or moment.defaultFormat)
      @lang().postformat output

    add: (input, val) ->
      dur = undefined
      if typeof input is "string"
        dur = moment.duration(+val, input)
      else
        dur = moment.duration(input, val)
      addOrSubtractDurationFromMoment this, dur, 1
      this

    subtract: (input, val) ->
      dur = undefined
      if typeof input is "string"
        dur = moment.duration(+val, input)
      else
        dur = moment.duration(input, val)
      addOrSubtractDurationFromMoment this, dur, -1
      this

    diff: (input, units, asFloat) ->
      that = (if @_isUTC then moment(input).utc() else moment(input).local())
      zoneDiff = (@zone() - that.zone()) * 6e4
      diff = undefined
      output = undefined
      units = units.replace(/s$/, "")  if units
      if units is "year" or units is "month"
        diff = (@daysInMonth() + that.daysInMonth()) * 432e5
        output = ((@year() - that.year()) * 12) + (@month() - that.month())
        output += ((this - moment(this).startOf("month")) - (that - moment(that).startOf("month"))) / diff
        output = output / 12  if units is "year"
      else
        diff = (this - that) - zoneDiff
        output = (if units is "second" then diff / 1e3 else (if units is "minute" then diff / 6e4 else (if units is "hour" then diff / 36e5 else (if units is "day" then diff / 864e5 else (if units is "week" then diff / 6048e5 else diff)))))
      (if asFloat then output else absRound(output))

    from: (time, withoutSuffix) ->
      moment.duration(@diff(time)).lang(@lang()._abbr).humanize not withoutSuffix

    fromNow: (withoutSuffix) ->
      @from moment(), withoutSuffix

    calendar: ->
      diff = @diff(moment().startOf("day"), "days", true)
      format = (if diff < -6 then "sameElse" else (if diff < -1 then "lastWeek" else (if diff < 0 then "lastDay" else (if diff < 1 then "sameDay" else (if diff < 2 then "nextDay" else (if diff < 7 then "nextWeek" else "sameElse"))))))
      @format @lang().calendar(format, this)

    isLeapYear: ->
      year = @year()
      (year % 4 is 0 and year % 100 isnt 0) or year % 400 is 0

    isDST: ->
      @zone() < moment([@year()]).zone() or @zone() < moment([@year(), 5]).zone()

    day: (input) ->
      day = (if @_isUTC then @_d.getUTCDay() else @_d.getDay())
      (if not input? then day else @add(d: input - day))

    startOf: (units) ->
      units = units.replace(/s$/, "")
      switch units
        when "year"
          @month 0
        when "month"
          @date 1
        when "week", "day"
          @hours 0
        when "hour"
          @minutes 0
        when "minute"
          @seconds 0
        when "second"
          @milliseconds 0
      @day 0  if units is "week"
      this

    endOf: (units) ->
      @startOf(units).add(units.replace(/s?$/, "s"), 1).subtract "ms", 1

    isAfter: (input, units) ->
      units = (if typeof units isnt "undefined" then units else "millisecond")
      +@clone().startOf(units) > +moment(input).startOf(units)

    isBefore: (input, units) ->
      units = (if typeof units isnt "undefined" then units else "millisecond")
      +@clone().startOf(units) < +moment(input).startOf(units)

    isSame: (input, units) ->
      units = (if typeof units isnt "undefined" then units else "millisecond")
      +@clone().startOf(units) is +moment(input).startOf(units)

    zone: ->
      (if @_isUTC then 0 else @_d.getTimezoneOffset())

    daysInMonth: ->
      moment.utc([@year(), @month() + 1, 0]).date()

    dayOfYear: (input) ->
      dayOfYear = round((moment(this).startOf("day") - moment(this).startOf("year")) / 864e5) + 1
      (if not input? then dayOfYear else @add("d", (input - dayOfYear)))

    isoWeek: (input) ->
      week = weekOfYear(this, 1, 4)
      (if not input? then week else @add("d", (input - week) * 7))

    week: (input) ->
      week = @lang().week(this)
      (if not input? then week else @add("d", (input - week) * 7))

    lang: (key) ->
      if key is `undefined`
        @_lang
      else
        @_lang = getLangDefinition(key)
        this

  i = 0
  while i < proxyGettersAndSetters.length
    makeGetterAndSetter proxyGettersAndSetters[i].toLowerCase().replace(/s$/, ""), proxyGettersAndSetters[i]
    i++
  makeGetterAndSetter "year", "FullYear"
  moment.fn.days = moment.fn.day
  moment.fn.weeks = moment.fn.week
  moment.fn.isoWeeks = moment.fn.isoWeek
  moment.duration.fn = Duration:: =
    weeks: ->
      absRound @days() / 7

    valueOf: ->
      @_milliseconds + @_days * 864e5 + @_months * 2592e6

    humanize: (withSuffix) ->
      difference = +this
      output = relativeTime(difference, not withSuffix, @lang())
      output = @lang().pastFuture(difference, output)  if withSuffix
      @lang().postformat output

    lang: moment.fn.lang

  for i of unitMillisecondFactors
    if unitMillisecondFactors.hasOwnProperty(i)
      makeDurationAsGetter i, unitMillisecondFactors[i]
      makeDurationGetter i.toLowerCase()
  makeDurationAsGetter "Weeks", 6048e5
  moment.lang "en",
    ordinal: (number) ->
      b = number % 10
      output = (if (~~(number % 100 / 10) is 1) then "th" else (if (b is 1) then "st" else (if (b is 2) then "nd" else (if (b is 3) then "rd" else "th"))))
      number + output

  module.exports = moment  if hasModule
  this["moment"] = moment  if typeof ender is "undefined"
  if typeof define is "function" and define.amd
    define "moment", [], ->
      moment

).call this