package betabeers.hackaton

class Coupon {

	int requiredScans
	String yunaitID 
	String yunaitURL
	int categoryId
	String categoryName
	Date startDate
	Date endDate
	Date valid_date
	double originalPrice
	double price
	double discount
	String title
	String description
	String city
	String address
	String phone
	String bussiness
	Date publishDate
	String keywords
	String partner
	String image
	String favicon
	String latitude
	String longitude
	String name

	static hasMany = [tags: Tag]

	static mapping = {
    	description type: 'text'
    	bussiness type: 'text'
    }

    static constraints = {
    	yunaitID  nullable: true
		yunaitURL nullable: true
		categoryId nullable: true
		categoryName nullable: true
		startDate nullable: true
		endDate nullable: true
		valid_date nullable: true
	 	originalPrice nullable: true
	 	price nullable: true
	 	discount nullable: true
	 	title nullable: true
	 	description nullable: true
	 	city nullable: true
	 	address nullable: true
	 	phone nullable: true
	 	bussiness nullable: true
	 	publishDate nullable: true
	 	keywords nullable: true
	 	partner nullable: true
	 	image nullable: true
	 	favicon nullable: true
	 	latitude nullable: true
	 	longitude nullable: true
	 	name nullable: true
    }
}
