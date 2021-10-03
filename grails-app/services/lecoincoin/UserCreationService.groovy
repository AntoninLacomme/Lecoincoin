package lecoincoin

import grails.gorm.transactions.Transactional

@Transactional
class UserCreationService {

    @Transactional
    def updateUser (currentUser, params) {
        currentUser.properties = [
                username: params["username"],
                password: params["password"]
        ];
        currentUser.save(flush: true);
    }

    @Transactional
    def deleteUserByID (long id) {
        def userInstance = User.get(id);
        UserRole.where {user == userInstance}.findAll ().each {
            it.delete();
        }
        userInstance.delete();
    }

    @Transactional
    def saveUser (user) {
        user.save ();
        UserRole.create (user, Role.where {authority == "ROLE_USER"}.find ());
    }
}
