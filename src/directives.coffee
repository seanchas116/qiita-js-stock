'use strict'

Vue = require 'vue'
codeMirror = require 'codemirror'
sandbox = require 'browser-module-sandbox'

Vue.directive 'codemirror',

  twoWay: true

  bind: ->
    @editor = codeMirror.fromTextArea @el,
      lineNumbers: true
      mode: 'javascript'
      theme: 'twilight'

    @editor.on 'change', =>
      @set @editor.getValue()

  update: (value) ->
    @el.value = value

Vue.directive 'sandbox',

  bind: ->
    @sandbox = sandbox
      cdn: 'http://wzrd.in'
      iframe: @el

    @vm.$on 'build', =>
      @sandbox.bundle(@vm.$data.source)
