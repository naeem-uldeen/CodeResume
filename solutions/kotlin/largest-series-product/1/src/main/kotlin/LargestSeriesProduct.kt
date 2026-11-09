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
            .map { it.toString().toLong() }
            .windowed(span)
            .maxOfOrNull { it.reduce { product, n -> product * n } } ?: 0L
    }
}
