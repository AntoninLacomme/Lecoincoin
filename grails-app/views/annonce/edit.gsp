<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'annonce.label', default: 'Annonce')}" />
        <title><g:message code="default.edit.label" args="[entityName]" /></title>
        <asset:link rel="stylesheet" href="img_css.css" />
        <script src="https://use.fontawesome.com/releases/v5.15.3/js/all.js" crossorigin="anonymous"></script>
        <link href="https://fonts.googleapis.com/css?family=Montserrat:400,700" rel="stylesheet" type="text/css" />
        <link href="https://fonts.googleapis.com/css?family=Lato:400,700,400italic,700italic" rel="stylesheet" type="text/css" />
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
                                    <h2 class="page-section-heading text-center text-uppercase text-secondary mb-4">Mise à jour de l'Annonce</h2>
                                    <!-- Contact Section Form-->
                                    <div class="row justify-content-center">
                                        <div class="col-lg-8 col-xl-7">
                                            <g:form id="contactForm" data-sb-form-api-token="API_TOKEN" controller="annonce" action="update" method="POST" enctype="multipart/form-data">
                                                <input hidden name="ID" value="${this.annonce.id}"></input>
                                                <!-- Title input-->
                                                <div class="form-floating mb-3">
                                                    <input id="title" name="title" value="${this.annonce.title}" class="form-control" type="text" placeholder="Titre de l'Annonce" data-sb-validations="required" />
                                                    <label for="title">Titre de l'Annonce</label>
                                                    <div class="invalid-feedback" data-sb-feedback="name:required">Un titre est requis !</div>
                                                </div>
                                                <!-- Price input-->
                                                <div class="form-floating mb-3">
                                                    <input id="price" name="price" value="${this.annonce.price}"  class="form-control" type="number" placeholder="Prix de l'annonce (optionnel)" />
                                                    <label for="price">Prix de l'annonce (optionnel)</label>
                                                </div>
                                                <!-- Description input-->
                                                <div class="form-floating mb-3">
                                                    <textarea id="description" name="description" class="form-control" type="text" placeholder="Description" style="height: 10rem" data-sb-validations="required">${this.annonce.description}</textarea>
                                                    <label for="description">Description</label>
                                                    <div class="invalid-feedback" data-sb-feedback="message:required">Une description est nécessaire !</div>
                                                </div>
                                                <div class="form-floating mb-3">
                                                    <input class="form-control" id="images" type="file" name="image" accept="image/*" multiple>
                                                    <label for="images">Ajouter Images (optionnelles)</label>
                                                </div>

                                                <div class="form-floating mb-3">
                                                    <div>
                                                        <label for="images">Supprimer Images (optionnelles)</label>
                                                    </div>
                                                    <g:if test="${annonce.images.size() > 0}">
                                                        <table>
                                                            <g:each  var="image" in="${annonce.images}">
                                                                <tr>
                                                                    <td>
                                                                        <table>
                                                                            <tr>
                                                                                <td>
                                                                                    <input type="checkbox" id="${image.filename}" name="imageToSupp" value="${image.id}">
                                                                                </td>
                                                                                <td>
                                                                                    <!-- Portfolio Item 1-->
                                                                                    <div class="col-md-6 col-lg-4 mb-5">
                                                                                        <div class="portfolio-item mx-auto" data-bs-toggle="modal" data-bs-target="#portfolioModal${image.id}">
                                                                                            <asset:image class="img_zoom1" src="${pathImg}${image.filename}"></asset:image>
                                                                                        </div>
                                                                                    </div>
                                                                                </td>
                                                                            </tr>
                                                                        </table>
                                                                    </td>
                                                                </tr>
                                                            </g:each>
                                                        </table>
                                                    </g:if>
                                                </div>
                                                <!-- This is what your users will see when there is-->
                                                <!-- an error submitting the form-->
                                                <div class="d-none" id="submitErrorMessage"><div class="text-center text-danger mb-3">Error sending message!</div></div>
                                                <!-- Submit Button-->
                                                <input type="submit" name="create" value="Mettre à Jour" class="btn btn-primary btn-xl" id="submitButton">
                                            </g:form>
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


<g:each  var="image" in="${annonce.images}">
    <div class="portfolio-modal modal fade" id="portfolioModal${image.id}" tabindex="-1" aria-labelledby="portfolioModal${image.id}" aria-hidden="true">
        <div class="modal-dialog modal-xl">
            <div class="modal-content">
                <div class="modal-header border-0"><button class="btn-close" type="button" data-bs-dismiss="modal" aria-label="Close"></button></div>
                <div class="modal-body text-center pb-5">
                    <div class="container">
                        <div class="row justify-content-center">
                            <div class="col-lg-8">
                                <!-- Portfolio Modal - Image-->
                                <asset:image class="img_zoom2" src="${pathImg}${image.filename}"></asset:image>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</g:each>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
