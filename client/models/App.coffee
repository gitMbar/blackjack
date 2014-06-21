#todo: refactor to have a game beneath the outer blackjack model
class window.App extends Backbone.Model

  initialize: ->
    @set 'deck', deck = new Deck()
    @newGame()


  gameOver: ->
    # Compute stuff
    dealerHand = @get('dealerHand')
    playerHand = @get('playerHand')

    if (dealerHand.length is 2) and (dealerHand.bestScore() is 21)
      win = false
    else if (playerHand.length is 2) and (playerHand.bestScore() is 21)
      win = true
    else
      win = (playerHand.bestScore() <= 21) and ((playerHand.bestScore() > dealerHand.bestScore()) or (dealerHand.bestScore() > 21))

    @trigger('gameOver', win)

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
