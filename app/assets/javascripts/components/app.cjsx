# @cjsx React.DOM

# React = require 'react'
{Router, Routes, Route, Link} = require 'react-router'
# require components here:

DynamicRouter      = require './dynamic-router'

# this would come from an endpoint
project = 
  workflow:
    mark: null
    transcribe:
      steps: [
          {
            key: '0',
            name: 'date',
            label: 'Date'
            description: 'Please type-in the log date.'
          },
          {
            key: '1',
            name: 'entry'
            label: 'Journal Entry'
            description: 'Please type-in the journal entry for this day.'
          }
      ]
  pages: [
    {
      name:    'info', 
      content: 'I am a content thingie'
    },
    {
      name:    'science', 
      content: 'I am science'
    }
  ]

App = React.createClass
  displayname: 'app'

  render: ->
    <div>
      <div className="readymade-site-background">
        <div className="readymade-site-background-effect"></div>
      </div>
      <DynamicRouter project= {project} />
    </div>
module.exports = App
