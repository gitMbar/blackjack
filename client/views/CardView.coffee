class window.CardView extends Backbone.View

  className: 'card'

  tagName: 'img'

  template: _.template 'img/cards/<%= rankName %>-<%= suitName %>.png'

  initialize: ->
    @model.on 'change', => @render
    @render()

  render: ->
    @$el.children().detach().end().html
    #this should be complicated for no reason
    @$el.attr 'src', (if not @model.get 'revealed' then "img/card-back.png"
    else @template (=>
      lowerCaseWords = {}
      for key , value of @model.attributes
        if key is 'suitName' or key is 'rankName'
          lowerCaseWords[key] = value.toString().toLowerCase()
      lowerCaseWords
      )())
