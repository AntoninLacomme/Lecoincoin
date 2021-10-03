package lecoincoin

import grails.gorm.transactions.ReadOnly
import grails.gorm.transactions.Transactional
import grails.transaction.NotTransactional

@Transactional
class UserRightsService {

    @NotTransactional
    def castAuthorities (Role role) {
        if (role == null) {
            return "?????";
        }
        if (role.authority == "ROLE_ADMIN") {
            return "Administrateur";
        }
        if (role.authority == "ROLE_MODERATEUR") {
            return "Modérateur";
        }
        if (role.authority == "ROLE_USER") {
            return "Utilisateur";
        }
        return "Hackeur ???";
    }
}
