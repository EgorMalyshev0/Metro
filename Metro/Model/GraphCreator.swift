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
        stations.append(contentsOf: createFourthLine())
        stations.append(contentsOf: createFifthLine())
        stationWithTag(13, stations: stations)?.addTransition(destination: stationWithTag(30, stations: stations)!, time: 1)
        stationWithTag(28, stations: stations)?.addTransition(destination: stationWithTag(42, stations: stations)!, time: 1)
        stationWithTag(10, stations: stations)?.addTransition(destination: stationWithTag(43, stations: stations)!, time: 1)
        stationWithTag(50, stations: stations)?.addTransition(destination: stationWithTag(29, stations: stations)!, time: 1)
        stationWithTag(50, stations: stations)?.addTransition(destination: stationWithTag(64, stations: stations)!, time: 1)
        stationWithTag(29, stations: stations)?.addTransition(destination: stationWithTag(64, stations: stations)!, time: 1)
        stationWithTag(11, stations: stations)?.addTransition(destination: stationWithTag(51, stations: stations)!, time: 1)
        stationWithTag(44, stations: stations)?.addTransition(destination: stationWithTag(53, stations: stations)!, time: 1)
        stationWithTag(12, stations: stations)?.addTransition(destination: stationWithTag(65, stations: stations)!, time: 1)
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
        let devyatkino = Station(name: "Девяткино", tag: 1, line: 1)
        let grazhdanskiyProspekt = Station(name: "Гражданский проспект", tag: 2, line: 1)
        let akademicheskaya = Station(name: "Академическая", tag: 3, line: 1)
        let politehnicheskaya = Station(name: "Политехническая", tag: 4, line: 1)
        let ploshchadMuzhestva = Station(name: "Площадь Мужества", tag: 5, line: 1)
        let lesnaya = Station(name: "Лесная", tag: 6, line: 1)
        let vyborgskaya = Station(name: "Выборгская", tag: 7, line: 1)
        let ploshchadLenina = Station(name: "Площадь Ленина", tag: 8, line: 1)
        let chernyshevskaya = Station(name: "Чернышевская", tag: 9, line: 1)
        let ploshchadVosstaniya = Station(name: "Площадь Восстания", tag: 10, line: 1)
        let vladimirskaya = Station(name: "Владимирская", tag: 11, line: 1)
        let pushkinskaya = Station(name: "Пушкинская", tag: 12, line: 1)
        let tehnoInstitut1 = Station(name: "Технологический институт-1", tag: 13, line: 1)
        let baltiyskaya = Station(name: "Балтийская", tag: 14, line: 1)
        let narvskaya = Station(name: "Нарвская", tag: 15, line: 1)
        let kirovskiyZavod = Station(name: "Кировский завод", tag: 16, line: 1)
        let avtovo = Station(name: "Автово", tag: 17, line: 1)
        let leninskiy = Station(name: "Ленинский проспект", tag: 18, line: 1)
        let veteranov = Station(name: "Проспект Ветеранов", tag: 19, line: 1)
        grazhdanskiyProspekt.addEdge(destination: devyatkino, time: 4, tag: 101)
        grazhdanskiyProspekt.addEdge(destination: akademicheskaya, time: 2, tag: 102)
        politehnicheskaya.addEdge(destination: akademicheskaya, time: 3, tag: 103)
        politehnicheskaya.addEdge(destination: ploshchadMuzhestva, time: 2, tag: 104)
        lesnaya.addEdge(destination: ploshchadMuzhestva, time: 3, tag: 105)
        lesnaya.addEdge(destination: vyborgskaya, time: 4, tag: 106)
        ploshchadLenina.addEdge(destination: vyborgskaya, time: 3, tag: 107)
        ploshchadLenina.addEdge(destination: chernyshevskaya, time: 3, tag: 108)
        ploshchadVosstaniya.addEdge(destination: chernyshevskaya, time: 4, tag: 109)
        ploshchadVosstaniya.addEdge(destination: vladimirskaya, time: 3, tag: 110)
        pushkinskaya.addEdge(destination: vladimirskaya, time: 3, tag: 111)
        pushkinskaya.addEdge(destination: tehnoInstitut1, time: 2, tag: 112)
        baltiyskaya.addEdge(destination: tehnoInstitut1, time: 3, tag: 113)
        baltiyskaya.addEdge(destination: narvskaya, time: 2, tag: 114)
        kirovskiyZavod.addEdge(destination: narvskaya, time: 3, tag: 115)
        kirovskiyZavod.addEdge(destination: avtovo, time: 4, tag: 116)
        leninskiy.addEdge(destination: avtovo, time: 3, tag: 117)
        leninskiy.addEdge(destination: veteranov, time: 2, tag: 118)
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
        let parnas = Station(name: "Парнас", tag: 20, line: 2)
        let prosveshcheniya = Station(name: "Проспект Просвещения", tag: 21, line: 2)
        let ozerki = Station(name: "Озерки", tag: 22, line: 2)
        let udelnaya = Station(name: "Удельная", tag: 23, line: 2)
        let pionerskaya = Station(name: "Пионерская", tag: 24, line: 2)
        let chernayaRechka = Station(name: "Черная речка", tag: 25, line: 2)
        let petrogradskaya = Station(name: "Петроградская", tag: 26, line: 2)
        let gorkovskaya = Station(name: "Горьковская", tag: 27, line: 2)
        let nevskiy = Station(name: "Невский проспект", tag: 28, line: 2)
        let sennaya = Station(name: "Сенная площадь", tag: 29, line: 2)
        let tehnoInstitut2 = Station(name: "Технологический институт-2", tag: 30, line: 2)
        let frunzenskaya = Station(name: "Фрунзенская", tag: 31, line: 2)
        let vorota = Station(name: "Московские ворота", tag: 32, line: 2)
        let elektrosila = Station(name: "Электросила", tag: 33, line: 2)
        let parkPobedy = Station(name: "Парк Победы", tag: 34, line: 2)
        let moskovskaya = Station(name: "Московская", tag: 35, line: 2)
        let zvezdnaya = Station(name: "Звездная", tag: 36, line: 2)
        let kupchino = Station(name: "Купчино", tag: 37, line: 2)
        prosveshcheniya.addEdge(destination: parnas, time: 3, tag: 119)
        prosveshcheniya.addEdge(destination: ozerki, time: 4, tag: 120)
        udelnaya.addEdge(destination: ozerki, time: 3, tag: 121)
        udelnaya.addEdge(destination: pionerskaya, time: 2, tag: 122)
        chernayaRechka.addEdge(destination: pionerskaya, time: 4, tag: 123)
        chernayaRechka.addEdge(destination: petrogradskaya, time: 3, tag: 124)
        gorkovskaya.addEdge(destination: petrogradskaya, time: 3, tag: 125)
        gorkovskaya.addEdge(destination: nevskiy, time: 4, tag: 126)
        sennaya.addEdge(destination: nevskiy, time: 2, tag: 127)
        sennaya.addEdge(destination: tehnoInstitut2, time: 3, tag: 128)
        frunzenskaya.addEdge(destination: tehnoInstitut2, time: 3, tag: 129)
        frunzenskaya.addEdge(destination: vorota, time: 3, tag: 130)
        elektrosila.addEdge(destination: vorota, time: 2, tag: 131)
        elektrosila.addEdge(destination: parkPobedy, time: 3, tag: 132)
        moskovskaya.addEdge(destination: parkPobedy, time: 3, tag: 133)
        moskovskaya.addEdge(destination: zvezdnaya, time: 4, tag: 134)
        kupchino.addEdge(destination: zvezdnaya, time: 3, tag: 135)
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
        let begovaya = Station(name: "Беговая", tag: 38, line: 3)
        let novokresovskaya = Station(name: "Новокрестовская", tag: 39, line: 3)
        let primorskaya = Station(name: "Приморская", tag: 40, line: 3)
        let vasileostrovskaya = Station(name: "Василеостровская", tag: 41, line: 3)
        let gostiniyDvor = Station(name: "Гостиный двор", tag: 42, line: 3)
        let mayakovskaya = Station(name: "Маяковская", tag: 43, line: 3)
        let aleksandraNevskogo1 = Station(name: "Площадь Александра Невского-1", tag: 44, line: 3)
        let elisarovskaya = Station(name: "Елизаровская", tag: 45, line: 3)
        let lomonosovskaya = Station(name: "Ломоносовская", tag: 46, line: 3)
        let proletarskaya = Station(name: "Пролетарская", tag: 47, line: 3)
        let obuhovo = Station(name: "Обухово", tag: 48, line: 3)
        let rybatskoe = Station(name: "Рыбацкое", tag: 49, line: 3)
        novokresovskaya.addEdge(destination: begovaya, time: 4, tag: 136)
        novokresovskaya.addEdge(destination: primorskaya, time: 4, tag: 137)
        vasileostrovskaya.addEdge(destination: primorskaya, time: 3, tag: 138)
        vasileostrovskaya.addEdge(destination: gostiniyDvor, time: 4, tag: 139)
        mayakovskaya.addEdge(destination: gostiniyDvor, time: 2, tag: 140)
        mayakovskaya.addEdge(destination: aleksandraNevskogo1, time: 3, tag: 141)
        elisarovskaya.addEdge(destination: aleksandraNevskogo1, time: 4, tag: 142)
        elisarovskaya.addEdge(destination: lomonosovskaya, time: 3, tag: 143)
        proletarskaya.addEdge(destination: lomonosovskaya, time: 3, tag: 144)
        proletarskaya.addEdge(destination: obuhovo, time: 4, tag: 145)
        rybatskoe.addEdge(destination: obuhovo, time: 4, tag: 146)
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
    
    func createFourthLine() -> [Station] {
        var stations: [Station] = []
        let spasskaya = Station(name: "Спасская", tag: 50, line: 4)
        let dostoevskaya = Station(name: "Достоевская", tag: 51, line: 4)
        let ligovskiy = Station(name: "Лиговский проспект", tag: 52, line: 4)
        let aleksandraNevskogo2 = Station(name: "Площадь Александра Невского-2", tag: 53, line: 4)
        let novocherkasskaya = Station(name: "Новочеркасская", tag: 54, line: 4)
        let ladozhskaya = Station(name: "Ладожская", tag: 55, line: 4)
        let bolshevikov = Station(name: "Проспект Большевиков", tag: 56, line: 4)
        let dybenko = Station(name: "Дыбенко", tag: 57, line: 4)
        dostoevskaya.addEdge(destination: spasskaya, time: 2, tag: 147)
        dostoevskaya.addEdge(destination: ligovskiy, time: 2, tag: 148)
        aleksandraNevskogo2.addEdge(destination: ligovskiy, time: 2, tag: 149)
        aleksandraNevskogo2.addEdge(destination: novocherkasskaya, time: 4, tag: 150)
        ladozhskaya.addEdge(destination: novocherkasskaya, time: 3, tag: 151)
        ladozhskaya.addEdge(destination: bolshevikov, time: 3, tag: 152)
        dybenko.addEdge(destination: bolshevikov, time: 3, tag: 153)
        stations.append(spasskaya)
        stations.append(dostoevskaya)
        stations.append(ligovskiy)
        stations.append(aleksandraNevskogo2)
        stations.append(novocherkasskaya)
        stations.append(ladozhskaya)
        stations.append(bolshevikov)
        stations.append(dybenko)
        return stations
    }
    
    func createFifthLine() -> [Station] {
        var stations: [Station] = []
        let komendantskiy = Station(name: "Комендантский проспект", tag: 58, line: 5)
        let starayaDerevnya = Station(name: "Старая Деревня", tag: 59, line: 5)
        let krestovskiy = Station(name: "Крестовский остров", tag: 60, line: 5)
        let chkalovskaya = Station(name: "Чкаловская", tag: 61, line: 5)
        let sportivnaya = Station(name: "Спортивная", tag: 62, line: 5)
        let admiralteyskaya = Station(name: "Адмиралтейская", tag: 63, line: 5)
        let sadovaya = Station(name: "Садовая", tag: 64, line: 5)
        let zvenigorodskaya = Station(name: "Звенигородская", tag: 65, line: 5)
        let obvodnyKanal = Station(name: "Обводный канал", tag: 66, line: 5)
        let volkovskaya = Station(name: "Волковская", tag: 67, line: 5)
        let buharestskaya = Station(name: "Бухарестская", tag: 68, line: 5)
        let mezhdunarodnaya = Station(name: "Международная", tag: 69, line: 5)
        let prospektSlavy = Station(name: "Проспект Славы", tag: 70, line: 5)
        let dunayskaya = Station(name: "Дунайская", tag: 71, line: 5)
        let shushary = Station(name: "Шушары", tag: 72, line: 5)
        starayaDerevnya.addEdge(destination: komendantskiy, time: 3, tag: 154)
        starayaDerevnya.addEdge(destination: krestovskiy, time: 4, tag: 155)
        chkalovskaya.addEdge(destination: krestovskiy, time: 4, tag: 156)
        chkalovskaya.addEdge(destination: sportivnaya, time: 3, tag: 157)
        admiralteyskaya.addEdge(destination: sportivnaya, time: 4, tag: 158)
        admiralteyskaya.addEdge(destination: sadovaya, time: 3, tag: 159)
        zvenigorodskaya.addEdge(destination: sadovaya, time: 3, tag: 160)
        zvenigorodskaya.addEdge(destination: obvodnyKanal, time: 3, tag: 161)
        volkovskaya.addEdge(destination: obvodnyKanal, time: 3, tag: 162)
        volkovskaya.addEdge(destination: buharestskaya, time: 3, tag: 163)
        mezhdunarodnaya.addEdge(destination: buharestskaya, time: 3, tag: 164)
        mezhdunarodnaya.addEdge(destination: prospektSlavy, time: 3, tag: 165)
        dunayskaya.addEdge(destination: prospektSlavy, time: 3, tag: 166)
        dunayskaya.addEdge(destination: shushary, time: 4, tag: 167)
        stations.append(komendantskiy)
        stations.append(starayaDerevnya)
        stations.append(krestovskiy)
        stations.append(chkalovskaya)
        stations.append(sportivnaya)
        stations.append(admiralteyskaya)
        stations.append(sadovaya)
        stations.append(zvenigorodskaya)
        stations.append(obvodnyKanal)
        stations.append(volkovskaya)
        stations.append(buharestskaya)
        stations.append(mezhdunarodnaya)
        stations.append(prospektSlavy)
        stations.append(dunayskaya)
        stations.append(shushary)
        return stations
    }
}
