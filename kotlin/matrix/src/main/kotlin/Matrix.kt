class Matrix(private val matrixAsString: String) {

    private val matrixAsList = matrixAsString.lines().map { it.split(" ").filter(String::isNotEmpty).map(String::toInt) }

    fun column(colNr: Int): List<Int> = matrixAsList.map { it.elementAt(colNr - 1) }

    fun row(rowNr: Int): List<Int> = matrixAsList[rowNr - 1]

}
