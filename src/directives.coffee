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
      theme: 'solarized'

    @editor.setValue @vm.$data.source

    @editor.on 'change', =>
      @vm.$data.source = @editor.getValue()

Vue.directive 'sandbox',

  bind: ->
    @sandbox = sandbox

      cdn: 'http://wzrd.in'
      container: @el
      iframeStyle: 'body { background-color: white; }'

    @vm.$on 'run', =>
      @sandbox.bundle(@vm.$data.source)
