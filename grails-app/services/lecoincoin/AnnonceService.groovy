package lecoincoin

import grails.gorm.services.Service
import lecoincoin.Annonce

@Service(Annonce)
interface AnnonceService {

    Annonce get(Serializable id)

    List<Annonce> list(Map args)

    Long count()

    void delete(Serializable id)

    Annonce save(Annonce annonce)

}