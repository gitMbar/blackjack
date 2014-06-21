class window.AppView extends Backbone.View

  template: _.template '
    <button class="hit-button">Hit</button> <button class="stand-button">Stand</button> <button class="new-game-button disabled">New Game</button>
    <div class="player-hand-container"></div>
    <div class="dealer-hand-container"></div>
    <div class="game-status-container"></div>
  '

  events:
    "click .hit-button": ->
      @model.get('playerHand').hit()

    "click .stand-button": ->
      @model.get('playerHand').stand()
      @$('.hit-button, .stand-button').addClass('disabled')

    "click .new-game-button": ->
      @model.newGame()
      $('.hit-button, .stand-button').removeClass('disabled')
      @render()

  initialize: ->
    @render()

    @model.on('gameOver', (win) ->
        @$('.game-status-container').text( if win then "YOU WIN" else "YOU LOSE" )
        @$('.new-game-button').removeClass('disabled')
        @$('.hit-button, .stand-button').addClass('disabled')
      , @)

  render: ->
    @$el.children().detach()
    @$el.html @template()
    @$('.player-hand-container').html new HandView(collection: @model.get 'playerHand').el
    @$('.dealer-hand-container').html new HandView(collection: @model.get 'dealerHand').el
