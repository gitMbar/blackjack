#todo: refactor to have a game beneath the outer blackjack model
class window.App extends Backbone.Model

  initialize: ->
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()

    playerHand = @get 'playerHand'
    dealerHand = @get 'dealerHand'

    playerHand.on('add', ->
        if @scores()[0] >= 21 then @stand()
      , playerHand)

    dealerHand.on('add', ->
        if @scores()[0] <= 17 then @hit else @stand()
      , dealerHand)

    playerHand.on('stand', ->
      dealerHand.at(0).flip()
      dealerHand.hit()
      #if less than 21 then dealerPlay else game over
      )

    dealerHand.on('stand', ->
      #game over
      )
