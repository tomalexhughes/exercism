object Pangram {

    val alphabet = 'a'..'z'

    fun isPangram(input: String): Boolean = alphabet.all { input.toLowerCase().contains(it) }
}
