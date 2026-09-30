const PENALTY_VALUE = { J: 1, Q: 2, K: 3, A: 4 };

function toValues(cards) {
  return cards.map((card) => PENALTY_VALUE[card] ?? 0);
}

function simulateGame(playerACards, playerBCards) {
  const state = {
    turn: 'a',
    deckA: toValues(playerACards),
    deckB: toValues(playerBCards),
    pile: [],
    due: 0,
    cardsPlayed: 0,
    tricks: 0,
  };

  const seenRounds = new Set();

  const activeDeck = () => (state.turn === 'a' ? state.deckA : state.deckB);
  const inactiveDeck = () => (state.turn === 'a' ? state.deckB : state.deckA);
  const switchTurn = () => {
    state.turn = state.turn === 'a' ? 'b' : 'a';
  };
  const roundKey = () =>
    `${state.turn}|${state.deckA.join(',')}|${state.deckB.join(',')}|${state.pile.join(',')}`;

  const playCard = () => {
    const card = activeDeck().shift();
    state.pile.push(card);
    state.cardsPlayed += 1;
    return card;
  };

  const resolveTrick = () => {
    const winnerDeck = inactiveDeck();
    winnerDeck.push(...state.pile);
    state.pile = [];
    state.due = 0;
    state.tricks += 1;
    switchTurn();
  };

  const startRound = () => {
    if (inactiveDeck().length === 0) {
      return { status: 'finished', cards: state.cardsPlayed, tricks: state.tricks };
    }
    const key = roundKey();
    if (seenRounds.has(key)) {
      return { status: 'loop', cards: state.cardsPlayed, tricks: state.tricks };
    }
    seenRounds.add(key);
    return null;
  };

  let result = startRound();

  while (result === null) {
    if (activeDeck().length === 0) {
      resolveTrick();
      result = startRound();
      continue;
    }

    const value = activeDeck()[0];

    if (value === 0) {
      playCard();
      if (state.due === 0) {
        switchTurn();
      } else if (state.due === 1) {
        resolveTrick();
        result = startRound();
      } else {
        state.due -= 1;
      }
    } else {
      playCard();
      switchTurn();
      state.due = value;
    }
  }

  return result;
}

module.exports = { simulateGame };
