object Raindrops {

    fun convert(n: Int): String {
        var outputString = ""
        if (n % 3 === 0) outputString += "Pling"
        if (n % 5 === 0) outputString += "Plang"
        if (n % 7 === 0) outputString += "Plong"
        if (outputString === "") return n.toString() else return outputString
    }
}
