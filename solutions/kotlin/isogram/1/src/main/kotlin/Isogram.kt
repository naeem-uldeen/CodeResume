object Isogram {
    fun isIsogram(input: String): Boolean {
        val originalLetters = input.lowercase().filter { it.isLetter() }.toList()
        return originalLetters == originalLetters.distinct()
    }
}
