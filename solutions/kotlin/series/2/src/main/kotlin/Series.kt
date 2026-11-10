object Series {

    fun slices(span: Int, series: String): List<List<Int>> {
        require(span > 0) { "span must be greater than zero" }
        require(span <= series.length) { "span must not be greater than series length" }

        return series.map { it.digitToInt() }.windowed(span)
    }
}
