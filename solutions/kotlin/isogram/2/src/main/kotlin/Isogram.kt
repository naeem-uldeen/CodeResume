object Isogram {

    fun isIsogram(input: String): Boolean {
        val letters = input.lowercase().filter { it.isLetter() }
        return letters.length == letters.toSet().size
    }
}
