'use strict'

esprima = require 'esprima'
escodegen = require 'escodegen'
stripIndent = require 'strip-indent'

Vue = require 'vue'
require './directives'

markdown = ''

visit = (tree) ->

iterate = (tree) ->
  for own key, value of tree
    visit(value)

parse = (code) ->
  tree = esprima.parse code
  iterate(tree)
  markdown = tree.comments
    .filter (comment) -> comment.type == 'Block'
    .map (comment) -> stripIndent(comment.value)
    .join '\n'

document.addEventListener 'DOMContentLoaded', ->

  app = new Vue
    el: '#main'
    data:
      source: """
              /*
              @title 足し算
              */
              var path = require('path');

              var result = 10 * 20; //=>
              console.log(result);

              """
      markdown: ''
    methods:
      build: ->
        @$emit 'build'
