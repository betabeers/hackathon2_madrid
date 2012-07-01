class BootStrap {
	
	def yunaitService
    
    def init = { servletContext ->
		
		yunaitService.populateDatabase()

    }
    def destroy = {
    }
}
