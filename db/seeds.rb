

app_name =  "Calculos end linea"
app = App.where(name:app_name).first

unless app
	app = App.create(name:app_name)
end



SubscriptionType.create(app_id:app.id,duration:360,name:"NSS y Patrones")
SubscriptionType.create(app_id:app.id,duration:360,name:"ISPT")
SubscriptionType.create(app_id:app.id,duration:360,name:"Finiquito")

