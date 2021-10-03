package lecoincoin

import grails.plugin.springsecurity.SpringSecurityService
import grails.plugin.springsecurity.annotation.Secured
import grails.validation.ValidationException
import org.springframework.security.core.context.SecurityContextHolder

import static org.springframework.http.HttpStatus.*

class UserController {

    UserService userService;
    UserRightsService userRightsService;
    SpringSecurityService springSecurityService;
    UserCreationService userCreationService;

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    @Secured(value=["ROLE_MODERATEUR", "ROLE_ADMIN", "ROLE_USER"], httpMethod="GET")
    def index(Integer max) {
        def listUsers = [];
        userService.list().each {
            user ->
                def tmpUser = [:];
                def req = Annonce.where {
                    author == user
                }
                tmpUser["Utilisateur"] = user.properties.username;
                tmpUser["Rôle"] = userRightsService.castAuthorities (user.properties.authorities.find());
                tmpUser["Nombre Annonces Créées"] = req.findAll().size();
                tmpUser["accountLocked"] = user.properties.accountLocked;
                tmpUser["passwordExpired"] = user.properties.passwordExpired;
                tmpUser["accountExpired"] = user.properties.accountExpired;
                tmpUser["id"] = user.properties.id;
                listUsers.add(tmpUser);
        }
        def accessRestricted = [:];
        accessRestricted["SELF_ACCESS"] = springSecurityService.currentUser.properties.authorities.find().authority;
        accessRestricted["ROLE_USER"] = ["Utilisateur", "Rôle", "Nombre Annonces Créées"];

        respond (userService, model:[userCount: listUsers.size(),
                                     userList: listUsers,
                                     accessRestricted: accessRestricted,
                                     userRights: springSecurityService.currentUser.properties.authorities.find().authority
        ])
    }

    @Secured(value=["ROLE_USER", "ROLE_MODERATEUR", "ROLE_ADMIN"], httpMethod="GET")
    def show(Long id) {
        def u = User.get(id);
        def t = Annonce.where { author == u };

        respond (userService.get(id), model:[
                userAnnonces: t.findAll(),
                userCurrentId: springSecurityService.currentUser.id,
                userRights: springSecurityService.currentUser.properties.authorities.find().authority
        ])
    }

    @Secured(value=["ROLE_ADMIN"], httpMethod="GET")
    def create() {
        respond new User(params)
    }

    @Secured(value=["ROLE_ADMIN"], httpMethod="POST")
    def save(User user) {
        if (params["password"] != params["validation_password"]) {
            respond (user.errors, view:'create');
            return
        }

        if (user == null) {
            notFound()
            return
        }

        try {
            userCreationService.saveUser (user);
        } catch (ValidationException e) {
            respond (user.errors, view:'create');
            return
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'user.label', default: 'User'), user.id])
                redirect user
            }
            '*' { respond user, [status: CREATED] }
        }
    }

    @Secured(value=["ROLE_USER", "ROLE_MODERATEUR", "ROLE_ADMIN"], httpMethod="GET")
    def edit(Long id) {
        respond userService.get(id)
    }

    @Secured(value=["ROLE_USER", "ROLE_MODERATEUR", "ROLE_ADMIN"], httpMethod="PUT")
    def update(User user) {
        if (params["password"] != params["validation_password"]) {
            respond (user.errors, view:'edit');
            return;
        }
        userCreationService.updateUser (springSecurityService.getCurrentUser(), params)

        if (user == null) {
            notFound()
            return
        }
        try {
            userService.save(user)
        } catch (ValidationException e) {
            respond (user.errors, view:'edit')
            return
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'user.label', default: 'User'), user.id])
                redirect user
            }
            '*'{ respond user, [status: OK] }
        }
    }

    @Secured(value=["ROLE_ADMIN"], httpMethod="DELETE")
    def delete(Long id) {
        if (id == null) {
            notFound()
            return
        }
        userCreationService.deleteUserByID(id);

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'user.label', default: 'User'), id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'user.label', default: 'User'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
