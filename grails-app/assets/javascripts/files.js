window.onload = () => {
    try {
        document.querySelector("#contactForm").addEventListener("submit", (e) => {
            //e.preventDefault();
            let iptFiles = document.querySelector("#images");

            if (document.querySelector("#title").value.length < 3) {
                alert("Le titre de votre article doit faire au moins 3 charactères !");
                return false;
            }

            if (document.querySelector("#description").value.length < 3) {
                alert("La description de votre article doit faire au moins 3 charactères !");
                return false;
            }

            if (iptFiles.files > 5) {
                alert("Vous ne pouvez enregistrer que 5 images maximum pour un article !");
                return false;
            }

            let maxByteSize = 200000000;
            let cByteSize = 0;

            for (let i = 0; i < iptFiles.length; i++) {
                cByteSize += iptFiles[i].size;
            }

            if (cByteSize > maxByteSize) {
                alert("Taille de fichier trop volumineuse pour le serveur !");
                return false;
            }
            return true;
        });
    } catch (e) { /* :D */ }

    try {
        document.querySelector("#contactForm2").addEventListener("submit", (e) => {

            let iptFiles = document.querySelector("#images");

            if (document.querySelector("#title").value.length < 3) {
                alert("Le titre de votre article doit faire au moins 3 charactères !");
                return false;
            }

            if (document.querySelector("#description").value.length < 3) {
                alert("La description de votre article doit faire au moins 3 charactères !");
                return false;
            }

            let nbFilesSupp = 0;
            var inputElements = document.getElementsByClassName('imageCheckbox');
            for (var i=0; inputElements[i].length; i++){
                if (inputElements[i].checked){
                    nbFilesSupp++
                }
            }

            if (iptFiles.files - nbFilesSupp > 5) {
                alert("Vous ne pouvez enregistrer que 5 images maximum pour un article !");
                return false;
            }

            let maxByteSize = 200000000;
            let cByteSize = 0;

            for (let i = 0; i < iptFiles.length; i++) {
                cByteSize += iptFiles[i].size;
            }

            if (cByteSize > maxByteSize) {
                alert("Taille de fichier trop volumineuse pour le serveur !");
                return false;
            }
            return true;
        });
    } catch (e) { /* :D */ }
}