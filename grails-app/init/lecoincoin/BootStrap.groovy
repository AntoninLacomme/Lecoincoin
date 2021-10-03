package lecoincoin

class BootStrap {

    def init = { servletContext ->
        new BootStrapService ().launch();
    }
    def destroy = {
    }
}
