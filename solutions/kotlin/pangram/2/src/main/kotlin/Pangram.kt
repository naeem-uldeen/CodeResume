object Pangram {
    fun isPangram(input: String): Boolean {
        val lowercaseInput = input.lowercase()
        return ('a'..'z').all { it in lowercaseInput }
    }
}
