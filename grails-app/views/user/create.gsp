<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main" />
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
                                <h2 class="page-section-heading text-center text-uppercase text-secondary mb-4">Inscription</h2>
                                <!-- Icon Divider-->
                                <div class="divider-custom">
                                    <div class="divider-custom-line"></div>
                                    <div class="divider-custom-icon"><i class="fas fa-star"></i></div>
                                    <div class="divider-custom-line"></div>
                                </div>
                                <!-- Contact Section Form-->
                                <div class="row justify-content-center">
                                    <div class="col-lg-8 col-xl-7">
                                        <g:form data-sb-form-api-token="API_TOKEN" method="post" controller="user" action="save">
                                            <!-- Pseudo input-->
                                            <div class="form-floating mb-3">
                                                <input required id="username" name="username" class="form-control" type="text" placeholder="Renseignez votre pseudo" data-sb-validations="required" />
                                                <label for="username">Pseudo</label>
                                                <div class="invalid-feedback" data-sb-feedback="name:required">Renseignez votre pseudo</div>
                                            </div>
                                            <!-- Password input-->
                                            <div class="form-floating mb-3">
                                                <input required id="password1" name="password" class="form-control" type="password" data-sb-validations="required" />
                                                <label for="password1">Password</label>
                                            </div>
                                            <div class="form-floating mb-3">
                                                <input required id="password2" name="validation_password" class="form-control" type="password" data-sb-validations="required" />
                                                <label for="password2">Validation du Password</label>
                                            </div>
                                            <!-- Submit Button-->
                                            <input type="submit" name="incription" value="S'inscrire" class="btn btn-primary btn-xl" id="submitButton">
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
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
