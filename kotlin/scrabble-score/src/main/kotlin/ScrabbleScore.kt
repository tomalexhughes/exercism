object ScrabbleScore {

    val scoreMap: Map<Int, CharList> = mapOf(
            1 to listOf('A', 'E', 'I', 'O', 'U', 'L', 'N', 'R', 'S', 'T'),
            2 to listOf('D', 'G'),
            3 to listOf('B', 'C', 'M', 'P'),
            4 to listOf('F', 'H', 'V', 'W', 'Y'),
            5 to listOf('K'),
            8 to listOf('J', 'X'),
            10 to listOf('Q', 'Z')
    )

    fun scoreLetter(c: Char): Int {
        return scoreMap.filterValues { it.contains(c) }.keys.first()
    }

    fun scoreWord(word: String): Int {
        return word.toUpperCase().sumBy(::scoreLetter)
    }
}
