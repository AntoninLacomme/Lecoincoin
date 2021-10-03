<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'annonce.label', default: 'Annonce')}" />
    </head>
    <body class="sb-nav-fixed">
    <div id="layoutSidenav">
        <div id="layoutSidenav_content">
            <main>
                <div class="container-fluid px-4">
                    <div class="card mb-4">
                        <div class="card-header">
                            <i class="fas fa-table me-1"></i>
                            Utilisateurs
                        </div>
                        <div class="card-body">
                            <table id="datatablesSimple">
                                <thead>
                                <tr>
                                    <th>Auteur</th>
                                    <th>Annonce</th>
                                    <th>Date de Création</th>
                                    <th>Dernière Mise à Jour</th>
                                    <th></th>
                                </tr>
                                </thead>
                                <tfoot>
                                <tr>
                                    <th>Auteur</th>
                                    <th>Annonce</th>
                                    <th>Date de Création</th>
                                    <th>Dernière Mise à Jour</th>
                                    <th></th>
                                </tr>
                                </tfoot>

                                <tbody>
                                <g:each var="annonce" in="${annonceList}">
                                    <tr>
                                        <td>
                                            <g:link controller="user" action="show" id="${annonce.author.id}">
                                                ${annonce.author.username}
                                            </g:link>
                                        </td>
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
                                    <g:if test="${annonce.author.id == user.id || userRights == 'ROLE_ADMIN'}">
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
            </main>
        </div>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/simple-datatables@latest" crossorigin="anonymous"></script>
    </body>
</html>