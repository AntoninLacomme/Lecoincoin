<!doctype html>
    <html lang="fr" class="no-js">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
        <title>
            <g:layoutTitle default="LeWoufWouf"/>
        </title>

        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <link href="https://cdn.jsdelivr.net/npm/simple-datatables@latest/dist/style.css" rel="stylesheet" />
        <asset:stylesheet src="styles.css"/>
        <asset:link rel="icon" href="favicon.ico" type="image/x-ico" />
        <asset:stylesheet src="application.css"/>

        <g:layoutHead/>
    </head>
    <body>
        <div class="navbar navbar-default navbar-static-top" role="navigation">
                <div class="navbar-collapse collapse" aria-expanded="false" style="height: 0.8px;">
                    <div class="nav-main-login">
                        <sec:ifLoggedIn>
                                <div class="nav-login">
                                <form method="POST" action="/logout">
                                    <div class="sb-sidenav-footer">
                                        <div class="small">Logged in as:
                                            <sec:username></sec:username>
                                        </div>
                                    </div>
                                    <g:field type="submit" name="deconnection" value="${g.message(code: "message.deconnection")}"/>
                                </form>
                                </div>
                        </sec:ifLoggedIn>
                        <sec:ifNotLoggedIn>
                            <div class="nav-login">
                                <g:form controller="user" action="create" method="GET">
                                    <g:field class="button" type="submit" name="login" value="S'inscrire"/>
                                </g:form>
                            </div>
                                <div class="nav-login">
                                    <g:form controller="login" action="auth" method="POST">
                                        <g:field class="button" type="submit" name="login" value="${g.message(code: "message.connection")}"/>
                                    </g:form>
                                </div>
                        </sec:ifNotLoggedIn>
                    </div>
                </div>
                <a href="/#">

                    <asset:image class="main-logo-lecoincoin" src="logoLewoufwouf.svg" alt="LeWoufWouf Logo"/>
                    <%--<asset:image class="main-logo-lecoincoin" src="banniere_lecoincoin.png" alt="LeCoinCoin Logo"/>--%>
                </a>
        </div>

    <div id="mainBody">
    <span class="main-block main-block-list" id="layoutSidenav">
        <sec:ifLoggedIn>
        <div id="layoutSidenav_nav">
            <nav class="sb-sidenav accordion sb-sidenav-dark" id="sidenavAccordion">
                <div class="sb-sidenav-menu">
                    <div class="nav">
                        <div class="sb-sidenav-menu-heading">LeCoinCoin</div>
                        <a class="nav-link collapsed" href="#" data-bs-toggle="collapse" data-bs-target="#collapesProfil" aria-expanded="false" aria-controls="collapesProfil">
                            <div class="sb-nav-link-icon"><i class="fas fa-columns"></i></div>
                            Profil
                            <div class="sb-sidenav-collapse-arrow"><i class="fas fa-angle-down"></i></div>
                        </a>
                        <div class="collapse" id="collapesProfil" aria-labelledby="headingOne" data-bs-parent="#sidenavAccordion">
                            <nav class="sb-sidenav-menu-nested nav">
                                <g:link class="nav-link" controller="user" action="show" id="${sec.loggedInUserInfo(field:'id')}">Voir Profil</g:link>
                                <g:link class="nav-link" controller="user" action="edit" id="${sec.loggedInUserInfo(field:'id')}">Modifier Profil</g:link>
                            </nav>
                        </div>
                        <a class="nav-link collapsed" href="#" data-bs-toggle="collapse" data-bs-target="#collapseAnnonce" aria-expanded="false" aria-controls="collapseAnnonce">
                            <div class="sb-nav-link-icon"><i class="fas fa-book-open"></i></div>
                            Annonces
                            <div class="sb-sidenav-collapse-arrow"><i class="fas fa-angle-down"></i></div>
                        </a>
                        <div class="collapse" id="collapseAnnonce" aria-labelledby="headingTwo" data-bs-parent="#sidenavAccordion">
                            <nav class="sb-sidenav-menu-nested nav">
                                <g:link class="nav-link" controller="annonce" action="index" id="${sec.loggedInUserInfo(field:'id')}">Mes Annonces</g:link>
                                <g:link class="nav-link" controller="annonce" action="create">Ajouter Annonces</g:link>
                            </nav>
                        </div>
                    </div>
                    <sec:ifAnyGranted roles="ROLE_ADMIN, ROLE_MODERATOR">
                        <div class="nav">
                            <div class="sb-sidenav-menu-heading">Administration</div>
                            <a class="nav-link collapsed" href="#" data-bs-toggle="collapse" data-bs-target="#collapseUsers" aria-expanded="false" aria-controls="collapseUsers">
                                <div class="sb-nav-link-icon"><i class="fas fa-columns"></i></div>
                                Utilisateurs
                                <div class="sb-sidenav-collapse-arrow"><i class="fas fa-angle-down"></i></div>
                            </a>
                            <div class="collapse" id="collapseUsers" aria-labelledby="headingOne" data-bs-parent="#sidenavAccordion">
                                <nav class="sb-sidenav-menu-nested nav">
                                    <g:link class="nav-link" controller="user" action="index">Les Utilisateurs</g:link>
                                </nav>
                            </div>
                            <a class="nav-link collapsed" href="#" data-bs-toggle="collapse" data-bs-target="#collapseAllAnnonces" aria-expanded="false" aria-controls="collapseAllAnnonces">
                                <div class="sb-nav-link-icon"><i class="fas fa-book-open"></i></div>
                                Annonces
                                <div class="sb-sidenav-collapse-arrow"><i class="fas fa-angle-down"></i></div>
                            </a>
                            <div class="collapse" id="collapseAllAnnonces" aria-labelledby="headingTwo" data-bs-parent="#sidenavAccordion">
                                <nav class="sb-sidenav-menu-nested nav">
                                    <g:link class="nav-link" controller="annonce" action="index">Les Annonces</g:link>
                                </nav>
                            </div>
                        </div>
                    </sec:ifAnyGranted>
            </nav>
        </div>
</sec:ifLoggedIn>
    </span>
    <span class="main-block main-block-body">
        <div>
            <div id="layoutSidenav_content">
                <main>
        <g:layoutBody/>
                </main>
            </div>
        </div>

    </span>
    </div>

        <div class="footer" role="contentinfo"></div>

        <div id="spinner" class="spinner" style="display:none;">
            <g:message code="spinner.alt" default="Loading&hellip;"/>
        </div>

        <asset:javascript src="application.js"/>

    <footer class="py-4 bg-light mt-auto">
        <div class="container-fluid px-4">
            <div class="d-flex align-items-center justify-content-between small">
                <div class="text-muted">Copyright &copy; LeCoinCoin 2021</div>
                <div>
                    <a href="#">Privacy Policy</a>
                    &middot;
                    <a href="#">Terms &amp; Conditions</a>
                </div>
            </div>
        </div>
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.0/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>

    </body>
    </html>
