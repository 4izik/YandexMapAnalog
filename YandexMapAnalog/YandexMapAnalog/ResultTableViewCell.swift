import UIKit

class ResultTableViewCell: UITableViewCell {

    @IBOutlet weak var stationView: UIView!
    @IBOutlet weak var nameStationLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        stationView.layer.cornerRadius=7
        stationView.clipsToBounds=true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}

