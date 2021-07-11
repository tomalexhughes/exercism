// Provides gigasecond operations to Time
package gigasecond

import (
	"math"
	"time"
)

// Takes a Time and returns the Time with a gigasecond
// (1 billion seconds, 10^9) added
func AddGigasecond(t time.Time) time.Time {
	gigasecond := time.Duration(math.Pow10(9)) * time.Second
	return t.Add(gigasecond)
}
