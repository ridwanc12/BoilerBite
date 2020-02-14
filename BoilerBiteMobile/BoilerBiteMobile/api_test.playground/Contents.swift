import UIKit
import Foundation

// URL for example meal request
// https://api.hfs.purdue.edu/menus/v2/locations/ford/2019-02-04

var address = "https://api.hfs.purdue.edu/menus/v2/locations/ford/2019-02-04"
var requestLocation = URL(string: address)

URLSession.shared.dataTask(with: requestLocation!) { (data, response, error) in
    do {
        print(response)
    } catch {
        print("There was an error in the api request")
        print(error)
    }
}.resume()
