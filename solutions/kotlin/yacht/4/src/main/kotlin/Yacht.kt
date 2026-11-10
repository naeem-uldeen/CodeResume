import YachtCategory.*

object Yacht {
    fun solve(category: YachtCategory, vararg dice: Int): Int {
        val counts           = dice.asList().groupingBy { it }.eachCount()
        val isYacht          = counts.size == 1
        val isFullHouse      = counts.values.sorted() == listOf(2, 3)
        val fourOfAKind      = counts.entries.firstOrNull { it.value >= 4 }?.key
        val isLittleStraight = counts.keys == setOf(1, 2, 3, 4, 5)
        val isBigStraight    = counts.keys == setOf(2, 3, 4, 5, 6)

        return when (category) {
            ONES            -> dice.scoreOfSingle(1)
            TWOS            -> dice.scoreOfSingle(2)
            THREES          -> dice.scoreOfSingle(3)
            FOURS           -> dice.scoreOfSingle(4)
            FIVES           -> dice.scoreOfSingle(5)
            SIXES           -> dice.scoreOfSingle(6)
            YACHT           -> if (isYacht) 50 else 0
            LITTLE_STRAIGHT -> if (isLittleStraight) 30 else 0
            BIG_STRAIGHT    -> if (isBigStraight) 30 else 0
            FULL_HOUSE      -> if (isFullHouse) dice.sum() else 0
            FOUR_OF_A_KIND  -> fourOfAKind?.let { 4 * it } ?: 0
            CHOICE          -> dice.sum()
        }
    }

    private fun IntArray.scoreOfSingle(die: Int) =
        die * count { it == die }
}
