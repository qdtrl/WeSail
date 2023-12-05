//
//  Events.swift
//  WeSail
//
//  Created by Quentin Dubut-Touroul on 02/12/2023.
//

import Foundation

class EventsModel: ObservableObject {
    @Published var events = [Event]()
    
    @Published var mockData = [
        Event(
            eventId: "1", name: "Les Voiles de Saint-Tropez", organizer: "Société Nautique de Saint-Tropez", description: "Les Voiles de Saint-Tropez est une régate qui a lieu chaque année la dernière semaine de septembre en Méditerranée autour de Saint-Tropez, en France. C'est l'une des plus grandes régates au monde avec plus de 300 voiliers modernes et classiques qui participent pendant une semaine. La régate est organisée par la Société Nautique de Saint-Tropez.", type: "Régate", images: ["https://www.immobilieralacarte.eu/photo/img/actualites-saint-tropez/voiles_de_saint_tropez.jpg?time=1599116518458", "https://resize-parismatch.lanmedia.fr/r/940,628/img/var/news/storage/images/paris-match/actu/sport/les-voiles-de-saint-tropez-defile-de-haute-mer-1580730/25636452-1-fre-FR/les-Voiles-de-Saint-Tropez-defile-de-haute-mer.jpg", "https://www.charterworld.com/news/wp-content/uploads/2010/10/Unique-ambiance-at-Les-Voiles-de-Saint-Tropez-Photo-credit-Rolex-Carlo-Borlenghi.jpg"], startDate: Date(), endDate: Date()
        ),
        Event(
            eventId: "2", name: "Route du Rhum", organizer: "OC Sport Pen Duick", description: "La Route du Rhum est une course à la voile transatlantique en solitaire, courue tous les quatre ans, fin octobre début novembre, entre Saint-Malo et la Guadeloupe.", type: "Transatlantique", images: ["https://www.dynamoplus.fr/sites/www.dynamoplus.fr/IMG/png/elements-rdr.png", "https://defi-voile-solidairesenpeloton.com/wp-content/uploads/2019/01/65614-depart-de-la-route-du-rhum-destination-guadeloupe-2018-r-1200-900.jpg", "https://lekiosque.bzh/wp-content/uploads/2018/11/route-du-rhum.jpg"], startDate: Date(), endDate: Date()
        ),
        Event(
            eventId: "3", name: "Tour des ports de la manche", organizer: "Yacht Club de Granville", description: "Le Tour des ports de la Manche est une course à la voile en équipage, organisée par le Yacht Club de Granville, qui se déroule chaque année au mois de juillet. La course est ouverte aux voiliers habitables de 6 à 16 mètres, répartis en 5 classes.", type: "Régate", images: ["https://tourdesports50.fr/wp-content/uploads/2019/04/affiche-edition-2019-tour-des-ports-de-la-manche.jpg", "https://tourdesports50.fr/wp-content/uploads/2017/03/Tour-ports-50-2016-Cherbourg-Saint-Vaast-111-1024x682.jpg", "https://tourdesports50.fr/wp-content/uploads/2022/09/DSC3505-2048x1024.jpg"], startDate: Date(), endDate: Date()
        ),
        Event(
            eventId: "4", name: "Tour de France à la voile", organizer: "Ultim Sailing", description: "Une vingtaine d'équipages s'affrontent sur un parcours où se succèdent lors de chaque acte raids côtiers et parcours en stade nautique, de courtes régates où les concurrents naviguent au plus proche des côtes et du public", type: "Régate", images: ["https://blog.filovent.com/wp-content/etapes-tour-de-france-voile.jpeg", "https://media.ouest-france.fr/v1/pictures/MjAxNzA1Y2U3NTFiMGRjOTNkNWM5MGJmODI3MWM1ODc0NDRkZDc?width=1260&height=712&focuspoint=50%2C25&cropresize=1&client_id=bpeditorial&sign=b891ed09becf7ae34ae2da98414c96c1e65eb177809acad42cc75aa6e380673e", "https://i.ytimg.com/vi/T8k5a3st6lY/maxresdefault.jpg"], startDate: Date(), endDate: Date()
        )
    ]
}  
