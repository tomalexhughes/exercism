object Isogram {

    fun isIsogram(input: String): Boolean = input.toLowerCase().filter(Char::isLetter).groupingBy { it }.eachCount().all { it.value === 1 }
}
