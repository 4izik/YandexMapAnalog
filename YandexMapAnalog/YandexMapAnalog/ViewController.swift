import UIKit

class ViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var scrollView: UIScrollView!
    
    // создание графа
   let graph = AdjacencyList<Stations>()
    var stationVertex:[Vertex<Stations>]=[]
    
   
    var stationDispatch=false
    var stationArrival=false
    var stationArrivalTag=0
    var stationDispatchTag=0
    var time=0
    //создание нижней панели
    var resultView=DrawMap().drawResultView()
    var labelDispatch=DrawMap().drawDispatchLabel()
    var labelArrival=DrawMap().drawArrivalLabel()
    var cleanButton=DrawMap().drawCleanButton()
    var backgroundView=DrawMap().drawBackgroundView()
    var timeLabel=DrawMap().drawTimeLabel()
    var detailButton=DrawMap().drawDetailButton()
    
    //result
    var numberStation=0
    var stationResult:[String]=[]
    var timeResult:[String]=[]
    var lineResult:[Int]=[]
    override func viewDidLoad() {
            super.viewDidLoad()
        var lines:[Lines]=[]
        backgroundView.isHidden=true
        timeLabel.isHidden=true
        detailButton.isHidden=true
        //добавление нижней панели на экран
        cleanButton.addTarget(self, action: #selector(buttonCleanAction), for: .touchUpInside)
        detailButton.addTarget(self, action: #selector(buttonDetailAction), for: .touchUpInside)
        resultView.addSubview(labelDispatch)
        resultView.addSubview(labelArrival)
        resultView.addSubview(cleanButton)
        view.addSubview(resultView)
        view.addSubview(labelDispatch)
        view.addSubview(labelArrival)
        view.addSubview(cleanButton)
        view.addSubview(timeLabel)
        view.addSubview(detailButton)
        //constraint для resultview, чтобы при скролле не двигалась панель
        let topAnchor = resultView.topAnchor.constraint(equalTo: view.topAnchor, constant: UIScreen.main.bounds.height-150)
        let bottomAnchor = resultView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
        let leftAnchor = resultView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0)
        let rightAnchor = resultView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0)
        NSLayoutConstraint.activate([topAnchor, bottomAnchor, leftAnchor, rightAnchor])
        
        //настройка scroll при увеличении карты
        scrollView.contentSize=CGSize(width: 1500, height: 1500)
        scrollView.setContentOffset(CGPoint(x: UIScreen.main.bounds.width/2, y:UIScreen.main.bounds.height/2), animated: true)
        
        //загрузка данных из "station.json"
        lines=LineLoader().loadJson(filename: "station") ?? []
        scrollView.delegate=self
        
        //zoom
        let recognizer = UIPinchGestureRecognizer()
        recognizer.addTarget(self, action: #selector(handlePinch(recognizer:)))
        scrollView.addGestureRecognizer(recognizer)
    
        
            // добавление станций в граф по линиям метро
        for i in 0...lines.count-1 {
            for object in lines[i].stations {
                stationVertex.append(graph.createVertex(data: object))
            }
        }
    
        //добавление ребер с весом (время между станциями)
        for i in 0..<stationVertex.count-1
        {
            if i==18 || i==36 || i==48 || i==56 || i==71 { continue }
            else {
        graph.add(.undirected, from: stationVertex[i], to: stationVertex[i+1], weight: stationVertex[i+1].data.order)
                // рисуем линии между станциями
                scrollView.layer.addSublayer(DrawMap().drawWay(first: stationVertex[i].data, second: stationVertex[i+1].data, line: i))
               
            }
        }
        //рисуем станции-кнопки
        for i in 0..<stationVertex.count {
            let button=DrawMap().drawStation(station: stationVertex[i].data, line: i, numberVertex: i)
            button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
            scrollView.addSubview(button)
            //рисуем название станций
            let label=DrawMap().drawNameStation(station: stationVertex[i].data, number: i)
            scrollView.addSubview(label)
        }
    
        // создание ребер-переходов между ветками метро
        
        graph.add(.undirected, from: stationVertex[41], to: stationVertex[27], weight: 2) //Невский-Гостиный двор
        graph.add(.undirected, from: stationVertex[9], to: stationVertex[42], weight: 2) //Площадь Восстания-Маяковская
        graph.add(.undirected, from: stationVertex[43], to: stationVertex[52], weight: 2) //Площадь Ал.Нев.1 - Площадь Ал.Нев.2
        graph.add(.undirected, from: stationVertex[50], to: stationVertex[10], weight: 2) // Достоевская - Владимирская
        graph.add(.undirected, from: stationVertex[11], to: stationVertex[64], weight: 2) // Пушкинская - Звенигородская
        graph.add(.undirected, from: stationVertex[12], to: stationVertex[29], weight: 2) // Техн.инст.1 - Техн.инст.2
        graph.add(.undirected, from: stationVertex[63], to: stationVertex[49], weight: 2) // Садовая - Спасская
        graph.add(.undirected, from: stationVertex[63], to: stationVertex[28], weight: 2) // Садовая - Сенная
        graph.add(.undirected, from: stationVertex[49], to: stationVertex[28], weight: 2) //Спасская - Сенная
     
        scrollView.addSubview(backgroundView)
        
    }

func calculateTime() {
        
    backgroundView.isHidden=false
        UIView.animate(withDuration: 1.0, animations: {
            
            self.view.layoutIfNeeded()
        })
            if let edges=graph.dijkstra(from: stationVertex[stationDispatchTag], to: stationVertex[stationArrivalTag]) {
                  for edge in edges {
                    print("\(edge.source)->\(edge.destination)")
                    //рисуем путь
                    scrollView.layer.addSublayer(DrawMap().drawWay(first: edge.source.data, second: edge.destination.data, line: edge.source.index))
                    scrollView.addSubview(DrawMap().drawFinishStation(station: edge.source.data, line: edge.source.index))
                    time+=edge.weight!
                    numberStation+=1
                    stationResult.append(edge.source.data.name)
                    timeResult.append("\(edge.weight!)")
                    lineResult.append(edge.source.index)
                  }
                scrollView.addSubview(DrawMap().drawFinishStation(station: stationVertex[stationArrivalTag].data, line: stationArrivalTag))
                stationResult.append(stationVertex[stationArrivalTag].data.name)
                timeResult.append("")
                lineResult.append(stationArrivalTag)
                numberStation+=1
              }
        
    timeLabel.isHidden=false
    detailButton.isHidden=false
    timeLabel.text="Время в пути: \(time) минут"
    
}
    @objc func buttonAction(sender: UIButton!) {
        
        if stationDispatch {
            labelArrival.text=stationVertex[sender.tag].data.name
            labelArrival.font = UIFont.boldSystemFont(ofSize: labelArrival.font.pointSize)
            stationArrival=true
            stationArrivalTag=sender.tag
            calculateTime()
            }
         else
        {
            labelDispatch.text=stationVertex[sender.tag].data.name
            labelDispatch.font = UIFont.boldSystemFont(ofSize: labelDispatch.font.pointSize)
            stationDispatch=true
            stationDispatchTag=sender.tag
        }
        sender.transform=CGAffineTransform(scaleX: 1.5, y: 1.5)

    }

    //zoom
    @objc func handlePinch(recognizer:UIPinchGestureRecognizer) {
        if self.scrollView.transform.scale < 1 || self.scrollView.transform.scale > 5 {
                    return
                }
        if let view = self.scrollView{
                var newTransform = view.transform.scaledBy(x: recognizer.scale, y: recognizer.scale)
                if newTransform.scale>5 { newTransform=view.transform.scaledBy(x: 5, y: 5)}
                else {
                    view.transform = newTransform.scale < 1 ? .identity : newTransform
                    
                }
                    recognizer.scale = 1
                
            }
    }
    @objc func buttonCleanAction(sender: UIButton!) {
        for view in self.scrollView.subviews {
            view.removeFromSuperview()
        }
        numberStation=0
        stationResult=[]
        timeResult=[]
        lineResult=[]
        stationDispatch=false
        stationArrival=false
        stationArrivalTag=0
        stationDispatchTag=0
        time=0
        labelDispatch.text="Станция отправления"
        labelArrival.text="Станция прибытия"
        labelDispatch.font=UIFont.systemFont(ofSize: labelDispatch.font.pointSize)
        labelArrival.font=UIFont.systemFont(ofSize: labelDispatch.font.pointSize)
        timeLabel.isHidden=true
        detailButton.isHidden=true
        for i in 0..<stationVertex.count-1
        {
            if i==18 || i==36 || i==48 || i==56 || i==71 { continue }
            else {
                scrollView.layer.addSublayer(DrawMap().drawWay(first: stationVertex[i].data, second: stationVertex[i+1].data, line: i))
            }
        }
        for i in 0..<stationVertex.count {
            let button=DrawMap().drawStation(station: stationVertex[i].data, line: i, numberVertex: i)
            button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
            scrollView.addSubview(button)
            //рисуем название станций
            let label=DrawMap().drawNameStation(station: stationVertex[i].data, number: i)
            scrollView.addSubview(label)
        }
        scrollView.addSubview(backgroundView)
        backgroundView.isHidden=true
    }
    @objc func buttonDetailAction(sender: UIButton!) {
        performSegue(withIdentifier: "ShowDetailController", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       if let vc=segue.destination as? DetailViewController {
        vc.numberStation=numberStation
        vc.station=stationResult
        vc.time=timeResult
        vc.line=lineResult
        }
    }
}
extension CGAffineTransform {
    var scale: Double {
        return sqrt(Double(a * a + c * c))
    }

}

