import groovy.sql.Sql
import groovy.json.JsonSlurper
import groovy.json.*

def YUNAIT_DATEFORMAT= 'yyyy-M-d H:m:s'
def REST_URL = 'http://www.yunait.com/rest/'
def ITEMS_PER_PAGE = 20
def yunaitKey = '484f3ccc716c2d25069b416ce0cabedd6fc54572'

def driverClassName = "com.mysql.jdbc.Driver"
def username = "root"
def password = ""
def url = "jdbc:mysql://localhost/recoupon2"


def connection = Sql.newInstance(url, username, password, driverClassName)
def stmt = 'INSERT INTO coupon (version, address, bussiness, category_id, category_name, city, description, discount, end_date, favicon, image, keywords, latitude, longitude, name, original_price, partner, phone, price, publish_date, start_date, title, valid_date, yunaitid, yunaiturl, required_scans) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)'

def path = 'deals/in?lat=40.396764&lng=-3.713379&format=json'
def jsonSlurper = new JsonSlurper()
def jsonObject = jsonSlurper.parseText(new URL(REST_URL + path + '&key='+ yunaitKey).text)
def total = jsonObject.total
for(int page = 0; (page + ITEMS_PER_PAGE) < total; page++) {
    try {


    println "Page ..." + page
    path = "deals/in?lat=40.396764&lng=-3.713379&format=json&page=${page}"
    println "URL: " + REST_URL + path + '&key='+ yunaitKey
    jsonObject = jsonSlurper.parseText(new URL(REST_URL + path + '&key='+ yunaitKey).text)
    jsonObject.data.each { offer ->
        connection.execute stmt, [0, offer.address, offer.bussiness, offer.category_id, offer.category_name, offer.city, offer.description, offer.discount, Date.parse(YUNAIT_DATEFORMAT,offer.end_date), offer.favicon, offer.image, offer.keywords, offer.latitude, offer.longitude, offer.name, offer.original_price, offer.partner, offer.phone, offer.price, Date.parse(YUNAIT_DATEFORMAT,offer.publish_date), Date.parse(YUNAIT_DATEFORMAT,offer.start_date), offer.title, Date.parse(YUNAIT_DATEFORMAT,offer.valid_date), offer.id, offer.url, 3]
    }
    } catch (java.lang.StackOverflowError e ) {
            println jsonObject
        }
}