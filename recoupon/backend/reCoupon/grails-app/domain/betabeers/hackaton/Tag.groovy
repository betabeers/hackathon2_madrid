package betabeers.hackaton

class Tag {
	String tagID 
	static belongsTo = [coupon: Coupon]

	static constraints = {
		tagID unique: true
	}
}