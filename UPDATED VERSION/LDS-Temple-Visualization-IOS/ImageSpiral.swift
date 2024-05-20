//
//  ImageSpiral.swift
//  LDS-Temple-Visualization-IOS
//
//  Created by Litian Zhang on 6/29/20.
//  Copyright © 2020 Litian Zhang. All rights reserved.
//

import SwiftUI

// this is a ViewModel file



class ImageSpiral: ObservableObject {
    
//    static var centerX: CGFloat = 100
//    static var centerY: CGFloat = 100
//    static var screenWidth: CGFloat = 100
//    static var screenHeight: CGFloat = 100
 
    
    // theta is modified acoording to slider progress
    // then it is used to modify spiral model attributes
    static var theta: CGFloat = 5300

    static var startYearTest: String = ""
    static var endYearTest: String = ""
    
    static var templeYears: Array<String> = Array<String>()
    static var templeYearsThetaFriends: Array<CGFloat> = [245, 300, 325, 340, 380, 420, 450, 490, 520, 540, 570, 610, 680, 715, 750, 780, 810, 850, 890, 1070, 1290, 1430, 1520, 1540, 1575, 1630, 1660, 1700, 1710, 1755, 1850, 1890, 2315, 3330, 3540, 3720, 3800, 3850, 3950, 4030, 4110, 4200, 4300, 4400, 4520, 4540, 4650, 4785, 4935, 5100, 5110, 5320, 5330, 5800, 6990]
    
    // ["1836", "1846", "1877", "1884", "1888", "1893", "1919", "1923", "1927", "1945", "1955", "1956", "1958", "1964", "1972", "1974", "1978", "1980", "1981", "1983", "1984", "1985", "1986", "1987", "1989", "1990", "1993", "1994", "1995", "1996", "1997", "1998", "1999", "2000", "2001", "2002", "2003", "2004", "2005", "2006", "2008", "2009", "2010", "2011", "2012", "2013", "2014", "2015", "2016", "2017", "2018", "2019", "2020"] 
    
    static let templeNames: Array<String> = readTempleNamesFromFile()
    static let templeNamesAndYears: Array<Array<String>> = readTempleNameYearFromFile()
    
    // we make each one unique, so that we can loop through them with ForEach
    struct Info: Identifiable {
        var content: String
        var id: Int
    }
    
//    init(centerX: CGFloat, centerY: CGFloat, screenWidth: CGFloat, screenHeight: CGFloat) {
//        ImageSpiral.centerX = centerX
//        ImageSpiral.centerY = centerY
//        ImageSpiral.screenWidth = screenWidth
//        ImageSpiral.screenHeight = screenHeight
//    }
//
    
    // we want to keep this model private, so that only this ViewModel can access to this model. (door closed)
    // we put set here, so that only this ViewModel can modify this model, but others can see it. (glass door)
    // private(set) var spiralModel: Spiral<String>
    
    // we can also close the door and use a function to access the model
    @Published private var spiralModel: Spiral<Image> = ImageSpiral.createSpiral()
    
    // we will initialize with a function, createSpiral()
    // static means we can call this function on class, fot instace, we use this to initialze the model
    static func createSpiral() -> Spiral<Image> {
        
        // this is all coordinates
        let coordinatesAndSizes: Array<Array<CGFloat>> = getCoordinatesAndSizes(centerX: centerX, centerY: centerY, mode: "default")
        
        // this is what temples are on screen
        let onScreenTemplesString: Array<Array<String>> = getOnScreenTemples(theta: theta, coordinatesLength: CGFloat(coordinatesAndSizes.count))
        
        // this is what location should on screen temples reside
        // each element here is the index of each temple's location in all coordinates
        let onScreenTemplesPositions: Array<CGFloat> = getOnScreenTemplesPositions(theta: theta, coordinatesLength: CGFloat(coordinatesAndSizes.count))
        
        // finally we passing the needed parameters to create out spiral model
//        return Spiral<String>(numberOfTemples: onScreenTemples.count, coordinatesAndSizesP: coordinatesAndSizes, onScreenTemplesPositionsP: onScreenTemplesPositions) { index in
//        return onScreenTemples[index]
            
//        return Spiral<Image>(onScreenTemplesString: onScreenTemplesString, coordinatesAndSizesP: coordinatesAndSizes, onScreenTemplesPositionsP: onScreenTemplesPositions, centerX: centerX, centerY: centerY, screenWidth: screenWidth)
        return Spiral<Image>(onScreenTemplesString: onScreenTemplesString, coordinatesAndSizesP: coordinatesAndSizes, onScreenTemplesPositionsP: onScreenTemplesPositions)
        
    }

    // MARK: - Access to the Model
 
    var onScreenTemples: Array<Spiral<Image>.Temple> {
        return spiralModel.onScreenTemples
    }
    
    var mode: String {
        return spiralModel.mode
    }
    
    // MARK: - Intent(s)
    // this is where user intents come in
    func choose(temple: Spiral<Image>.Temple) {
        spiralModel.choose(temple: temple)
    }
    
    func dragSingleTemple(id: Int, xChange: CGFloat, yChange: CGFloat, lastX: CGFloat, lastY: CGFloat) {
            spiralModel.dragSingleTemple(id: id, xChange: xChange, yChange: yChange, lastX: lastX, lastY: lastY)
    }
    
    func setTemple(id: Int, newX: CGFloat, newY: CGFloat, newSize: CGFloat) {
        spiralModel.setTemple(id: id, newX: newX, newY: newY, newSize: newSize)
    }
    
    func changeATemple(id: Int) {
        spiralModel.changeATemple(id: id)
    }
    func thisTempleIsUsedForDraging(id: Int, name: String) {
        spiralModel.thisTempleIsUsedForDraging(id: id, name: name)
    }
    
    func changeMode(newMode: String) {
        spiralModel.changeMode(newMode: newMode)
    }
    
    func getNewTheta(newTheta: CGFloat) {
        ImageSpiral.theta = newTheta
        //print("new theta is \(ImageSpiral.theta)")
    }
    
    // this function updateds on screen temples
    func updateOnScreenTemples(newTheta: CGFloat) {
        
//        let coordinatesAndSizes: Array<Array<CGFloat>> = ImageSpiral.getCoordinatesAndSizes(centerX: ImageSpiral.centerX, centerY: ImageSpiral.centerY, mode: spiralModel.mode)
        
        let coordinatesAndSizes: Array<Array<CGFloat>> = ImageSpiral.getCoordinatesAndSizes(centerX: centerX, centerY: centerY, mode: spiralModel.mode)
        
        
        let onScreenTemplesString: Array<Array<String>> = ImageSpiral.getOnScreenTemples(theta: ImageSpiral.theta, coordinatesLength: CGFloat(coordinatesAndSizes.count))
        let onScreenTemplesPositions: Array<CGFloat> = ImageSpiral.getOnScreenTemplesPositions(theta: ImageSpiral.theta, coordinatesLength: CGFloat(coordinatesAndSizes.count))
        
        spiralModel.updateOnScreenTemples(onScreenTemplesString: onScreenTemplesString, coordinatesAndSizesP: coordinatesAndSizes, onScreenTemplesPositionsP: onScreenTemplesPositions)
        
    }

    // calculation the whole spiral coordinates
    // we include all temples on screen, even though some of them are very small in the center
    // because if we don't animation will suspend after the numbers of temples on screen reach max
    static func getCoordinatesAndSizes(centerX: CGFloat, centerY: CGFloat, mode: String) -> Array<Array<CGFloat>>{
        
        
        // when animation, less coordinates, but more temples
        //var t: CGFloat = -120
        
        // when no animation, more coordinates, but less temples
        var t: CGFloat = -120
        
        
        var buildingCoordinatesAndSize: Array<Array<CGFloat>> = Array<Array<CGFloat>>()
        var x: CGFloat
        var y: CGFloat
        let initialR: CGFloat = screenWidth / 10
        var size: CGFloat
        var t2: CGFloat
        var x2: CGFloat
        var y2: CGFloat
        
        var xNew: CGFloat
        var yNew: CGFloat
        var angle: CGFloat
        
        var oneSpiralCoordinateAndSize: Array<CGFloat> = Array<CGFloat>()
        
        t = -18
        
        while t < 17.5
        {
            // spiral function：
            // x = p * cosA, y = p * sinA, where p = N * e^(B * cotC)
            // When C = PI/2, graph is a circle, when C = 0, graph is a straight line

            x = centerX + initialR * exp(t * CGFloat(1) / tan(CGFloat(47) * CGFloat.pi / CGFloat(100))) * cos(t)
            y = centerY + initialR * exp(t * CGFloat(1) / tan(CGFloat(47) * CGFloat.pi / CGFloat(100))) * sin(t)
            
            
            
            if mode == "spin" {
                angle = theta / 100
                xNew = (x - centerX) * cos(angle) - (y - centerY) * sin(angle) + centerX;
                yNew = (y - centerY) * cos(angle) + (x - centerX) * sin(angle) + centerY;
            } else if mode == "zoom" {
                angle = theta / 45
                xNew = (x - centerX) * cos(angle) - (y - centerY) * sin(angle) + centerX;
                yNew = (y - centerY) * cos(angle) + (x - centerX) * sin(angle) + centerY;
            } else if mode == "3D" {
                angle = theta / 500
                xNew = (x - centerX) * cos(angle) - (y - centerY) * sin(angle) + centerX;
                yNew = (y - centerY) * cos(angle) + (xNew - centerX) * sin(angle) + centerY;
            } else  {
                xNew = x
                yNew = y
                
            }
            
            // this is how we calculate sizes of each temple
            // by finding the distance betten two spiral lines while the angle difference is 2 * pi
            // got to multiply a constant to find the right size for that screen
            t2 = t - 2 * CGFloat.pi
            x2 = centerX + initialR * exp(t2 * CGFloat(1) / tan(CGFloat(47) * CGFloat.pi / CGFloat(100))) * cos(t)
            y2 = centerY + initialR * exp(t2 * CGFloat(1) / tan(CGFloat(47) * CGFloat.pi / CGFloat(100))) * sin(t)
            size = sqrt(pow((x2 - x), 2) + pow((y2 - y), 2)) * 1.3
            
            oneSpiralCoordinateAndSize.append(xNew)
            oneSpiralCoordinateAndSize.append(yNew)
            oneSpiralCoordinateAndSize.append(size)
            buildingCoordinatesAndSize.append(oneSpiralCoordinateAndSize)
            
            
            //print("oneSpiralCoordinateAndSize length is \(oneSpiralCoordinateAndSize.count)")
            
            oneSpiralCoordinateAndSize.removeAll()
            
            // when animation, less coordinates
            //t += 0.6
            
            // when no animation, more coordinates
            t += 0.02
            
            //print("X is \(x)")
            //print("Y is \(y)")
            
        }
        
        let topCoordinateInSpiralX = buildingCoordinatesAndSize[(buildingCoordinatesAndSize.count-1)][0];
        let topCoordinateInSpiralY = buildingCoordinatesAndSize[(buildingCoordinatesAndSize.count-1)][1];
        let topSizeInSpiral = buildingCoordinatesAndSize[(buildingCoordinatesAndSize.count-1)][2];
        var q = topCoordinateInSpiralX
        
        if mode == "spin" || mode == "3D" {
            let secondTopCoordinateInSpiralX: CGFloat = buildingCoordinatesAndSize[(buildingCoordinatesAndSize.count-2)][0];
            let secondTopCoordinateInSpiralY: CGFloat = buildingCoordinatesAndSize[(buildingCoordinatesAndSize.count-2)][1];
            let xDirection: CGFloat = topCoordinateInSpiralX - secondTopCoordinateInSpiralX;
            let yDirection: CGFloat = topCoordinateInSpiralY - secondTopCoordinateInSpiralY;
            
            while q < screenWidth * 3 {
                
                let step: CGFloat = CGFloat(q) //* 30;
                
                oneSpiralCoordinateAndSize.append(xDirection / abs(xDirection) * step + secondTopCoordinateInSpiralX);
                oneSpiralCoordinateAndSize.append(yDirection / abs(yDirection) * step + secondTopCoordinateInSpiralY);
                oneSpiralCoordinateAndSize.append(topSizeInSpiral)
                buildingCoordinatesAndSize.append(oneSpiralCoordinateAndSize)
                oneSpiralCoordinateAndSize.removeAll()
                
                q += 5
            }
            
            
        } else  {
            
            
            while q < screenWidth * 3 {
            
                oneSpiralCoordinateAndSize.append(q)
                oneSpiralCoordinateAndSize.append(topCoordinateInSpiralY)
                oneSpiralCoordinateAndSize.append(topSizeInSpiral)
                buildingCoordinatesAndSize.append(oneSpiralCoordinateAndSize)
        
                //print("oneSpiralCoordinateAndSize length is \(oneSpiralCoordinateAndSize.count)")

                oneSpiralCoordinateAndSize.removeAll()
        
                    q += 5
            }
            
        }

        //print("centerX is \(centerX)")
        //print("centerY is \(centerY)")
        //print("screenWidth is \(screenWidth)")
        //print("screenHeight is \(screenHeight)")
        
        //print("buildingCoordinates is \(buildingCoordinates)")
        //print("buildingCoordinatesAndSize length is \(buildingCoordinatesAndSize.count)")
        //print("buildingCoordinatesAndSize is \(buildingCoordinatesAndSize)")
        
        //buildingCoordinatesAndSizeLength = buildingCoordinatesAndSize.count
        
        return buildingCoordinatesAndSize
            .reversed()
        
    }
    
    static func getOnScreenTemples(theta: CGFloat, coordinatesLength: CGFloat) -> Array<Array<String>> {
        var collectingOnScreenTemples = Array<String>()
        var templePosition: CGFloat
        
        var collectingOnScreenTemplesNames = Array<String>()
        var collectingOnScreenTemplesYears = Array<String>()
        var collectingOnScreenTemplesLinks = Array<String>()
        
        //print(ImageSpiral.templeNamesAndYears[1])
        
        var gotStartYear: Bool = false
        // here is the key logic to determin what temples should be on screen
        for templeIndex in 0..<ImageSpiral.templeNames.count {
            
            templePosition = theta - 30*CGFloat(templeIndex)
            
            if templePosition >= 0 && templePosition < CGFloat(coordinatesLength) {
                collectingOnScreenTemples.append(ImageSpiral.templeNames[templeIndex])
                collectingOnScreenTemplesNames.append(ImageSpiral.templeNamesAndYears[0][templeIndex])
                collectingOnScreenTemplesYears.append(ImageSpiral.templeNamesAndYears[1][templeIndex])
                collectingOnScreenTemplesLinks.append(ImageSpiral.templeNamesAndYears[2][templeIndex])
                //print("name here -------\(ImageSpiral.templeNamesAndYears[0][templeIndex])")
                //print("year here +++\(ImageSpiral.templeNamesAndYears[1][templeIndex])")
                
                
                if gotStartYear == false {
                    startYearTest = ImageSpiral.templeNamesAndYears[1][templeIndex]
                    gotStartYear = true
                }
                endYearTest = ImageSpiral.templeNamesAndYears[1][templeIndex]
                
            
            }
            
            // this is kind of extra, we can just delete the < in last if,
            // but i still write it here so that its more understandable
            // if the center temples are out of all coordinates and size range, we still add it to on screen temple list
            // because if we do animation we need this
            if templePosition < 0 || templePosition >= CGFloat(coordinatesLength) {
                collectingOnScreenTemples.append("clear_image")
                collectingOnScreenTemplesNames.append("No Temple")
                collectingOnScreenTemplesYears.append("No Year")
                collectingOnScreenTemplesLinks.append("No link")
            }
            
            //print(templePosition)
            
        }
//        print("collectingOnScreenTemples length after should be \(collectingOnScreenTemples.count)")
//        print("collectingOnScreenTemples Names length after should be \(collectingOnScreenTemplesNames.count)")
//        print("collectingOnScreenTemples Years length after should be \(collectingOnScreenTemplesYears.count)")
//        print("collectingOnScreenTemples Links length after should be \(collectingOnScreenTemplesYears.count)")

     
        var collectingOnScreenTemplesNamesAndYears: Array<Array<String>> = Array<Array<String>>()
        collectingOnScreenTemplesNamesAndYears.append(collectingOnScreenTemples)
        collectingOnScreenTemplesNamesAndYears.append(collectingOnScreenTemplesNames)
        collectingOnScreenTemplesNamesAndYears.append(collectingOnScreenTemplesYears)
        collectingOnScreenTemplesNamesAndYears.append(collectingOnScreenTemplesLinks)
        
        //print(collectingOnScreenTemplesNamesAndYears)
        
        return collectingOnScreenTemplesNamesAndYears
    }
     

    // this function is very much like the last one
    static func getOnScreenTemplesPositions(theta: CGFloat, coordinatesLength: CGFloat) -> Array<CGFloat> {
        var collectingOnScreenTemplesPositions = Array<CGFloat>()
        var templePosition: CGFloat
        for templeIndex in 0..<ImageSpiral.templeNames.count {
            templePosition = theta - 30*CGFloat(templeIndex)
            if templePosition >= 0 && templePosition < CGFloat(coordinatesLength) {
                collectingOnScreenTemplesPositions.append(templePosition)
            }
            
//            if templeIndex == 0 {
//                print("first temple postion is \(templePosition)")
//            }
            
            if templePosition < 0 || templePosition >= CGFloat(coordinatesLength) {
                collectingOnScreenTemplesPositions.append(0)
            }
            
        }
         
        //print("collectingOnScreenTemplesPositions length should be \(collectingOnScreenTemplesPositions.count)")

        return collectingOnScreenTemplesPositions
     }
    
    static func readTempleNamesFromFile() -> Array<String> {
        
        //var templeNames: Array<String> = Array<String>()
        var allTempleNames: Array<String> = linesFromResourceForced(fileName: "templeFilesNames")
        
        //print(allTempleNames)
        
        allTempleNames.removeLast()
    
        print("allTempleFileNames length is \(allTempleNames.count)")
        
        return allTempleNames
    }
    
    static func linesFromResourceForced(fileName: String) -> [String] {

        let path = Bundle.main.path(forResource: fileName, ofType: "")!
        let content = try! String(contentsOfFile: path, encoding: String.Encoding.utf8)
        return content.components(separatedBy: "\n")
    }
    
    static func readTempleNameYearFromFile() -> Array<Array<String>> {
        var allTempleNamesYears: Array<String> = linesFromResourceForced(fileName: "templeNamesYears")
        allTempleNamesYears.removeLast()
        allTempleNamesYears.removeLast()
        // we do remove lastt twice, becasue there is shanghai temple in the file,
        // but we are not showing it becasue the church website does not have it yet
        
        var allTempleNames: Array<String> = Array<String>()
        var allTempleYears: Array<String> = Array<String>()
        var allTempleLinks: Array<String> = Array<String>()
        
        
        
        for i in 0..<allTempleNamesYears.count / 2 {
            allTempleNames.append(allTempleNamesYears[2 * i])
            allTempleYears.append(allTempleNamesYears[2 * i + 1])
            //allTempleLinks.append("https://www.google.com/")
        }
        
        // a collection of all temple years on screen
        // used for year picker
        templeYears = allTempleYears
        // remove all ere (future temples without dedication years)
        let ere = ["ere"]
        templeYears.removeAll(where: { ere.contains($0) })
        templeYears = templeYears.removingDuplicates()
        
//        var temp: Array<String> = ["temples under construction"]
//        templeYears.replaceSubrange(Range(uncheckedBounds: (templeYears.count - 2, templeYears.count - 1)), with: temp)
//
        
        
        allTempleLinks = readTempleLinksFromFile()
        
//        print("allTempleYear length is \(allTempleYears.count)")
//        print("allTempleNames length is \(allTempleNames.count)")
//        print("allTempleLinks length is \(allTempleLinks.count)")
        
        var allTempleNamesYearsCombine: Array<Array<String>> = Array<Array<String>>()
        allTempleNamesYearsCombine.append(allTempleNames)
        allTempleNamesYearsCombine.append(allTempleYears)
        allTempleNamesYearsCombine.append(allTempleLinks)
        
        //print("allTemple Info length is \(allTempleNamesYearsCombine.count)")
        
        return allTempleNamesYearsCombine
    }
    
    func readOneTempleInfoFromFile(fileName: String) -> Array<Info> {
    //func readOneTempleInfoFromFile(fileName: String) -> String {
        let oneTempleInfoNew: Array<String> = ImageSpiral.linesFromResourceForced(fileName: fileName)
        
        //print("reading this temple's info from file: \(fileName)")
        
        var oneTempleInfo: Array<Info> = Array<Info>()
        for index in 0..<oneTempleInfoNew.count {
            oneTempleInfo.append(Info(content: oneTempleInfoNew[index], id: index))
        }
    
        return oneTempleInfo
    }
    

    static func readTempleLinksFromFile() -> Array<String> {
        
        //var templeNames: Array<String> = Array<String>()
        var allTempleLinks: Array<String> = linesFromResourceForced(fileName: "templeLinks")
        allTempleLinks.removeLast()
        print("allTempleLinks length when read is \(allTempleLinks.count)")
        return allTempleLinks
    }
    
    
    
}

extension Array where Element: Hashable {
    func removingDuplicates() -> [Element] {
        var addedDict = [Element: Bool]()

        return filter {
            addedDict.updateValue(true, forKey: $0) == nil
        }
    }

    mutating func removeDuplicates() {
        self = self.removingDuplicates()
    }
}
