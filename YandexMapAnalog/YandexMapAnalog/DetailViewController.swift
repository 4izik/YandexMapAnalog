import UIKit

class DetailViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    var numberStation=0
    var station:[String]=[]
    var time:[String]=[]
    var line:[Int]=[]
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
      
    }
   


}
extension DetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numberStation
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell=tableView.dequeueReusableCell(withIdentifier: "ResultCell") as! ResultTableViewCell
        cell.nameStationLabel.text=station[indexPath.row]
        switch line[indexPath.row] {
        case 0...18:
            cell.stationView.backgroundColor=UIColor(red: 0.839, green: 0.031, blue: 0.231, alpha: 1)
        case 19...36:
            cell.stationView.backgroundColor=UIColor(red: 0, green: 0.470, blue: 0.788, alpha: 1)
        case 17...48:
            cell.stationView.backgroundColor=UIColor(red: 0, green: 0.603, blue: 0.286, alpha: 1)
        case 49...56:
            cell.stationView.backgroundColor=UIColor(red: 0.917, green: 0.443, blue: 0.145, alpha: 1)
        case 57...72:
            cell.stationView.backgroundColor=UIColor(red: 0.439, green: 0.152, blue: 0.521, alpha: 1)
        default:
            break
        }
        if  indexPath.row==numberStation-1 {
            cell.timeLabel.text=time[indexPath.row]
        }
        else {
            cell.timeLabel.text=time[indexPath.row]+" минуты"
        }
        cell.selectionStyle=UITableViewCell.SelectionStyle.none
        return cell
    }
    
    
}

