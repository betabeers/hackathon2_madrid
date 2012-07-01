package betabeers.hackaton

import org.springframework.dao.DataIntegrityViolationException

class CouponController {
    def mailService
    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def demo() {
        def tags = Tag.list()
        tags.each { 
            def tag = Tag.get(it.id)
            tag.delete(flush: true)
        }

        def scans = Scan.list()
        scans.each {
            def scan = Scan.get(it.id)
            scan.delete(flush: true)
        }

        def cpId = '1021'
        def tagID = '1001'
        def couponInstance = Coupon.get(cpId)
        def tagInstance = new Tag(tagID: tagID)
        tagInstance.coupon = couponInstance
        tagInstance.save([flush: true, failOnError: true])
        
        cpId = '1051'
        tagID = '1002'
        couponInstance = Coupon.get(cpId)
        tagInstance = new Tag(tagID: tagID)
        tagInstance.coupon = couponInstance
        tagInstance.save([flush: true, failOnError: true])
    }

    def associateTag() {
        def couponInstance = Coupon.get(params.id)
        def tagInstance = Tag.findByTagID(params.tagID)
        if(!tagInstance) {
            tagInstance = new Tag(tagID: params.tagID)
        }
        tagInstance.coupon = couponInstance
        tagInstance.save([flush: true, failOnError: true])
        redirect(action: "show", id: couponInstance.id)
    }

    def list() {
        def bussiness = params.bussiness 
        if(bussiness) {
            def criteria = Coupon.createCriteria()
            def results = criteria.list(params) {
                 eq('bussiness', bussiness)
            }

            criteria = Coupon.createCriteria()
            def total = criteria.count() { 
                eq('bussiness', bussiness)            
            }

            params.max = Math.min(params.max ? params.int('max') : 10, 100)
            [couponInstanceList: results, couponInstanceTotal: total]
        } else {
               params.max = Math.min(params.max ? params.int('max') : 20, 100)
                [couponInstanceList: Coupon.list(params), couponInstanceTotal: Coupon.count()]
        }
    }

    def create() {
        [couponInstance: new Coupon(params)]
    }

    def save() {
        def couponInstance = new Coupon(params)
        if (!couponInstance.save(flush: true)) {
            render(view: "create", model: [couponInstance: couponInstance])
            return
        }

		flash.message = message(code: 'default.created.message', args: [message(code: 'coupon.label', default: 'Coupon'), couponInstance.id])
        redirect(action: "show", id: couponInstance.id)
    }

    def showTag() {
        def tagInstance = Tag.findByTagID(params.id)
        def couponInstance = Coupon.get(tagInstance.coupon.id)
        if (!couponInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'coupon.label', default: 'Coupon'), params.id])
            redirect(action: "list")
            return
        }

        render(view: 'show', model: [couponInstance: couponInstance])
    }

    def share() {
        def scan = Scan.get(params.scanId)
        def userInstance = User.findByUsername(params.email)
        def url = "http://195.235.111.101:8080/reCoupon/code/${scan.tag.tagID}/${userInstance.usercode}/?scanId=${scan.id}&output=html"
        sendMail {     
            from "sergio.delamo@softamo.com"
            to params.email
            subject "Corre Escanea el cupón"
            body "Pulsa el siguiente enlace para que logremos canjear el cupón para ${scan.coupon.title} \n\r\n\r ${url} \n\r\n\r recoupon rocks!"
        }
    }

    def code() {
     //   println "username: " + params.username
     //   println "tagId: " + params.tagID
     //   println "username: " + params.username
        def username = params.username
        def tagID = params.tagID
        def tagInstance = Tag.findByTagID(params.tagID)
        def couponInstance =(tagInstance!=null) ? Coupon.get(tagInstance.coupon.id) : null
        def userInstance= User.findByUsercode(params.username)
        def response = [:]
        response.data = [:]
        if(!tagInstance || !userInstance) {
            response.status = false
            if(!tagInstance) {
                response.data.msg = "No hay ningún Tag con el número ${params.tagID} en el sistema"
            }
            else if(!couponInstance) {
                response.data.msg = 'El Tag No esta asociado a ningún cupón'
            }
            else if(!userInstance) {
                response.data.msg = "No hay ningún usuario registrado en el sistema con el username ${params.username}"
            }
        } else { 
            response.status = true
            response.data.pic = couponInstance?.image
            response.data.name = couponInstance?.title
            response.data.uuid = couponInstance.id
            response.data.requiredScans = couponInstance.requiredScans
            def scan
            if(!params.scanId) {
                scan = new Scan([tag: tagInstance, coupon: couponInstance,user: userInstance, counter: 1])
                scan.save([flush: true])
            } else {
                scan = Scan.get(params.scanId)
                if(scan) {
                    scan.counter++
                }
                scan.save([flush: true])
            }
            response.data.counter = scan.counter
            response.data.scanId = scan.id
            if(couponInstance.requiredScans == scan.counter) {
                sendMail {     
                    from "sergio.delamo@softamo.com"
                    to userInstance.username
                    subject "REECupón Completado"
                    body "Enhorabuena has completado el cupón ${couponInstance?.title}. \n\r Para canjearlo utiliza este código ${scan.id}"
                }
            }
        }
        if(params.output == 'html') {
            redirect(action: "show", id: couponInstance.id)
        } else {
            render(contentType: "text/json") {
                response
            }    
        }
    }

    def show() {
        def couponInstance = Coupon.get(params.id)
        if (!couponInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'coupon.label', default: 'Coupon'), params.id])
            redirect(action: "list")
            return
        }

        [couponInstance: couponInstance, scans: Scan.findByCoupon(couponInstance)]
    }

    def edit() {
        def couponInstance = Coupon.get(params.id)
        if (!couponInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'coupon.label', default: 'Coupon'), params.id])
            redirect(action: "list")
            return
        }

        [couponInstance: couponInstance]
    }

    def update() {
        def couponInstance = Coupon.get(params.id)
        if (!couponInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'coupon.label', default: 'Coupon'), params.id])
            redirect(action: "list")
            return
        }

        if (params.version) {
            def version = params.version.toLong()
            if (couponInstance.version > version) {
                couponInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                          [message(code: 'coupon.label', default: 'Coupon')] as Object[],
                          "Another user has updated this Coupon while you were editing")
                render(view: "edit", model: [couponInstance: couponInstance])
                return
            }
        }

        couponInstance.properties = params

        if (!couponInstance.save(flush: true)) {
            render(view: "edit", model: [couponInstance: couponInstance])
            return
        }

		flash.message = message(code: 'default.updated.message', args: [message(code: 'coupon.label', default: 'Coupon'), couponInstance.id])
        redirect(action: "show", id: couponInstance.id)
    }

    def delete() {
        def couponInstance = Coupon.get(params.id)
        if (!couponInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'coupon.label', default: 'Coupon'), params.id])
            redirect(action: "list")
            return
        }

        try {
            couponInstance.delete(flush: true)
			flash.message = message(code: 'default.deleted.message', args: [message(code: 'coupon.label', default: 'Coupon'), params.id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
			flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'coupon.label', default: 'Coupon'), params.id])
            redirect(action: "show", id: params.id)
        }
    }
}
