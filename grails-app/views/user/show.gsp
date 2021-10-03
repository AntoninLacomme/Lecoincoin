<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main" />
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
                                <h2 class="page-section-heading text-center text-uppercase text-secondary mb-4">Mon Profil</h2>
                                <!-- Icon Divider-->
                                <div class="divider-custom">
                                    <div class="divider-custom-line"></div>
                                    <div class="divider-custom-icon"><i class="fas fa-star"></i></div>
                                    <div class="divider-custom-line"></div>
                                </div>
                                <!-- Contact Section Form-->
                                <div class="row justify-content-center">
                                    <div class="col-lg-8 col-xl-7">
                                        <div class="form-floating mb-3">
                                            <input id="username" readonly name="username" value="${user.username}" class="form-control" type="text" />
                                            <label for="username">Pseudo</label>
                                        </div>
                                    </div>
                                        <g:if test="${userAnnonces.size() > 0}">
                                            <div class="container-fluid px-4">
                                                <div class="card mb-4">
                                                    <div class="card-header">
                                                        <i class="fas fa-table me-1"></i>
                                                        Annonces
                                                    </div>
                                                    <div class="card-body">

                                                        <table id="datatablesSimple">
                                                            <thead>
                                                            <tr>
                                                                <th>Annonce</th>
                                                                <th>Date de Création</th>
                                                                <th>Dernière Mise à Jour</th>
                                                                <th></th>
                                                            </tr>
                                                            </thead>
                                                            <tbody>
                                                            <g:each var="annonce" in="${userAnnonces}">
                                                                <tr>
                                                                    <td>
                                                                        <div>
                                                                            <div>
                                                                                <g:link controller="annonce" action="show" id="${annonce.id}">
                                                                                    ${annonce.title}
                                                                                </g:link>
                                                                            </div>
                                                                            <div>
                                                                                ${annonce.description}
                                                                            </div>
                                                                        </div>
                                                                    </td>
                                                                    <td>
                                                                        ${annonce.dateCreated}
                                                                    </td>
                                                                    <td>
                                                                        ${annonce.lastUpdated}
                                                                    </td><td>
                                                                    <g:if test="${annonce.author.id == userCurrentId || userRights == 'ROLE_ADMIN'}">
                                                                        <g:link class="btn btn-primary btn-xl" controller="annonce" action="edit" id="${annonce.id}">Editer</g:link>

                                                                        <g:form onsubmit="return confirm('Voulez vous vraiment supprimer cette annonce ?');" data-sb-form-api-token="API_TOKEN" controller="annonce" action="delete" id="${annonce.id}" method="DELETE">
                                                                            <input type="submit" value="Supprimer" class="btn btn-primary btn-xl">
                                                                        </g:form>

                                                                    </g:if>
                                                                </td></tr>

                                                            </g:each>
                                                            </tbody>
                                                        </table>

                                                    </div>
                                                </div>
                                            </div>
                                    </g:if>
                                    <g:else>
                                        <div>
                                            Aucune annonce n'a été posté à l'heure actuelle
                                        </div>
                                    </g:else>
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
