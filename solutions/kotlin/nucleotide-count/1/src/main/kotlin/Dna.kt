class Dna(private val dna: String) {
    init {
        require(dna.all { it in "ACGT" }) { "Input must contain valid nucleotides." }
    }

    val nucleotideCounts: Map<Char, Int>
        get() {
            return mapOf('A' to 0, 'C' to 0, 'G' to 0, 'T' to 0) +
                dna.groupingBy { it }.eachCount()
        }
}
