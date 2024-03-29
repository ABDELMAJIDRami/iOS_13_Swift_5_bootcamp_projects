/*
 here we are going to define the structure that the weather data is going to come back in (from Json)
 
 Regarding struct properties below: we can't name them wherever we want. Properties names should match Json keys/props names.
 Otherwise, the Decoder will not work.
*/

struct WeatherData: Codable	 {
    let name: String
    let main: Main
    let weather: [Weather]
}

struct Main: Codable {
    let temp: Double
}

struct Weather: Codable {
    let description: String
    let id: Int
    }
