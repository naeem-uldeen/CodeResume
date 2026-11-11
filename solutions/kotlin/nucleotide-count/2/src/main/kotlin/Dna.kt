class Dna(private val dna: String) {
    init {
        require(dna.all { it in "ACGT" }) { "Input must contain valid nucleotides." }
    }

    val nucleotideCounts: Map<Char, Int> =
        EMPTY_COUNTS + dna.groupingBy { it }.eachCount()

    private companion object {
        val EMPTY_COUNTS: Map<Char, Int> = "ACGT".associateWith { 0 }
    }
}
