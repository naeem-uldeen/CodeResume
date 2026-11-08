import YachtCategory.*

object Yacht {
    fun solve(category: YachtCategory, vararg dice: Int): Int {
        val isYacht          = dice.distinct().size == 1
        val isFourOfAKind    = dice.distinct().any { n -> dice.count { it == n } >= 4 }
        val isFullHouse      = dice.distinct().size == 2 &&
                               dice.distinct().any { n -> dice.count { it == n } == 3 }
        val isLittleStraight = dice.sorted() == listOf(1, 2, 3, 4, 5)
        val isBigStraight    = dice.sorted() == listOf(2, 3, 4, 5, 6)

        return when (category) {
            ONES            -> dice.count { it == 1 } * 1
            TWOS            -> dice.count { it == 2 } * 2
            THREES          -> dice.count { it == 3 } * 3
            FOURS           -> dice.count { it == 4 } * 4
            FIVES           -> dice.count { it == 5 } * 5
            SIXES           -> dice.count { it == 6 } * 6
            YACHT           -> if (isYacht) 50 else 0
            LITTLE_STRAIGHT -> if (isLittleStraight) 30 else 0
            BIG_STRAIGHT    -> if (isBigStraight) 30 else 0
            FULL_HOUSE      -> if (isFullHouse) dice.sum() else 0
            FOUR_OF_A_KIND  -> {
                if (isFourOfAKind) {
                    val repeatedNumber = dice
                        .distinct()
                        .first { n -> dice.count { it == n } >= 4 }
                    4 * repeatedNumber
                } else {
                    0
                }
            }
            CHOICE          -> dice.sum()
        }
    }
}
