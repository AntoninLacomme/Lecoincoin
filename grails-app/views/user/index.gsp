<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'user.label', default: 'User')}" />
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
                                        <g:each var="attr" in="${userList.get(0).keySet()}">
                                            <g:if test="${accessRestricted[accessRestricted["SELF_ACCESS"]] == null}">
                                                <g:if test="${attr != 'id'}">
                                                    <th>${attr}</th>
                                                </g:if>
                                            </g:if>
                                            <g:if test="${accessRestricted[accessRestricted["SELF_ACCESS"]] != null}">
                                                <g:if test="${accessRestricted[accessRestricted["SELF_ACCESS"]].contains(attr)}">
                                                    <g:if test="${attr != 'id'}">
                                                        <th>${attr}</th>
                                                    </g:if>
                                                </g:if>
                                            </g:if>
                                        </g:each>
                                        <g:if test="${userRights == 'ROLE_ADMIN'}">
                                            <th></th>
                                        </g:if>
                                    </tr>
                                </thead>
                                <tfoot>
                                    <tr>
                                        <g:each var="attr" in="${userList.get(0).keySet()}">
                                            <g:if test="${accessRestricted[accessRestricted["SELF_ACCESS"]] == null}">
                                                <g:if test="${attr != 'id'}">
                                                    <th>${attr}</th>
                                                </g:if>
                                            </g:if>
                                            <g:if test="${accessRestricted[accessRestricted["SELF_ACCESS"]] != null}">
                                                <g:if test="${accessRestricted[accessRestricted["SELF_ACCESS"]].contains(attr)}">
                                                    <g:if test="${attr != 'id'}">
                                                        <th>${attr}</th>
                                                    </g:if>
                                                </g:if>
                                            </g:if>
                                        </g:each>
                                        <g:if test="${userRights == 'ROLE_ADMIN'}">
                                            <th></th>
                                        </g:if>
                                    </tr>
                                </tfoot>
                                <tbody>
                                    <g:each var="user" in="${userList}">
                                        <tr>
                                            <g:each var="attr" in="${user.keySet()}">
                                                <g:if test="${accessRestricted[accessRestricted["SELF_ACCESS"]] == null}">
                                                    <g:if test="${attr == 'Utilisateur'}">
                                                        <td>
                                                            <g:link class="nav-link" controller="user" action="show" id="${user.id}">${user[attr]}</g:link>
                                                        </td>
                                                    </g:if>
                                                    <g:else>
                                                        <g:if test="${attr != 'id'}">
                                                            <td>${user[attr]}</td>
                                                        </g:if>
                                                    </g:else>
                                                </g:if>

                                                <g:if test="${accessRestricted[accessRestricted["SELF_ACCESS"]] != null}">
                                                    <g:if test="${accessRestricted[accessRestricted["SELF_ACCESS"]].contains(attr) && (attr != 'id')}">
                                                        <g:if test="${attr == 'Utilisateur'}">
                                                        <td>
                                                            <g:link class="nav-link" controller="user" action="show" id="${user.id}">${user[attr]}</g:link>
                                                        </td>
                                                    </g:if>
                                                        <g:else>
                                                            <g:if test="${attr != 'id'}">
                                                                <td>${user[attr]}</td>
                                                            </g:if>
                                                        </g:else>
                                                    </g:if>
                                                </g:if>
                                            </g:each>
                                            <g:if test="${userRights == 'ROLE_ADMIN'}">
                                                <td>
                                                    <g:form onsubmit="return confirm('Voulez vous vraiment supprimer ce compte ?');" data-sb-form-api-token="API_TOKEN" controller="user" action="delete" id="${user.id}" method="DELETE">
                                                        <input type="submit" value="Supprimer" class="btn btn-primary btn-xl">
                                                    </g:form>
                                                </td>
                                            </g:if>
                                        </tr>
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