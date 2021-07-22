import Foundation
import UIKit
class DrawMap {
    var changeX=UIScreen.main.bounds.width/2
    var chahgey=UIScreen.main.bounds.height/2
    func drawStation (station:Stations, line: Int, numberVertex:Int)-> UIButton {
        let buttonStation=UIButton(frame: CGRect(x: station.lat+Int(changeX), y: station.lng+Int(chahgey), width: 10, height: 10))
        switch line {
        case 0...18:
            buttonStation.backgroundColor=UIColor(red: 0.839, green: 0.031, blue: 0.231, alpha: 1)
        case 19...36:
            buttonStation.backgroundColor=UIColor(red: 0, green: 0.470, blue: 0.788, alpha: 1)
        case 17...48:
            buttonStation.backgroundColor=UIColor(red: 0, green: 0.603, blue: 0.286, alpha: 1)
        case 49...56:
            buttonStation.backgroundColor=UIColor(red: 0.917, green: 0.443, blue: 0.145, alpha: 1)
        case 57...72:
            buttonStation.backgroundColor=UIColor(red: 0.439, green: 0.152, blue: 0.521, alpha: 1)
        default:
            break
        }
        buttonStation.titleLabel?.text=station.name
        buttonStation.layer.cornerRadius=5
        buttonStation.clipsToBounds=true
        buttonStation.tag=numberVertex
        return buttonStation
       
    }
   
    func drawWay (first:Stations, second:Stations, line:Int)->CAShapeLayer{
        let path=UIBezierPath()
        path.move(to: CGPoint(x: first.lat+5+Int(changeX), y: first.lng+5+Int(chahgey)))
        path.addLine(to: CGPoint(x: second.lat+5+Int(changeX), y: second.lng+5+Int(chahgey)))
        path.close()
        let shapeLayer = CAShapeLayer()
            shapeLayer.path = path.cgPath
        var linecolor=UIColor.black
        switch line {
        case 0...18:
            linecolor=UIColor(red: 0.839, green: 0.031, blue: 0.231, alpha: 1)
        case 19...36:
            linecolor=UIColor(red: 0, green: 0.470, blue: 0.788, alpha: 1)
        case 17...48:
            linecolor=UIColor(red: 0, green: 0.603, blue: 0.286, alpha: 1)
        case 49...56:
            linecolor=UIColor(red: 0.917, green: 0.443, blue: 0.145, alpha: 1)
        case 57...72:
            linecolor=UIColor(red: 0.439, green: 0.152, blue: 0.521, alpha: 1)
        default:
            break
        }
        shapeLayer.strokeColor = linecolor.cgColor
            shapeLayer.lineWidth = 4.0
        return shapeLayer
    }
    func drawNameStation (station:Stations, number:Int)->UILabel {
        let labelStation=UILabel()
        switch number {
        case 9, 27, 39,43, 49,50:
            labelStation.frame=CGRect(x: station.lat+10+Int(changeX), y: station.lng-10+Int(chahgey), width: 70, height: 20)
        case 28,40,64:
            labelStation.frame=CGRect(x: station.lat+10+Int(changeX), y: station.lng+5+Int(chahgey), width: 60, height: 20)
        case 52:
            labelStation.frame=CGRect(x: station.lat+10+Int(changeX), y: station.lng-23+Int(chahgey), width: 100, height: 20)
        case 62:
            labelStation.frame=CGRect(x: station.lat-50+Int(changeX), y: station.lng+Int(chahgey), width: 60, height: 20)
        case 63:
            labelStation.frame=CGRect(x: station.lat-30+Int(changeX), y: station.lng+Int(chahgey), width: 60, height: 20)
        default:
            labelStation.frame=CGRect(x: station.lat+10+Int(changeX), y: station.lng+Int(chahgey), width: 60, height: 20)
        }
       
        labelStation.font=labelStation.font.withSize(6)
        labelStation.numberOfLines=0
        labelStation.text=station.name
        return labelStation
    }

    func drawFinishStation(station:Stations, line: Int)-> UIButton {
        let buttonStation=UIButton(frame: CGRect(x: station.lat+Int(changeX), y: station.lng+Int(chahgey), width: 10, height: 10))
        switch line {
        case 0...18:
            buttonStation.backgroundColor=UIColor(red: 0.839, green: 0.031, blue: 0.231, alpha: 1)
        case 19...36:
            buttonStation.backgroundColor=UIColor(red: 0, green: 0.470, blue: 0.788, alpha: 1)
        case 17...48:
            buttonStation.backgroundColor=UIColor(red: 0, green: 0.603, blue: 0.286, alpha: 1)
        case 49...56:
            buttonStation.backgroundColor=UIColor(red: 0.917, green: 0.443, blue: 0.145, alpha: 1)
        case 57...72:
            buttonStation.backgroundColor=UIColor(red: 0.439, green: 0.152, blue: 0.521, alpha: 1)
        default:
            break
        }
        buttonStation.titleLabel?.text=station.name
        buttonStation.layer.cornerRadius=5
        buttonStation.clipsToBounds=true
        return buttonStation
       
    }
    
    func drawBackgroundView() -> UIView {
        let backgroundView=UIView(frame: CGRect(x: 0, y: 0, width: 1500, height: 1500))
        backgroundView.backgroundColor=UIColor.black.withAlphaComponent(0.75)
        return backgroundView
    }
    func drawResultView() -> UIView {
        let view=UIView(frame: CGRect(x:0,y:UIScreen.main.bounds.height-150, width: UIScreen.main.bounds.width, height: 150))
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints=false
        view.roundCorners([.topLeft, .topRight], radius: 22)
        return view
    }
    func drawDispatchLabel() -> UILabel {
        let labelDispatch=UILabel(frame: CGRect(x: 20, y: UIScreen.main.bounds.height-120, width: 150, height: 30))
        labelDispatch.font=labelDispatch.font.withSize(12)
        labelDispatch.textAlignment = .center
        labelDispatch.numberOfLines=0
        labelDispatch.text="Станция отправления"
        return labelDispatch
    }
    func drawArrivalLabel() -> UILabel {
        let labelArrival=UILabel(frame: CGRect(x: changeX, y: UIScreen.main.bounds.height-120, width: 150, height: 30))
        labelArrival.font=labelArrival.font.withSize(12)
        labelArrival.textAlignment = .center
        labelArrival.numberOfLines=0
        labelArrival.text="Станция прибытия"
        return labelArrival
    }
    func drawTimeLabel() -> UILabel {
        let label=UILabel(frame: CGRect(x: UIScreen.main.bounds.width/2-75, y: UIScreen.main.bounds.height-80, width: 150, height: 20))
        label.font=label.font.withSize(13)
        return label
    }
    func drawCleanButton() -> UIButton {
        let button=UIButton(type: UIButton.ButtonType.close)
        button.frame=CGRect(x: UIScreen.main.bounds.width-40, y: UIScreen.main.bounds.height-120, width: 20, height: 20)
        button.layer.cornerRadius=10
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.borderWidth=1.0
        button.clipsToBounds=true
        return button
    }
    func drawDetailButton() -> UIButton {
        let button=UIButton(frame: CGRect(x: UIScreen.main.bounds.width/2-75, y: UIScreen.main.bounds.height-50, width: 150, height: 30))
        button.setTitle("Детали маршрута", for: .normal)
        button.titleLabel!.font = .systemFont(ofSize: 12)
        button.setTitleColor(UIColor.blue, for: .normal)
        button.layer.cornerRadius=8
        button.layer.borderWidth=2.0
        button.layer.borderColor=UIColor.black.cgColor
        button.clipsToBounds=true
        return button
    }
}
extension UIView {
  func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
      let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners,
                              cornerRadii: CGSize(width: radius, height: radius))
      let mask = CAShapeLayer()
      mask.path = path.cgPath
      layer.mask = mask
  }
}

