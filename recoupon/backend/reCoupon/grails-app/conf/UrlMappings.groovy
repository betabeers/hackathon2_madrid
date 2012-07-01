class UrlMappings {

	static mappings = {
	 	"/c/$id"(controller: "coupon", action: "showTag")
	 	"/code/$tagID/$username/"(controller: "coupon", action: "code")
	 	"/share/$scanId/$email/"(controller: "coupon", action: "share")
	 	"/demo"(controller: "coupon", action: "demo")
		"/$controller/$action?/$id?"{
			constraints {
				// apply constraints here
			}
		}


		"/"(view:"/index")
		"500"(view:'/error')
	}
}
