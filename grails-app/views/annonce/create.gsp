<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'annonce.label', default: 'Annonce')}" />
        <title><g:message code="default.create.label" args="[entityName]" /></title>
    </head>
    <body>
    <div id="layoutSidenav">
        <div id="layoutSidenav_content">
            <main>
                <div class="container-fluid px-4">
                    <div class="card mb-4">
                        <div class="card-body">
                            <section class="page-section" id="contact">
                                <div class="container">
                                    <!-- Contact Section Heading-->
                                    <h2 class="page-section-heading text-center text-uppercase text-secondary mb-4">Création Annonce</h2>
                                    <!-- Icon Divider-->
                                    <div class="divider-custom">
                                        <div class="divider-custom-line"></div>
                                        <div class="divider-custom-icon"><i class="fas fa-star"></i></div>
                                        <div class="divider-custom-line"></div>
                                    </div>
                                    <!-- Contact Section Form-->
                                    <div class="row justify-content-center">
                                        <div class="col-lg-8 col-xl-7">
                                            <form id="contactForm" data-sb-form-api-token="API_TOKEN" action="/annonce/save" method="post" enctype="multipart/form-data">
                                                <!-- Title input-->
                                                <div class="form-floating mb-3">
                                                    <input id="title" name="title" class="form-control" type="text" placeholder="Titre de l'Annonce" data-sb-validations="required" />
                                                    <label for="title">Titre de l'Annonce</label>
                                                    <div class="invalid-feedback" data-sb-feedback="name:required">Un titre est requis !</div>
                                                </div>
                                                <!-- Price input-->
                                                <div class="form-floating mb-3">
                                                    <input id="price" name="price" class="form-control" type="number" placeholder="Prix de l'annonce (optionnel)" />
                                                    <label for="price">Prix de l'annonce (optionnel)</label>
                                                </div>
                                                <!-- Description input-->
                                                <div class="form-floating mb-3">
                                                    <textarea id="description" name="description" class="form-control" type="text" placeholder="Description" style="height: 10rem" data-sb-validations="required"></textarea>
                                                    <label for="description">Description</label>
                                                    <div class="invalid-feedback" data-sb-feedback="message:required">Une description est nécessaire !</div>
                                                </div>
                                                <div class="form-floating mb-3">
                                                    <input class="form-control" name="image" id="images" type="file" name="image" accept="image/*" multiple>
                                                    <label for="images">Images (optionnelles)</label>
                                                </div>
                                                <!-- This is what your users will see when there is-->
                                                <!-- an error submitting the form-->
                                                <div class="d-none" id="submitErrorMessage"><div class="text-center text-danger mb-3">Error sending message!</div></div>
                                                <!-- Submit Button-->
                                                <input type="submit" name="create" value="Valider Annonce" class="btn btn-primary btn-xl" id="submitButton">
                                            </form>
                                        </div>
                                    </div>
                                </div>
                            </section>
                        </div>
                    </div>
                </div>
            </main>
        </div>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
