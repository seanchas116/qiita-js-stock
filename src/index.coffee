'use strict'

esprima = require 'esprima'
escodegen = require 'escodegen'
stripIndent = require 'strip-indent'
_ = require 'lodash'
trim = require 'trim'
Qiita = require 'qiita-js'

Vue = require 'vue'

require './private'
require './directives'

visit = (tree) ->


iterate = (tree) ->
  for own key, value of tree
    visit(value)

parse = (code) ->
  tree = esprima.parse code, range: true, comment: true
  iterate(tree)

  markdown = ''

  addMarkdown = (md) ->
    unless md.match(/^\s*$/)
      markdown += "\n#{trim(md)}\n"

  addCode = (code) ->
    unless code.match(/^\s*$/)
      markdown += "```:javascript\n#{trim(code)}\n```"

  i = 0
  commentCount = tree.comments.length

  while i < commentCount
    comment = tree.comments[i]

    if comment.type == 'Block'

      if lastComment?
        codeBegin = lastComment.range[1]
        codeEnd = comment.range[0]
        addCode(code.slice(codeBegin, codeEnd))

      addMarkdown(comment.value)

      lastComment = comment

    i += 1

  if lastComment
    addCode(code.slice(lastComment.range[1]))
  else
    addCode(code)

  markdown

document.addEventListener 'DOMContentLoaded', ->

  app = new Vue
    el: '#main'
    data:
      source: """
/*
@title jQueryでelementを追加する
@tags JavaScript, jQuery, browserify

jQueryでDOM要素を追加するサンプルです
*/

var $ = require('jquery');
var $elem = $('<p>test element</p>');

$('body').append($elem);

/*
## require

このツールでは browserify 経由で
簡単にライブラリを`require`できます
Thanks to [browserify-cdn](https://github.com/jesusabdullah/browserify-cdn)!!

## jQueryで要素を挿入

iframeの中のbodyに要素を挿入します
*/
              """
    methods:
      run: ->
        @$emit 'run'

      post: ->



    computed:
      markdown: ->
        parse(@source)

      markdownLines: ->
        @markdown.split('\n')

      title: ->
        for line in @markdownLines
          if match = line.match /(^\s*@title\s+)(.*)($)/
            return match[2]
        'Title'

      tags: ->
        for line in @markdownLines
          if match = line.match /(^\s*@tags\s+)(.*)($)/
            return match[2].split(/,\s*/)
        []
