class RailFenceCipher(private val numberOfRails: Int) {

    private val cycle: List<Int> = (0 until numberOfRails) + (numberOfRails - 2 downTo 1)

    private fun railOf(position: Int): Int = cycle[position % cycle.size]

    private fun positionsInRailOrder(length: Int): List<Int> =
        (0 until length).sortedBy { position -> railOf(position) }

    fun getEncryptedData(letters: String): String =
        positionsInRailOrder(letters.length)
            .map { position -> letters[position] }
            .joinToString("")

    fun getDecryptedData(letters: String): String =
        positionsInRailOrder(letters.length)
            .zip(letters.toList())
            .sortedBy { (destination, _) -> destination }
            .map { (_, letter) -> letter }
            .joinToString("")
}
