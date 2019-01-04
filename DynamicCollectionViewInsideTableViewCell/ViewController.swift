//
//  ViewController.swift
//  DynamicCollectionViewInsideTableViewCell
//
//  Created by Vishal Madheshia on 12/27/18.
//  Copyright © 2018 Vishal Madheshia. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var vehicles = [Vehicle]()
    let houseTypesToShow: [String: [String]] = ["RK1": ["RK1"], "BHK1": ["BHK1", "BHK1_5"], "BHK1_5": ["BHK1", "BHK1_5"], "BHK2": ["BHK2", "BHK2_5"], "BHK2_5": ["BHK2", "BHK2_5"], "BHK3": ["BHK3"]]
    
    var selectedHouseType = "RK1"
    
    var randomHouseSelect: String {
        let arr = ["RK1", "BHK1", "BHK1_5", "BHK2", "BHK2_5", "BHK3"]
        let randomIndex = Int(arc4random_uniform(UInt32(arr.count)))
        return arr[randomIndex]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        vehicles = getAllNewVehicles()
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Refresh", style: .plain, target: self, action: #selector(setRandomHouse))
    }
    
    func getAllNewVehicles() -> [Vehicle] {
        var vehicles = [Vehicle]()
        vehicles.append(Vehicle(houseType: "RK1",
                                vehicleType: "Tata Ace 6.5 Feet",
                                included: ["1 TV & TV Stand", "2 Chairs", "1 Washing Machine", "1 Fridge", "1 Single Cot", "10 Carton Box"], imageUrl: "tataace@3x.png"))
        
        vehicles.append(Vehicle(houseType: "BHK1",
                                vehicleType: "Super Ace (8 Ft)",
                                included: ["1 TV & TV Stand", "2 Chairs", "1 Washing Machine", "1 Fridge", "1 Single Cot", "10 Carton Box", "Almirah"], imageUrl: "super@3x.png"))
        
        vehicles.append(Vehicle(houseType: "BHK1_5",
                                vehicleType: "TATA 407 (10 Ft)",
                                included: ["1 TV", "4 Chairs", "1 Washing Machine", "1 Fridge", "1 Single Cot","1 Double Cot (non storage)","2 MATRESS (Rolling)", "15 Carton Box", "1 Iron Almirah", "1 Centre Table", "1 Sofa 3 (except recliner)", "Water Purifier"], imageUrl: "bolero@3x.png"))
        
        vehicles.append(Vehicle(houseType: "BHK2",
                                vehicleType: "CANTER (14 Ft)",
                                included: ["1 Sofa (3+2)", "1 Centre Table", "1 Iron Almirah/2 door wardrobe", "1 TV", "6 Chairs", "1 Washing Machine", "1 Fridge", "2 Double COT/1 doublebed+ 1 Single Cot+diwan", "15-20 Carton Box", "1 Dining Table/4 siter", "1 Shoe Rack", "3 MATRESS", "Water Purifier"], imageUrl: "canter_14@3x.png"))
        
        vehicles.append(Vehicle(houseType: "BHK2_5",
                                vehicleType: "CANTER (17 Ft)",
                                included: ["1 Sofa (3+2)", "1 Centre Table", "2 Iron Almirah", "1 TV", "8 Chairs", "1 Washing Machine", "1 Fridge", "1 Diwan Cot", "2 Double COT", "3 Double MATRESS", "1 Dining Table with chairs", "1 Shoe Rack", "30 Carton box", "Study Table", "Water Purifier"], imageUrl: "canter_17@3x.png"))
        
        vehicles.append(Vehicle( houseType: "BHK3",
                                 vehicleType: "CANTER (19ft)",
                                 included: ["1 Sofa (3+2+1)", "2 Centre Table", "3 Iron Almirah/ 3 door wardrobe(dismantled)+ Almirah", "1 TV", "8 Chairs", "1 Washing Machine", "1 Fridge", "1 Single Cot", "2 Double COT", "3 Double MATRESS", "1 Dining Table", "1 Shoe Rack", "35 Carton box", "Study Table", "Water Purifier"], imageUrl: "canter_19@3x.png"))
        return vehicles
    }

    @objc func setRandomHouse() {
        selectedHouseType = randomHouseSelect
        let indexPath = IndexPath(row: 0, section: 0)
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }
}


// MARK: - UITableViewDataSource
extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ApplianceTableViewCell", for: indexPath) as! ApplianceTableViewCell
        if let houseTypes = houseTypesToShow[selectedHouseType] {
            let houseType = houseTypes[indexPath.row]
            if let vehicle = vehicles.first(where: { (vehicle) -> Bool in
                vehicle.houseType == houseType
            }) {
                cell.configureForVehicle(vehicle, selectedHouseType: selectedHouseType)
            }
        }
        return cell
    }
}

//MARK: UITableViewDelegate
extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {}
}


struct Vehicle {
    var houseType: String
    var vehicleType: String
    var included: [String]
    var imageUrl: String
}
