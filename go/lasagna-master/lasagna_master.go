package lasagna

func PreparationTime(layers []string, minutesPerLayer int) int {
	numberOfLayers := len(layers)

	if minutesPerLayer == 0 {
		minutesPerLayer = 2
	}

	return numberOfLayers * minutesPerLayer
}

func Quantities(quantities []string) (int, float64) {
	noodleLayers := 0
	sauceLayers := 0

	for _, v := range quantities {

		if v == "noodles" {
			noodleLayers += 1
		}

		if v == "sauce" {
			sauceLayers += 1
		}
	}

	sauceNeeded := float64(sauceLayers) * 0.2
	noodlesNeeded := noodleLayers * 50

	return noodlesNeeded, sauceNeeded
}

func AddSecretIngredient(friendsList []string, myList []string) {
	secretIngredient := friendsList[len(friendsList)-1]
	myList[len(myList)-1] = secretIngredient
}

func ScaleRecipe(quantities []float64, portions int) []float64 {
	scaled := make([]float64, 0, len(quantities))

	for _, v := range quantities {
		amount := v / 2 * float64(portions)
		scaled = append(scaled, amount)
	}

	return scaled
}
