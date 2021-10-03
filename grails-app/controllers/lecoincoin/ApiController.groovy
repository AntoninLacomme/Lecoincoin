package lecoincoin

class ApiController {

    def annonce (String id) {
        if (id == "xml") {
            respond (Annonce.list (), formats: ['xml']);
        }
        if (id == "json") {
            respond (Annonce.list (), formats: ['json']);
        }
        respond (Annonce.list (), formats: ['xml', 'json']);
    }

    def illustration (String id) {
        if (id == "xml") {
            respond (Illustration.list (), formats: ['xml']);
        }
        if (id == "json") {
            respond (Illustration.list (), formats: ['json']);
        }
        respond (Illustration.list (), formats: ['xml', 'json']);
    }

    def user (String id) {
        if (id == "xml") {
            respond (User.list (), formats: ['xml']);
        }
        if (id == "json") {
            respond (User.list (), formats: ['json']);
        }
        respond (User.list (), formats: ['xml', 'json']);
    }
}
