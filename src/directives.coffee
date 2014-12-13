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

    @editor.setValue @vm.$data.source

    @editor.on 'change', =>
      @vm.$data.source = @editor.getValue()

Vue.directive 'sandbox',

  bind: ->
    @sandbox = sandbox

      cdn: 'http://wzrd.in'
      container: @el

    @vm.$on 'build', =>
      @sandbox.bundle(@vm.$data.source)
