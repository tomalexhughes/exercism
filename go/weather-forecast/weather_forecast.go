// Package weather provides a function to forecast the current weather
// conditions of a city in Goblinocus.
package weather

// CurrentCondition is used to store the current weather condition.
var CurrentCondition string

// CurrentLocation is used to store the city being forecasted.
var CurrentLocation string

// Forecast returns a string for the forecast of a given city and weather
// condition.
func Forecast(city, condition string) string {
	CurrentLocation, CurrentCondition = city, condition
	return CurrentLocation + " - current weather condition: " + CurrentCondition
}
