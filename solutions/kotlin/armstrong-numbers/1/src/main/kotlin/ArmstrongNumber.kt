object ArmstrongNumber {
    fun check(number: Int): Boolean {
        if (number < 0) return false

        val digits = generateSequence(number) { it / 10 }
            .takeWhile { it > 0 }
            .map { it % 10 }
            .toList()

        return digits.sumOf { digit ->
            (1..digits.size).fold(1L) { power, _ -> power * digit }
        } == number.toLong()
    }
}
