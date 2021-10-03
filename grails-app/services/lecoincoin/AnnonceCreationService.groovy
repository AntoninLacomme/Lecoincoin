package lecoincoin

import grails.gorm.transactions.Transactional
import java.time.LocalDateTime
import java.time.format.DateTimeFormatter

@Transactional
class AnnonceCreationService {

    DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy/MM/dd HH:mm:ss");

    @Transactional
    def createAndSaveArticle (params, listImgs, User user) {
        LocalDateTime now = LocalDateTime.now();

        def annonce = new Annonce (title: params["title"],
                description: params["description"],
                price: params["price"],
                dateCreated: dtf.format(now),
                lastUpdated: dtf.format(now),
                author: user,
                images: listImgs
        );
        annonce.save ();
        return annonce;
    }

    @Transactional
    def updateAndSaveArticle (params, listImgs) {
        def annonceToUpdate = Annonce.findById(params["ID"]);
        this.dropIllustrationFromAnnonce(params["imageToSupp"]);

        LocalDateTime now = LocalDateTime.now();
        def map = [
                title: params["title"],
                description: params["description"],
                price: params["price"],
                lastUpdate: dtf.format(now),
                images: listImgs
        ]

        annonceToUpdate.properties = map;
        annonceToUpdate.save (flush: true);
        return annonceToUpdate;
    }

    @Transactional
    def dropIllustrationFromAnnonce (listIdAnnonces) {
        def imgsToSupp;
        if (listIdAnnonces.getClass().equals("".getClass())) {
            imgsToSupp = [listIdAnnonces];
        } else {
            imgsToSupp = listIdAnnonces;
        }
        // on drop les images !
        imgsToSupp.each {
            Illustration.findById (it).delete (flush:true);
        }
    }
}
