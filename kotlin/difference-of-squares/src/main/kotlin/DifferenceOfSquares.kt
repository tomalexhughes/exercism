class Squares(private val input: Int) {

    private fun Int.square() = this * this

    fun sumOfSquares() = (1..input).sumBy { it.square() }

    fun squareOfSum() = (1..input).sum().square()

    fun difference() = squareOfSum() - sumOfSquares()
}
