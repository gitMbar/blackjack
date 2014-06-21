assert = chai.assert

describe 'win conditions', ->
  testApp = null
  testResult = null

  beforeEach ->
    testApp = new App()

  describe 'blackjack', ->
    it 'should win if player has blackjack and dealer has 21 but not blackjack', ->
      testApp.set('playerHand' , new Hand([new Card({rank: 0, suit: 1}), new Card({rank: 1, suit: 1})]))
      testApp.set('dealerHand' , new Hand([new Card({rank: 0, suit: 1}), new Card({rank: 0, suit: 1}), new Card({rank: 1, suit: 1})]))
      testApp.on('gameOver', (result) ->
        testResult = result
        )
      testApp.gameOver()
      assert.strictEqual(testResult, true)

    it 'should lose if player has 21 but not blackjack and dealer has blackjack', ->
      testApp.set('dealerHand' , new Hand([new Card({rank: 0, suit: 1}), new Card({rank: 1, suit: 1})]))
      testApp.set('playerHand' , new Hand([new Card({rank: 0, suit: 1}), new Card({rank: 0, suit: 1}), new Card({rank: 1, suit: 1})]))
      testApp.on('gameOver', (result) ->
        testResult = result
        )
      testApp.gameOver()
      assert.strictEqual(testResult, false)

    it 'should lose if both have blackjack', ->
      testApp.set('dealerHand' , new Hand([new Card({rank: 0, suit: 1}), new Card({rank: 1, suit: 1})]))
      testApp.set('playerHand' , new Hand([new Card({rank: 0, suit: 1}), new Card({rank: 1, suit: 1})]))
      testApp.on('gameOver', (result) ->
        testResult = result
        )
      testApp.gameOver()
      assert.strictEqual(testResult, false)

    it 'should lose if both have 21 but not blackjack', ->
      testApp.set('playerHand' , new Hand([new Card({rank: 0, suit: 1}), new Card({rank: 0, suit: 1}), new Card({rank: 1, suit: 1})]))
      testApp.set('dealerHand' , new Hand([new Card({rank: 0, suit: 1}), new Card({rank: 0, suit: 1}), new Card({rank: 1, suit: 1})]))
      testApp.on('gameOver', (result) ->
        testResult = result
        )
      testApp.gameOver()
      assert.strictEqual(testResult, false)
