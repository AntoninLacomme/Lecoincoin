<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main" />
    <g:set var="entityName" value="${message(code: 'annonce.label', default: 'Annonce')}" />
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
                                <h2 class="page-section-heading text-center text-uppercase text-secondary mb-4">${this.annonce.title}</h2>
                                <!-- Contact Section Form-->
                                <div class="row justify-content-center">
                                    <div class="col-lg-8 col-xl-7">
                                        <g:link class="nav-link" controller="user" action="show" id="${this.annonce.author.id}">
                                            <div class="form-floating mb-3">
                                                <input class="form-control" type="text" readonly value="${this.annonce.author.username}" />
                                                <label for="price">Auteur</label>
                                            </div>
                                        </g:link>
                                        <g:if test="${this.annonce.price != null}">
                                        <div class="form-floating mb-3">
                                            <input id="price" name="price" value="${this.annonce.price}" readonly class="form-control" type="number" placeholder="Prix de l'annonce (optionnel)" />
                                            <label for="price">Prix de l'annonce</label>
                                        </div>
                                        </g:if>
                                        <!-- Description input-->
                                        <div class="form-floating mb-3">
                                            <p>${this.annonce.description}</p>
                                        </div>
                                        <div>
                                            <g:if test="${annonce.images.size() > 0}">
                                                <section class="page-section portfolio" id="portfolio">
                                                    <div class="container">
                                                    <g:each  var="image" in="${annonce.images}">
                                                        <div class="col-md-6 col-lg-4 mb-5 mb-lg-0">
                                                            <div class="portfolio-item mx-auto" data-bs-toggle="modal" data-bs-target="#portfolioModal${image.id}">
                                                                <asset:image class="img_zoom1" src="${pathImg}${image.filename}"></asset:image>
                                                            </div>
                                                        </div>
                                                    </g:each>
                                                </div>
                                                </section>
                                            </g:if>
                                        </div>
                                        <div>
                                            <g:if test="${this.annonce.author.id == user.id || userRights == 'ROLE_ADMIN'}">
                                                <g:link class="btn btn-primary btn-xl" controller="annonce" action="edit" id="${annonce.id}">Editer</g:link>
                                                <g:form onsubmit="return confirm('Voulez vous vraiment supprimer cette annonce ?');" data-sb-form-api-token="API_TOKEN" controller="annonce" action="delete" id="${annonce.id}" method="DELETE">
                                                    <input type="submit" name="delete" value="Supprimer" class="btn btn-primary btn-xl">
                                                </g:form>
                                            </g:if>
                                            </div>
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

