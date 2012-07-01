package betabeers.hackaton



import org.junit.*
import grails.test.mixin.*

@TestFor(CouponController)
@Mock(Coupon)
class CouponControllerTests {


    def populateValidParams(params) {
      assert params != null
      // TODO: Populate valid properties like...
      //params["name"] = 'someValidName'
    }

    void testIndex() {
        controller.index()
        assert "/coupon/list" == response.redirectedUrl
    }

    void testList() {

        def model = controller.list()

        assert model.couponInstanceList.size() == 0
        assert model.couponInstanceTotal == 0
    }

    void testCreate() {
       def model = controller.create()

       assert model.couponInstance != null
    }

    void testSave() {
        controller.save()

        assert model.couponInstance != null
        assert view == '/coupon/create'

        response.reset()

        populateValidParams(params)
        controller.save()

        assert response.redirectedUrl == '/coupon/show/1'
        assert controller.flash.message != null
        assert Coupon.count() == 1
    }

    void testShow() {
        controller.show()

        assert flash.message != null
        assert response.redirectedUrl == '/coupon/list'


        populateValidParams(params)
        def coupon = new Coupon(params)

        assert coupon.save() != null

        params.id = coupon.id

        def model = controller.show()

        assert model.couponInstance == coupon
    }

    void testEdit() {
        controller.edit()

        assert flash.message != null
        assert response.redirectedUrl == '/coupon/list'


        populateValidParams(params)
        def coupon = new Coupon(params)

        assert coupon.save() != null

        params.id = coupon.id

        def model = controller.edit()

        assert model.couponInstance == coupon
    }

    void testUpdate() {
        controller.update()

        assert flash.message != null
        assert response.redirectedUrl == '/coupon/list'

        response.reset()


        populateValidParams(params)
        def coupon = new Coupon(params)

        assert coupon.save() != null

        // test invalid parameters in update
        params.id = coupon.id
        //TODO: add invalid values to params object

        controller.update()

        assert view == "/coupon/edit"
        assert model.couponInstance != null

        coupon.clearErrors()

        populateValidParams(params)
        controller.update()

        assert response.redirectedUrl == "/coupon/show/$coupon.id"
        assert flash.message != null

        //test outdated version number
        response.reset()
        coupon.clearErrors()

        populateValidParams(params)
        params.id = coupon.id
        params.version = -1
        controller.update()

        assert view == "/coupon/edit"
        assert model.couponInstance != null
        assert model.couponInstance.errors.getFieldError('version')
        assert flash.message != null
    }

    void testDelete() {
        controller.delete()
        assert flash.message != null
        assert response.redirectedUrl == '/coupon/list'

        response.reset()

        populateValidParams(params)
        def coupon = new Coupon(params)

        assert coupon.save() != null
        assert Coupon.count() == 1

        params.id = coupon.id

        controller.delete()

        assert Coupon.count() == 0
        assert Coupon.get(coupon.id) == null
        assert response.redirectedUrl == '/coupon/list'
    }
}
