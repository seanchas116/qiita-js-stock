'use strict'

esprima = require 'esprima'
escodegen = require 'escodegen'
stripIndent = require 'strip-indent'
_ = require 'lodash'
trim = require 'trim'

Vue = require 'vue'
require './directives'

markdown = ''

visit = (tree) ->


iterate = (tree) ->
  for own key, value of tree
    visit(value)

parse = (code) ->
  tree = esprima.parse code, range: true, comment: true
  iterate(tree)

  markdown = ''

  addMarkdown = (md) ->
    markdown += "\n#{trim(md)}\n"

  addCode = (code) ->
    markdown += "```:javascript\n#{trim(code)}\n```"

  i = 0
  commentCount = tree.comments.length

  while i < commentCount
    comment = tree.comments[i]

    if comment.type == 'Block'

      if lastComment?
        codeBegin = lastComment.range[1]
        codeEnd = comment.range[0]
        code = code.slice(codeBegin, codeEnd)
        unless code.match(/^\s*$/)
          addCode(code)

      unless comment.value.match(/^\s*$/)
        addMarkdown(comment.value)

      lastComment = comment

    i += 1

  code = code.slice(lastComment.range[1])
  unless code.match(/^\s*$/)
    addCode(code)

  console.log(markdown)
  markdown

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

      post: ->
        @$data.markdown = parse(@$data.source)
