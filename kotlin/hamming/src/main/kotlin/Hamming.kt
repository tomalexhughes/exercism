object Hamming {

    fun compute(leftStrand: String, rightStrand: String): Int {
        if (leftStrand.length !== rightStrand.length) throw IllegalArgumentException("left and right strands must be of equal length")
        return leftStrand.foldIndexed(0) { index, acc, cv -> if (cv !== rightStrand[index]) acc + 1 else acc }
    }
}
