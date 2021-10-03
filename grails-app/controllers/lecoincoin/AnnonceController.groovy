package lecoincoin

import grails.plugin.springsecurity.SpringSecurityService
import grails.plugin.springsecurity.annotation.Secured
import grails.validation.ValidationException

import java.time.LocalDateTime
import java.time.format.DateTimeFormatter

import static org.springframework.http.HttpStatus.*

class AnnonceController {
    AnnonceService annonceService;
    AnnonceCreationService annonceCreationService;
    SpringSecurityService springSecurityService;
    UserRightsService userRightsService;
    Illustration_file_Service illustration_file_Service = new Illustration_file_Service();

    static allowedMethods = [save: "POST", delete: "DELETE"]

    @Secured(value=["ROLE_USER", "ROLE_MODERATEUR", "ROLE_ADMIN"], httpMethod='GET')
    def index(Long id) {
        // si aucun id, on envoi tout, lets go !
        def listAnnonceUser = annonceService.list(params);
        // l'id ne correspond pas à l'utilisateur courant ! TRICHEUR !
        if (id != null && id != springSecurityService.getCurrentUserId()) {
            listAnnonceUser = [];
        }
        // on vérifie si l'id du user pour ne lui donner que les annonces qu'il a créé
        if (id == springSecurityService.getCurrentUserId()) {
            listAnnonceUser = [];
            annonceService.list(params).each {
                annonce ->
                    if (annonce.authorId == id) {
                        listAnnonceUser.add(annonce);
                    }
            }
        }

        respond (listAnnonceUser, model:[annonceCount: annonceService.count(),
                                         user: springSecurityService.currentUser,
                                         userRights: springSecurityService.currentUser.properties.authorities.find().authority]);
                                         //pathImg: grailsApplication.config.getProperty('datalecoincoin.url')])
    }

    @Secured(value=["ROLE_USER", "ROLE_MODERATEUR", "ROLE_ADMIN"], httpMethod='GET')
    def show(Long id) {
        respond (annonceService.get(id), model:
                [pathImg: grailsApplication.config.getProperty('datalecoincoin.url'),
                user: springSecurityService.currentUser,
                userRights: springSecurityService.currentUser.properties.authorities.find().authority]
        );
    }

    @Secured(value=["ROLE_USER", "ROLE_MODERATEUR", "ROLE_ADMIN"], httpMethod='GET')
    def create() {
        respond (new Annonce(params));
    }

    @Secured(value=["ROLE_USER", "ROLE_MODERATEUR", "ROLE_ADMIN"], httpMethod="POST")
    def save() {
        def imgs = illustration_file_Service.uploadFile(grailsApplication.config.getProperty('datalecoincoin.path'),
                request.getFiles ("image"));
        def annonce = annonceCreationService.createAndSaveArticle (params, imgs, springSecurityService.currentUser);

        if (annonce == null) {
            notFound()
            return
        }

        try {
            annonceService.save (annonce);
        } catch (ValidationException e) {
            redirect (controller: "annonce", action:"create");
            return;
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message',
                        args: [message(code: 'annonce.label', default: 'Annonce'), annonce.title])
                redirect (annonce);
            }
            '*' { respond (annonce, [status: CREATED]) }
        }
    }

    // seul un admin ou le possesseur de l'annonce peut la modifier
    // si une personne non autorisée cherche à modifier des données ne lui appartenant pas elle est renvoyée à index
    @Secured(value=["ROLE_USER", "ROLE_MODERATEUR", "ROLE_ADMIN"], httpMethod="GET")
    def edit(Long id) {
        if (!((springSecurityService.currentUser.properties.authorities.authority.get(0) == "ROLE_ADMIN") ||
                (Annonce.findById (id).authorId == springSecurityService.currentUserId))) {
            redirect (controller: "annonce", action:"index");
            return;
        }

        respond (annonceService.get(id), model:[pathImg: grailsApplication.config.getProperty('datalecoincoin.url')]);
    }

    // pk POST plutôt que PUT ?
    // j'envoi des fichiers, et le PUT m'empêche de les récupérer :(
    @Secured(value=["ROLE_USER", "ROLE_MODERATEUR", "ROLE_ADMIN"], httpMethod="POST")
    def update(Annonce annonce) {
        println(params);

        def imgs;
        try {
            imgs = illustration_file_Service.uploadFile(grailsApplication.config.getProperty('datalecoincoin.path'),
                    request.getFiles("image"));
        } catch (Exception e) {
            println("Impossible d'enregistrer les nouvelles images");
            println(params);
            imgs = [];
        }
        def annonceToUpdate = annonceCreationService.updateAndSaveArticle(params, imgs);

        if (annonceToUpdate == null) {
            notFound()
            return
        }

        try {
            annonceService.save(annonceToUpdate)
        } catch (ValidationException e) {
            respond (annonce.errors, view:'edit')
            return
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'annoce.label', default: 'Annonce'), annonceToUpdate.id])
                redirect annonceToUpdate
            }
            '*'{ respond annonceToUpdate, [status: OK] }
        }
    }

    @Secured(value=["ROLE_USER", "ROLE_MODERATEUR", "ROLE_ADMIN"], httpMethod="DELETE")
    def delete(Long id) {
        if (id == null) {
            notFound()
            return
        }
        def annonce = Annonce.findById(id);
        // on supprime toutes les images liées à l'annonce
        println(annonce.images);
        illustration_file_Service.dropIllustrations (grailsApplication.config.getProperty('datalecoincoin.path'),
                                                        annonce.images);
        // on supprime l'annonce
        annonceService.delete(id)

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'annonce.label', default: 'Annonce'), id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'annonce.label', default: 'Annonce'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
