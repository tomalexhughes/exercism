class Triangle<out T : Number>(val a: T, val b: T, val c: T) {

    private operator fun Number.plus(x: Number): Number = this.toDouble() + x.toDouble()
    private operator fun Number.compareTo(x: Number) = this.toDouble().compareTo(x.toDouble())

    init {
        require(a > 0 && b > 0 && c > 0)
        require(a <= b + c && b <= a + c && c <= a + b)
    }

    val isEquilateral: Boolean
        get() = a == b && b == c

    val isIsosceles: Boolean
        get() = a == b || b == c || a == c

    val isScalene: Boolean = !isIsosceles
}
