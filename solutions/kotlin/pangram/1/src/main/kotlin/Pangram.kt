object Pangram {
    fun isPangram(input: String): Boolean {
        return ('a'..'z').all { input.lowercase().contains(it) }
    }
}
