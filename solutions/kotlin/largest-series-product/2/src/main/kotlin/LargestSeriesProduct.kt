class Series(val series: String) {
    init {
        require(series.all { it.isDigit() }) {
            "Series must contain only digits"
        }
    }

    fun getLargestProduct(span: Int): Long {
        require(span > 0) { "Span must be greater than zero" }
        require(span <= series.length) {
            "Span must be less than or equal to the length of the series"
        }

        return series
            .map { it.digitToInt() }
            .windowed(span)
            .maxOf { it.product() }
    }

    private fun Iterable<Int>.product(): Long =
        fold(1L, Long::times)
}