package lecoincoin

class Annonce {

    String title;
    String description;
    Float price;
    Date dateCreated;
    Date lastUpdated;

    static hasMany = [images: Illustration];
    static belongsTo = [author: User];

    static constraints = {
        title nullable: false, blank: false, size: 4..50;
        description nullable: false, blank: false, size: 1..255;
        price nullable: true;
        images maxSize: 5;
    }
}
