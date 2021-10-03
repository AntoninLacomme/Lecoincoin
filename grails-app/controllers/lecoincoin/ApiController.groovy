package lecoincoin

import grails.converters.JSON
import grails.converters.XML

class ApiController {
    IllustrationFileService illustrationFileService;
    AnnonceCreationService annonceCreationService;
    def user()
    {
        switch(request.getMethod())
        {
            case "GET":
                if(!params.id)
                    return response.status = 400
                def userInstance = User.get(params.id)
                if (!userInstance)
                    return response.status = 404
                response.withFormat {
                    xml { render userInstance as XML }
                    json { render userInstance as JSON }
                }
                break;
            case "PUT":
                if(!params.id || (params.roles && !(params.roles instanceof String) && !(params.roles instanceof List<String>)))
                    return response.status = 400
                def userInstance = User.get(params.id)

                if (!userInstance)
                    userInstance = new User()

                if (!params.username || !params.password || !params.roles)
                    return response.status = 400

                userInstance.username = params.username
                userInstance.password = params.password

                if (params.accountLocked)
                    userInstance.accountLocked = params.accountLocked

                if (params.roles) {
                    def roles;
                    if (params.roles instanceof String) {
                        roles = new ArrayList<String>()
                        roles.add(params.roles)
                    } else {
                        roles = params.roles;
                    }

                    for (def role : roles) {
                        def found = false
                        for (def userRole : userInstance.getAuthorities()) {
                            if (userRole.authority.equals(role)) {
                                found = true
                            }
                        }

                        if (!found) {
                            def existingRole = Role.findByAuthority(role)
                            if (!existingRole) return response.status = 400
                            UserRole.create(userInstance, existingRole)
                        }
                    }
                }

                if (!userInstance.save(flush:true))
                    return response.status = 400

                response.withFormat {
                    xml { render userInstance as XML }
                    json { render userInstance as JSON }
                }
                break;
            case "PATCH":
                if(!params.id)
                    return response.status = 400
                def userInstance = User.get(params.id)

                if (!userInstance) return response.status = 404

                if (params.username)
                    userInstance.username = params.username
                if (params.password)
                    userInstance.password = params.password
                if (params.accountLocked)
                    userInstance.accountLocked = params.accountLocked
                if (params.roles) {
                    def roles;
                    if (params.roles instanceof String) {
                        roles = new ArrayList<String>()
                        roles.add(params.roles)
                    } else {
                        roles = params.roles;
                    }

                    for (def role : roles) {
                        def found = false
                        for (def userRole : userInstance.getAuthorities()) {
                            if (userRole.authority.equals(role)) {
                                found = true
                            }
                        }

                        if (!found) {
                            def existingRole = Role.findByAuthority(role)
                            if (!existingRole) return response.status = 400
                            UserRole.create(userInstance, existingRole)
                        }
                    }
                }

                if (!userInstance.save(flush:true))
                    return response.status = 400

                response.withFormat {
                    xml { render userInstance as XML }
                    json { render userInstance as JSON }
                }
                break;
            case "DELETE":
                // We don't allow the deletion of users
                return response.status = 405
                break;
            default:
                return response.status = 405
                break
        }
        return response.status = 406
    }

    def users()
    {
        switch(request.getMethod())
        {
            case "GET":
                def userList = User.getAll()
                response.withFormat {
                    xml { render userList as XML }
                    json { render userList as JSON }
                }
                break;
            default:
                return response.status = 405
                break
        }
        return response.status = 406
    }

    def annonces()
    {
        switch(request.getMethod())
        {
            case "GET":
                def annoncesList = Annonce.getAll()
                response.withFormat {
                    xml { render annoncesList as XML }
                    json { render annoncesList as JSON }
                }
                break;
            default:
                return response.status = 405
                break
        }
        return response.status = 406
    }

    def annonce (String id) {
        switch(request.getMethod())
        {
            case "GET":
                if(!params.id)
                    return response.status = 400
                def annonceInstance = Annonce.get(params.id)
                if (!annonceInstance)
                    return response.status = 404
                response.withFormat {
                    xml { render annonceInstance as XML }
                    json { render annonceInstance as JSON }
                }
                break;
            case "PUT":
                if(!params.id || (params.illustration && !(params.illustration instanceof String) && !(params.illustration instanceof List<String>)))
                    return response.status = 400
                def annonceInstance = Annonce.get(params.id)

                if (!annonceInstance)
                    annonceInstance = new Annonce();

                if (!params.title || !params.description || !params.price)
                    return response.status = 400

                annonceInstance.title = params.title
                annonceInstance.description = params.description
                annonceInstance.price = params.price

                if (!request.getFiles("image").isEmpty()) {

                    def imgs;
                    try {
                        imgs = illustrationFileService.uploadFile(grailsApplication.config.getProperty('datalecoincoin.path'),
                                request.getFiles("image"));
                    } catch (Exception e) {
                        println("Impossible d'enregistrer les nouvelles images");
                        println(params);
                        imgs = [];
                    }

                    annonceInstance.images = imgs
                }

                if (!annonceInstance.save(flush:true))
                    return response.status = 400

                response.withFormat {
                    xml { render annonceInstance as XML }
                    json { render annonceInstance as JSON }
                }
                break;
            case "PATCH":
                if(!params.id)
                    return response.status = 400
                def annonceInstance = Annonce.get(params.id)

                if (!annonceInstance) return response.status = 404

                if (params.title)
                    annonceInstance.title = params.title
                if (params.description)
                    annonceInstance.description = params.description
                if (params.price)
                    annonceInstance.price = params.price
                if (!request.getFiles("image").isEmpty()) {

                    def imgs;
                    try {
                        imgs = illustrationFileService.uploadFile(grailsApplication.config.getProperty('datalecoincoin.path'),
                                request.getFiles("image"));
                    } catch (Exception e) {
                        println("Impossible d'enregistrer les nouvelles images");
                        println(params);
                        imgs = [];
                    }

                    annonceInstance.images = imgs
                }

                if (!userInstance.save(flush:true))
                    return response.status = 400

                response.withFormat {
                    xml { render userInstance as XML }
                    json { render userInstance as JSON }
                }
                break;
            case "DELETE":
                if(!params.id)
                    return response.status = 400
                def annonceInstance = Annonce.get(params.id)

                if (!annonceInstance) return response.status = 404

                annonceInstance.delete(flush: true)

                return response.status = 200
                break;
            default:
                return response.status = 405
                break
        }
        return response.status = 406
    }
}
