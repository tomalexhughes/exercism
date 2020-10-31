import java.time.LocalDate
import java.time.LocalDateTime

class Gigasecond(localDateTime: LocalDateTime) {
    constructor(localDate: LocalDate) : this(localDate.atStartOfDay())

    val gigasecond: Long = 1_000_000_000

    val date: LocalDateTime = localDateTime.plusSeconds(gigasecond)
}