object ArmstrongNumber {

    fun check(input: Int): Boolean = 
        input >= 0 &&
            input.toLong() == armstrongSum(input)

    private fun armstrongSum(number: Int): Long {
        val digits = number.toString().map { it.digitToInt() }
        return digits.sumOf { it.pow(digits.size) }
    }

    private fun Int.pow(n: Int): Long = (1..n).fold(1L) { acc, _ -> acc * this }
}
