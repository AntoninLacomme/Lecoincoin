package lecoincoin

import grails.gorm.transactions.NotTransactional
import grails.gorm.transactions.Transactional

import org.springframework.web.multipart.support.StandardMultipartHttpServletRequest.StandardMultipartFile;

@Transactional
class Illustration_file_Service {

    @NotTransactional
    def uploadFile (path, file) {
        return this.uploadFile(path, [file]);
    }

    @NotTransactional
    def uploadFile (path, List<StandardMultipartFile> files) {
        println(files);
        def list_illustrations = [];
            files.each {
                file ->
                    // attention cet idiot peu nous refiler des fichiers vide '-'
                    if (file.getBytes().size() > 0) {
                        String name_file = System.currentTimeMillis() + "_" + new Random().nextInt(100) + "_" +
                                file.getOriginalFilename()
                                        .replaceAll(" ", "")
                                        .toUpperCase();

                        String unique_path = path + name_file;
                        file.transferTo(new File(unique_path));

                        list_illustrations.push(this.saveFileInBDD(name_file));
                    }
            }
        return list_illustrations;
    }

    @Transactional
    def saveFileInBDD (name_file) {
        // la sauvegarde s'effectue en cascade par la sauvegarde de l'article dont elle est dépendante
        return new Illustration (filename: name_file);
    }

    @NotTransactional
    def dropIllustrations (path, listIllustration) {
        listIllustration.each {
            println(path + it.filename);
            def file = new File (path + it.filename);
            println(file);
            file.delete();
        }
        Illustration.deleteAll (listIllustration);
    }
}
