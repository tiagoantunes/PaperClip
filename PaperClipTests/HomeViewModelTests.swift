//
//  HomeViewModel.swift
//  PaperClip
//
//  Created by Tiago Antunes on 17/02/2025.
//

import XCTest
import Combine
@testable import PaperClip

class DataServiceMock: DataServiceProtocol {
    var adsToReturn: AdList?
    var errorToThrow: Error?
    var moreContentAvailable = false

    func getAdList() async throws -> AdList {
        if let error = errorToThrow {
            throw error
        }
        return adsToReturn ?? AdList(ads: [])
    }

    func getAdCategories() async throws -> [AdCategory] {
        return []
    }

    func searchAd(withText text: String) async throws -> AdList {
        if let error = errorToThrow {
            throw error
        }
        return adsToReturn ?? AdList(ads: [])
    }
}

class HomeViewModelTests: XCTestCase {
    var viewModel: HomeViewModel!
    var dataServiceMock: DataServiceMock!
    var cancellables: Set<AnyCancellable>!

    let ad1 = AdItem(
        id: 1691247255,
        categoryId: 8,
        title: "Pc portable hp elitebook 820 g1 core i5 4 go ram 250 go hdd",
        description: "= = = = = = = = = PC PORTABLE HP ELITEBOOK 820 G1 = = = = = = = = = # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # HP ELITEBOOK 820 G1 Processeur : Intel Core i5 4300M Fréquence : 2,60 GHz Mémoire : 4 GO DDR3 Disque Dur : 320 GO SATA Vidéo : Intel HD Graphics Lecteur Optique : Lecteur/Graveur CD/DVDRW Réseau : LAN 10/100 Système : Windows 7 Pro – 64bits Etat : Reconditionné  Garantie : 6 Mois Prix TTC : 199,00 € Boostez ce PC PORTABLE : Passez à la vitesse supérieure en augmentant la RAM : Passez de 4 à 6 GO de RAM pour 19€  Passez de 4 à 8 GO de RAM pour 29€  (ajout rapide, doublez la vitesse en 5 min sur place !!!) Stockez plus en augmentant la capacité de votre disque dur : Passez en 500 GO HDD pour 29€  Passez en 1000 GO HDD pour 49€  Passez en 2000 GO HDD pour 89€  Passez en SSD pour un PC 10 Fois plus rapide : Passez en 120 GO SSD pour 49€  Passez en 240 GO SSD pour 79€  Passez en 480 GO SSD pour 119€ # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # Nous avons plus de 300 Ordinateurs PC Portables. Visible en boutique avec une garantie de 6 mois vendu avec Facture TVA, pas de surprise !!!! Les prix varient en moyenne entre 150€ à 600€, PC Portables en stock dans notre boutique sur Paris. # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # KIATOO est une société qui regroupe à la fois: - PC Portable - PC de Bureau / Fixe - Chargeur PC Portable - Batterie PC Portable - Clavier PC Portable - Ventilateur PC Portable - Nappe LCD écran - Ecran LCD PC Portable - Mémoire PC Portable - Disque dur PC Portable - Inverter PC Portable - Connecteur Jack DC PC Portable ASUS, ACER, COMPAQ, DELL, EMACHINES, HP, IBM, LENOVO, MSI, PACKARD BELL, PANASONIC, SAMSUNG, SONY, TOSHIBA...",
        price: 199.00,
        imagesUrl: ImagesUrl(
            small: "https://raw.githubusercontent.com/leboncoin/paperclip/master/ad-small/633f278423b9aa6b04fa9cc954079befd294473f.jpg",
            thumb: "https://raw.githubusercontent.com/leboncoin/paperclip/master/ad-thumb/633f278423b9aa6b04fa9cc954079befd294473f.jpg"
        ),
        creationDate: "2019-10-16T17:10:20+0000",
        isUrgent: false
    )

    let ad2 = AdItem(
        id: 1664493117,
        categoryId: 9,
        title: "Professeur natif d'espagnol à domicile",
        description: "Doctorant espagnol, ayant fait des études de linguistique comparée français - espagnol et de traduction (thème/version) 0 la Sorbonne, je vous propose des cours d'espagnol à domicile à Paris intramuros. Actuellement j'enseigne l'espagnol dans un lycée et j'ai plus de cinq ans d'expérience comme professeur particulier, à Paris et à Madrid. Tous les niveaux, tous les âges. Je m'adapte à vos besoins et vous propose une méthode personnalisée et dynamique, selon vos point forts et vos points faibles, pour mieux travailler votre :  - Expression orale - Compréhension orale - Grammaire - Vocabulaire - Production écrite - Compréhension écrite Tarif : 25 euros/heure",
        price: 25.00,
        imagesUrl: ImagesUrl(
            small: "https://raw.githubusercontent.com/leboncoin/paperclip/master/ad-small/af9c43ff5a3b3692f9f1aa3c17d7b46d8b740311.jpg",
            thumb: "https://raw.githubusercontent.com/leboncoin/paperclip/master/ad-thumb/af9c43ff5a3b3692f9f1aa3c17d7b46d8b740311.jpg"
        ),
        creationDate: "2019-11-05T15:56:55+0000",
        isUrgent: false,
        siret: "123 323 002"
    )

    override func setUpWithError() throws {
        dataServiceMock = DataServiceMock()
        viewModel = HomeViewModel(dataService: dataServiceMock)
        cancellables = Set<AnyCancellable>()
    }

    override func tearDownWithError() throws {
        viewModel = nil
        dataServiceMock = nil
        cancellables = nil
    }

    func testFetchAdsData_Success() async throws {
        let ads = [ad1, ad2]
        let adsData = AdList(ads: ads)
        dataServiceMock.adsToReturn = adsData

        await viewModel.fetchAdsData()

        XCTAssertEqual(viewModel.ads.count, 2)

        let firstAd = viewModel.ads.first!
        let lastAd = viewModel.ads.last!

        XCTAssertEqual(firstAd.title, "Pc portable hp elitebook 820 g1 core i5 4 go ram 250 go hdd")
        XCTAssertEqual(firstAd.description, "= = = = = = = = = PC PORTABLE HP ELITEBOOK 820 G1 = = = = = = = = = # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # HP ELITEBOOK 820 G1 Processeur : Intel Core i5 4300M Fréquence : 2,60 GHz Mémoire : 4 GO DDR3 Disque Dur : 320 GO SATA Vidéo : Intel HD Graphics Lecteur Optique : Lecteur/Graveur CD/DVDRW Réseau : LAN 10/100 Système : Windows 7 Pro – 64bits Etat : Reconditionné  Garantie : 6 Mois Prix TTC : 199,00 € Boostez ce PC PORTABLE : Passez à la vitesse supérieure en augmentant la RAM : Passez de 4 à 6 GO de RAM pour 19€  Passez de 4 à 8 GO de RAM pour 29€  (ajout rapide, doublez la vitesse en 5 min sur place !!!) Stockez plus en augmentant la capacité de votre disque dur : Passez en 500 GO HDD pour 29€  Passez en 1000 GO HDD pour 49€  Passez en 2000 GO HDD pour 89€  Passez en SSD pour un PC 10 Fois plus rapide : Passez en 120 GO SSD pour 49€  Passez en 240 GO SSD pour 79€  Passez en 480 GO SSD pour 119€ # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # Nous avons plus de 300 Ordinateurs PC Portables. Visible en boutique avec une garantie de 6 mois vendu avec Facture TVA, pas de surprise !!!! Les prix varient en moyenne entre 150€ à 600€, PC Portables en stock dans notre boutique sur Paris. # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # KIATOO est une société qui regroupe à la fois: - PC Portable - PC de Bureau / Fixe - Chargeur PC Portable - Batterie PC Portable - Clavier PC Portable - Ventilateur PC Portable - Nappe LCD écran - Ecran LCD PC Portable - Mémoire PC Portable - Disque dur PC Portable - Inverter PC Portable - Connecteur Jack DC PC Portable ASUS, ACER, COMPAQ, DELL, EMACHINES, HP, IBM, LENOVO, MSI, PACKARD BELL, PANASONIC, SAMSUNG, SONY, TOSHIBA...")
        XCTAssertEqual(firstAd.price, 199.00)
        XCTAssertEqual(firstAd.creationDate, "2019-10-16T17:10:20+0000")
        XCTAssertFalse(firstAd.isUrgent)

        XCTAssertEqual(lastAd.title, "Professeur natif d'espagnol à domicile")
        XCTAssertEqual(lastAd.description, "Doctorant espagnol, ayant fait des études de linguistique comparée français - espagnol et de traduction (thème/version) 0 la Sorbonne, je vous propose des cours d'espagnol à domicile à Paris intramuros. Actuellement j'enseigne l'espagnol dans un lycée et j'ai plus de cinq ans d'expérience comme professeur particulier, à Paris et à Madrid. Tous les niveaux, tous les âges. Je m'adapte à vos besoins et vous propose une méthode personnalisée et dynamique, selon vos point forts et vos points faibles, pour mieux travailler votre :  - Expression orale - Compréhension orale - Grammaire - Vocabulaire - Production écrite - Compréhension écrite Tarif : 25 euros/heure")
        XCTAssertEqual(lastAd.price, 25.00)
        XCTAssertEqual(lastAd.creationDate, "2019-11-05T15:56:55+0000")
        XCTAssertFalse(lastAd.isUrgent)
        XCTAssertEqual(lastAd.siret, "123 323 002")

        XCTAssertFalse(viewModel.isDataLoading)
        XCTAssertEqual(viewModel.navigationBarTitle, "Items (2/2)")
    }

    func testFetchAdsData_Failure() async throws {
        dataServiceMock.errorToThrow = NetworkError.invalidResponse

        await viewModel.fetchAdsData()

        XCTAssertTrue(viewModel.showAlert)
        XCTAssertTrue(viewModel.isDataLoading)
    }

    func testOnTryAgain() async throws {
        let ads = [ad1]
        let adsData = AdList(ads: ads)
        dataServiceMock.adsToReturn = adsData

        let expectation = XCTestExpectation(description: "Ads should be fetched")

        viewModel.$ads
            .dropFirst()
            .sink { adList in
                XCTAssertEqual(adList.count, 1)
                let ad = adList.first!
                XCTAssertEqual(ad.title, "Pc portable hp elitebook 820 g1 core i5 4 go ram 250 go hdd")
                XCTAssertEqual(ad.description, "= = = = = = = = = PC PORTABLE HP ELITEBOOK 820 G1 = = = = = = = = = # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # HP ELITEBOOK 820 G1 Processeur : Intel Core i5 4300M Fréquence : 2,60 GHz Mémoire : 4 GO DDR3 Disque Dur : 320 GO SATA Vidéo : Intel HD Graphics Lecteur Optique : Lecteur/Graveur CD/DVDRW Réseau : LAN 10/100 Système : Windows 7 Pro – 64bits Etat : Reconditionné  Garantie : 6 Mois Prix TTC : 199,00 € Boostez ce PC PORTABLE : Passez à la vitesse supérieure en augmentant la RAM : Passez de 4 à 6 GO de RAM pour 19€  Passez de 4 à 8 GO de RAM pour 29€  (ajout rapide, doublez la vitesse en 5 min sur place !!!) Stockez plus en augmentant la capacité de votre disque dur : Passez en 500 GO HDD pour 29€  Passez en 1000 GO HDD pour 49€  Passez en 2000 GO HDD pour 89€  Passez en SSD pour un PC 10 Fois plus rapide : Passez en 120 GO SSD pour 49€  Passez en 240 GO SSD pour 79€  Passez en 480 GO SSD pour 119€ # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # Nous avons plus de 300 Ordinateurs PC Portables. Visible en boutique avec une garantie de 6 mois vendu avec Facture TVA, pas de surprise !!!! Les prix varient en moyenne entre 150€ à 600€, PC Portables en stock dans notre boutique sur Paris. # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # KIATOO est une société qui regroupe à la fois: - PC Portable - PC de Bureau / Fixe - Chargeur PC Portable - Batterie PC Portable - Clavier PC Portable - Ventilateur PC Portable - Nappe LCD écran - Ecran LCD PC Portable - Mémoire PC Portable - Disque dur PC Portable - Inverter PC Portable - Connecteur Jack DC PC Portable ASUS, ACER, COMPAQ, DELL, EMACHINES, HP, IBM, LENOVO, MSI, PACKARD BELL, PANASONIC, SAMSUNG, SONY, TOSHIBA...")
                XCTAssertEqual(ad.price, 199.00)
                XCTAssertEqual(ad.creationDate, "2019-10-16T17:10:20+0000")
                XCTAssertFalse(ad.isUrgent)
                expectation.fulfill()
            }
            .store(in: &cancellables)

        viewModel.onTryAgain()

        await fulfillment(of: [expectation], timeout: 1.0)
    }

    func testSearchAd_Success() async throws {
        let ads = [ad1]
        let adsData = AdList(ads: ads)
        dataServiceMock.adsToReturn = adsData

        await viewModel.fetchAdsData()

        let expectation = XCTestExpectation(description: "Search ads updated")

        viewModel.$searchAds
            .dropFirst()
            .sink { adList in
                XCTAssertEqual(adList.count, 1)
                XCTAssertEqual(adList.first?.title, "Pc portable hp elitebook 820 g1 core i5 4 go ram 250 go hdd")
                expectation.fulfill()
            }
            .store(in: &cancellables)

        viewModel.searchText = "Pc portable"

        await fulfillment(of: [expectation], timeout: 1.0)
    }

    func testSearchAd_NoResults() async throws {
        let ads = [ad1]
        let adsData = AdList(ads: ads)
        dataServiceMock.adsToReturn = adsData

        let expectation = XCTestExpectation(description: "Search ads without any corresponding results")

        viewModel.$searchAds
            .dropFirst()
            .sink { adList in
                XCTAssertEqual(adList.count, 0)
                expectation.fulfill()
            }
            .store(in: &cancellables)

        viewModel.searchText = "random ad message"

        await fulfillment(of: [expectation], timeout: 1.0)
    }
}
