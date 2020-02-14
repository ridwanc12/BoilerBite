import UIKit
import Foundation

// URL for example meal request
// https://api.hfs.purdue.edu/menus/v2/locations/ford/2019-02-04

var address = "https://api.hfs.purdue.edu/menus/v2/locations/ford/2019-02-04"
var requestLocation = URL(string: address)

URLSession.shared.dataTask(with: requestLocation!) { (data, response, error) in
    do {
        print(data)
    } catch {
        print("There was an error in the api request")
        print(error)
    }
}.resume()

// URL for example item api request
// https://api.hfs.purdue.edu/menus/v2/items/6c883ba0-e283-4086-ab01-e181a6615435

var address2 = "https://api.hfs.purdue.edu/menus/v2/items/6c883ba0-e283-4086-ab01-e181a6615435"
var requestLocation2 = URL(string: address2)

URLSession.shared.dataTask(with: requestLocation2!) { (data, response, error) in
    do {
        print(data)
    } catch {
        print("There was an error in the api request")
        print(error)
    }
    }.resume()
