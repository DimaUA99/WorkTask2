({
	loadData : function(component) {
		    var action = component.get("c.getAvailableCars");
                                        action.setCallback(this, function(response) {
                                            var state = response.getState();
                                            if (state === "SUCCESS") {
                                                var responseValue = response.getReturnValue();
                                                component.set('v.cars',responseValue);
                                            }
                                        });
                                        $A.enqueueAction(action);
		    },
		    toggle: function(component, event){
                                        var button = event.getSource();
                                        var carId = button.get("v.value")
                                        var images = component.find("imageId");
                                        if(!images)return;
                                        if($A.util.isArray(images)){
                                            for(var i in images){
                                               // console.log('image = ',images[i].getElement().dataset.id);
                                               var imageCarId = images[i].getElement().dataset.id;
                                                if(imageCarId == carId){
                                                 $A.util.toggleClass(images[i], "hidden");
                                                 return;
                                    }
                                  }
                                }
                             }
})