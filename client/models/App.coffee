#todo: refactor to have a game beneath the outer blackjack model
class window.App extends Backbone.Model

  initialize: ->
    @set 'deck', deck = new Deck()
    @newGame()


  gameOver: ->
    # Compute stuff
    win = (@get('playerHand').bestScore() <= 21) and ((@get('playerHand').bestScore() > @get('dealerHand').bestScore()) or (@get('dealerHand').bestScore() > 21))
    @trigger('gameOver', win)
    console.log("game over")

  newGame: ->
    if (@get 'deck').length < 26 then @set 'deck', deck = new Deck()

    @set 'playerHand', (@get "deck").dealPlayer()
    @set 'dealerHand', (@get "deck").dealDealer()

    playerHand = @get 'playerHand'
    dealerHand = @get 'dealerHand'

    playerHand.on('add', ->
        if @scores()[0] >= 21 then @stand()
      , playerHand)

    #happens after playerHand.stand
    dealerHand.on('add', ->
        if @bestScore() < 17 then @hit() else @stand()
      , dealerHand)

    playerHand.on('stand', ->
        dealerHand.at(0).flip()
        if playerHand.scores()[0] > 21 then @gameOver()
        else if dealerHand.bestScore() < 17 then dealerHand.hit()
        else @gameOver() #refactor to trigger?
      , @)

    dealerHand.on('stand', ->
        @gameOver()
      , @)
