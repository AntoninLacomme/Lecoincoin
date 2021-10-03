package lecoincoin

import grails.gorm.transactions.Transactional

import java.text.SimpleDateFormat

@Transactional
class BootStrapService {

    def launch () {
        def roles = initializeRoles();
        def users = initializeUsers(roles);
        initializeAnnonces(users);
    }

    private def initializeRoles () {
        def adminRole = new Role (authority: "ROLE_ADMIN").save ();
        def moderateurRole = new Role (authority: "ROLE_MODERATEUR").save ();
        def clientRole = new Role (authority: "ROLE_USER").save ();
        return ["ROLE_ADMIN": adminRole, "ROLE_MODERATEUR": moderateurRole, "ROLE_USER": clientRole];
    }

    private def initializeUsers (roles) {
        def adminUser = new User (username: "admin", password: "admin").save ();
        def modoUser = new User (username: "modo", password: "modo").save ();
        def clientUser = new User (username: "slave", password: "slave").save ();

        def mrcoincoin = new User (username: "LeCoinCoin", password: "lecoincoin").save ();
        def mscoincoin = new User (username: "LaCoinCoin", password: "lacoincoin").save ();

        UserRole.create (adminUser, roles.ROLE_ADMIN, true);
        UserRole.create (modoUser, roles.ROLE_MODERATEUR, true);
        UserRole.create (clientUser, roles.ROLE_USER, true);

        UserRole.create (mrcoincoin, roles.ROLE_ADMIN, true);
        UserRole.create (mscoincoin, roles.ROLE_MODERATEUR, true);

        (0..200).each {
            def user = new User (username: this.generateRandomString(new Random ().nextInt(8) + 4),
                                password: "password").save();
            UserRole.create (user, roles.ROLE_USER, true);
        }

        return [mrcoincoin, mscoincoin];
    }

    private def initializeAnnonces (users) {
        def date = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date(System.currentTimeMillis()));

        new Annonce (title: "Lancement de notre plateforme LeCoinCoin",
                description: "Bonjour à tous nos clients, notre entreprise LeCoinCoin ouvre officiellement ses portes ! Passez un agréable moment sur notre application !",
                dateCreated: date,
                lastUpdated: date,
                author: users.get(0)).save ();
        new Annonce (title: "Lancement de la plateforme LeCoinCoin",
                description: "Mon mari et moi sommes heureux d'ouvrir notre application LeCoinCoin, venez nombreux !",
                dateCreated: date,
                lastUpdated: date,
                author: users.get(1)).save ();
    }

    private String generateRandomString (int length) {
        if (length < 1) {
            return "";
        }
        byte[] array = new byte[length];
        new Random().nextBytes(array);
        return new String(array);
    }
}
