//
//  GraphCreator.swift
//  Metro
//
//  Created by Egor Malyshev on 04.11.2020.
//

import Foundation

class GraphCreator {
    
    func create() -> Graph {
        var stations: [Station] = []
        stations.append(contentsOf: createFirstLine())
        stations.append(contentsOf: createSecondLine())
        stations.append(contentsOf: createThirdLine())
        stationWithTag(13, stations: stations)?.addEdge(destination: stationWithTag(30, stations: stations)!, time: 1)
        stationWithTag(28, stations: stations)?.addEdge(destination: stationWithTag(42, stations: stations)!, time: 1)
        stationWithTag(10, stations: stations)?.addEdge(destination: stationWithTag(43, stations: stations)!, time: 1)
        return Graph(stations: stations)
    }
    
    func stationWithTag(_ tag: Int, stations: [Station]) -> Station? {
        var foundedStation: Station? = nil
        for s in stations{
            if s.tag == tag { foundedStation = s }
        }
        return foundedStation
    }
    
    func createFirstLine() -> [Station] {
        var stations: [Station] = []
        let devyatkino = Station(name: "Девяткино", tag: 1)
        let grazhdanskiyProspekt = Station(name: "Гражданский проспект", tag: 2)
        let akademicheskaya = Station(name: "Академическая", tag: 3)
        let politehnicheskaya = Station(name: "Политехническая", tag: 4)
        let ploshchadMuzhestva = Station(name: "Площадь Мужества", tag: 5)
        let lesnaya = Station(name: "Лесная", tag: 6)
        let vyborgskaya = Station(name: "Выборгская", tag: 7)
        let ploshchadLenina = Station(name: "Площадь Ленина", tag: 8)
        let chernyshevskaya = Station(name: "Чернышевская", tag: 9)
        let ploshchadVosstaniya = Station(name: "Площадь Восстания", tag: 10)
        let vladimirskaya = Station(name: "Владимирская", tag: 11)
        let pushkinskaya = Station(name: "Пушкинская", tag: 12)
        let tehnoInstitut1 = Station(name: "Технологический институт-1", tag: 13)
        let baltiyskaya = Station(name: "Балтийская", tag: 14)
        let narvskaya = Station(name: "Нарвская", tag: 15)
        let kirovskiyZavod = Station(name: "Кировский завод", tag: 16)
        let avtovo = Station(name: "Автово", tag: 17)
        let leninskiy = Station(name: "Ленинский проспект", tag: 18)
        let veteranov = Station(name: "Проспект Ветеранов", tag: 19)
        grazhdanskiyProspekt.addEdge(destination: devyatkino, time: 4)
        grazhdanskiyProspekt.addEdge(destination: akademicheskaya, time: 2)
        politehnicheskaya.addEdge(destination: akademicheskaya, time: 3)
        politehnicheskaya.addEdge(destination: ploshchadMuzhestva, time: 2)
        lesnaya.addEdge(destination: ploshchadMuzhestva, time: 3)
        lesnaya.addEdge(destination: vyborgskaya, time: 4)
        ploshchadLenina.addEdge(destination: vyborgskaya, time: 3)
        ploshchadLenina.addEdge(destination: chernyshevskaya, time: 3)
        ploshchadVosstaniya.addEdge(destination: chernyshevskaya, time: 4)
        ploshchadVosstaniya.addEdge(destination: vladimirskaya, time: 3)
        pushkinskaya.addEdge(destination: vladimirskaya, time: 3)
        pushkinskaya.addEdge(destination: tehnoInstitut1, time: 2)
        baltiyskaya.addEdge(destination: tehnoInstitut1, time: 3)
        baltiyskaya.addEdge(destination: narvskaya, time: 2)
        kirovskiyZavod.addEdge(destination: narvskaya, time: 3)
        kirovskiyZavod.addEdge(destination: avtovo, time: 4)
        leninskiy.addEdge(destination: avtovo, time: 3)
        leninskiy.addEdge(destination: veteranov, time: 2)
        stations.append(devyatkino)
        stations.append(grazhdanskiyProspekt)
        stations.append(akademicheskaya)
        stations.append(politehnicheskaya)
        stations.append(ploshchadMuzhestva)
        stations.append(lesnaya)
        stations.append(vyborgskaya)
        stations.append(ploshchadLenina)
        stations.append(chernyshevskaya)
        stations.append(ploshchadVosstaniya)
        stations.append(vladimirskaya)
        stations.append(pushkinskaya)
        stations.append(tehnoInstitut1)
        stations.append(baltiyskaya)
        stations.append(narvskaya)
        stations.append(kirovskiyZavod)
        stations.append(avtovo)
        stations.append(leninskiy)
        stations.append(veteranov)
        return stations
    }
    
    func createSecondLine() -> [Station] {
        var stations: [Station] = []
        let parnas = Station(name: "Парнас", tag: 20)
        let prosveshcheniya = Station(name: "Проспект Просвещения", tag: 21)
        let ozerki = Station(name: "Озерки", tag: 22)
        let udelnaya = Station(name: "Удельная", tag: 23)
        let pionerskaya = Station(name: "Пионерская", tag: 24)
        let chernayaRechka = Station(name: "Черная речка", tag: 25)
        let petrogradskaya = Station(name: "Петроградская", tag: 26)
        let gorkovskaya = Station(name: "Горьковская", tag: 27)
        let nevskiy = Station(name: "Невский проспект", tag: 28)
        let sennaya = Station(name: "Сенная площадь", tag: 29)
        let tehnoInstitut2 = Station(name: "Технологический институт-2", tag: 30)
        let frunzenskaya = Station(name: "Фрунзенская", tag: 31)
        let vorota = Station(name: "Московские ворота", tag: 32)
        let elektrosila = Station(name: "Электросила", tag: 33)
        let parkPobedy = Station(name: "Парк Победы", tag: 34)
        let moskovskaya = Station(name: "Московская", tag: 35)
        let zvezdnaya = Station(name: "Звездная", tag: 36)
        let kupchino = Station(name: "Купчино", tag: 37)
        prosveshcheniya.addEdge(destination: parnas, time: 3)
        prosveshcheniya.addEdge(destination: ozerki, time: 4)
        udelnaya.addEdge(destination: ozerki, time: 3)
        udelnaya.addEdge(destination: pionerskaya, time: 2)
        chernayaRechka.addEdge(destination: pionerskaya, time: 4)
        chernayaRechka.addEdge(destination: petrogradskaya, time: 3)
        gorkovskaya.addEdge(destination: petrogradskaya, time: 3)
        gorkovskaya.addEdge(destination: nevskiy, time: 4)
        sennaya.addEdge(destination: nevskiy, time: 2)
        sennaya.addEdge(destination: tehnoInstitut2, time: 3)
        frunzenskaya.addEdge(destination: tehnoInstitut2, time: 3)
        frunzenskaya.addEdge(destination: vorota, time: 3)
        elektrosila.addEdge(destination: vorota, time: 2)
        elektrosila.addEdge(destination: parkPobedy, time: 3)
        moskovskaya.addEdge(destination: parkPobedy, time: 3)
        moskovskaya.addEdge(destination: zvezdnaya, time: 4)
        kupchino.addEdge(destination: zvezdnaya, time: 3)
        stations.append(parnas)
        stations.append(prosveshcheniya)
        stations.append(ozerki)
        stations.append(udelnaya)
        stations.append(pionerskaya)
        stations.append(chernayaRechka)
        stations.append(petrogradskaya)
        stations.append(gorkovskaya)
        stations.append(nevskiy)
        stations.append(sennaya)
        stations.append(tehnoInstitut2)
        stations.append(frunzenskaya)
        stations.append(vorota)
        stations.append(elektrosila)
        stations.append(parkPobedy)
        stations.append(moskovskaya)
        stations.append(zvezdnaya)
        stations.append(kupchino)
        return stations
    }
        
    func createThirdLine() -> [Station] {
        var stations: [Station] = []
        let begovaya = Station(name: "Беговая", tag: 38)
        let novokresovskaya = Station(name: "Новокрестовская", tag: 39)
        let primorskaya = Station(name: "Приморская", tag: 40)
        let vasileostrovskaya = Station(name: "Василеостровская", tag: 41)
        let gostiniyDvor = Station(name: "Гостиный двор", tag: 42)
        let mayakovskaya = Station(name: "Маяковская", tag: 43)
        let aleksandraNevskogo1 = Station(name: "Площадь Александра Невского-1", tag: 44)
        let elisarovskaya = Station(name: "Елизаровская", tag: 45)
        let lomonosovskaya = Station(name: "Ломоносовская", tag: 46)
        let proletarskaya = Station(name: "Пролетарская", tag: 47)
        let obuhovo = Station(name: "Обухово", tag: 48)
        let rybatskoe = Station(name: "Рыбацкое", tag: 49)
        novokresovskaya.addEdge(destination: begovaya, time: 4)
        novokresovskaya.addEdge(destination: primorskaya, time: 4)
        vasileostrovskaya.addEdge(destination: primorskaya, time: 3)
        vasileostrovskaya.addEdge(destination: gostiniyDvor, time: 4)
        mayakovskaya.addEdge(destination: gostiniyDvor, time: 2)
        mayakovskaya.addEdge(destination: aleksandraNevskogo1, time: 3)
        elisarovskaya.addEdge(destination: aleksandraNevskogo1, time: 4)
        elisarovskaya.addEdge(destination: lomonosovskaya, time: 3)
        proletarskaya.addEdge(destination: lomonosovskaya, time: 3)
        proletarskaya.addEdge(destination: obuhovo, time: 4)
        rybatskoe.addEdge(destination: obuhovo, time: 4)
        stations.append(begovaya)
        stations.append(novokresovskaya)
        stations.append(primorskaya)
        stations.append(vasileostrovskaya)
        stations.append(gostiniyDvor)
        stations.append(mayakovskaya)
        stations.append(aleksandraNevskogo1)
        stations.append(elisarovskaya)
        stations.append(lomonosovskaya)
        stations.append(proletarskaya)
        stations.append(obuhovo)
        stations.append(rybatskoe)
        return stations
    }
}
