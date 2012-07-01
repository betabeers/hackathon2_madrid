package betabeers.hackaton
import groovy.json.JsonSlurper
import groovy.json.*

//Attention: you have to use double quotes inside the json string
class YunaitService {
	def grailsApplication
    def YUNAIT_DATEFORMAT= 'yyyy-M-d H:m:s'
	def REST_URL = 'http://www.yunait.com/rest/'
    def ITEMS_PER_PAGE = 20

    def populateDatabase() {
    	def yunaitKey = grailsApplication.config.yunait.apikey
    	def path = 'deals/in?lat=40.396764&lng=-3.713379&format=json'
        def jsonSlurper = new JsonSlurper()
    	def jsonObject = jsonSlurper.parseText(new URL(REST_URL + path + '&key='+ yunaitKey).text)
    	//def prettyJson = JsonOutput.prettyPrint(rsp)
        def total = jsonObject.total
        println "Retrieving ${total} Yunait Entries. Go for a cup of coffee, this is gonna take a while..." 
        for(int page = 0; (page + ITEMS_PER_PAGE) < total; page++) {
            try {
                println "Retrieving Yunait Page ..." + page
                path = "deals/in?lat=40.396764&lng=-3.713379&format=json&page=${page}"
                println "URL: " + REST_URL + path + '&key='+ yunaitKey
                jsonObject = jsonSlurper.parseText(new URL(REST_URL + path + '&key='+ yunaitKey).text)
                jsonObject.data.each { offer ->
                    def coupon = new Coupon([
                        yunaitURL: offer.url,
                        yunaitID: offer.id,
                        categoryId: offer.category_id, 
                        categoryName: offer.category_name, 
                        startDate: Date.parse(YUNAIT_DATEFORMAT,offer.start_date), 
                        endDate: Date.parse(YUNAIT_DATEFORMAT,offer.end_date),
                        valid_date: Date.parse(YUNAIT_DATEFORMAT,offer.valid_date),
                        originalPrice: offer.original_price, 
                        price: offer.price, 
                        discount: offer.discount,
                        title: offer.title, 
                        description: offer.description,
                        city: offer.city, 
                        address: offer.address, 
                        phone: offer.phone, 
                        bussiness: offer.bussiness, 
                        publishDate:  Date.parse(YUNAIT_DATEFORMAT,offer.publish_date),
                        keywords: offer.keywords, 
                        partner: offer.partner, 
                        image: offer.image,
                        favicon: offer.favicon, 
                        latitude: offer.latitude, 
                        longitude: offer.longitude]).save([failOnError: true])]
                }
            } catch(java.lang.StackOverflowError e) {
                    println jsonObject
            }
        } 
    }
}