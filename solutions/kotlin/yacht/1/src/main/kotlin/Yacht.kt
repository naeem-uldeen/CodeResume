object Yacht {
    fun solve(category: YachtCategory, vararg dice: Int): Int {
        val isYacht          = dice.distinct().size == 1
        val isFourOfAKind    = dice.distinct().any { n -> dice.count { it == n } >= 4 }
        val isFullHouse      = dice.distinct().size == 2 && dice.distinct().any { n -> dice.count { it == n } == 3 }
        val isLittleStraight = dice.sorted() == listOf(1, 2, 3, 4, 5)
        val isBigStraight    = dice.sorted() == listOf(2, 3, 4, 5, 6)

        return when (category) {
            YachtCategory.ONES            -> dice.count { it == 1 } * 1
            YachtCategory.TWOS            -> dice.count { it == 2 } * 2
            YachtCategory.THREES          -> dice.count { it == 3 } * 3
            YachtCategory.FOURS           -> dice.count { it == 4 } * 4
            YachtCategory.FIVES           -> dice.count { it == 5 } * 5
            YachtCategory.SIXES           -> dice.count { it == 6 } * 6
            YachtCategory.YACHT           -> if (isYacht) 50 else 0
            YachtCategory.LITTLE_STRAIGHT -> if (isLittleStraight) 30 else 0
            YachtCategory.BIG_STRAIGHT    -> if (isBigStraight) 30 else 0
            YachtCategory.FULL_HOUSE      -> if (isFullHouse) dice.sum() else 0
            YachtCategory.FOUR_OF_A_KIND  -> {
                if (isFourOfAKind) {
                    val repeatedNumber = dice.distinct().first { n -> dice.count { it == n } >= 4 }
                    4 * repeatedNumber
                } else {
                    0
                }
            }
            YachtCategory.CHOICE          -> dice.sum()
        }
    }
}
