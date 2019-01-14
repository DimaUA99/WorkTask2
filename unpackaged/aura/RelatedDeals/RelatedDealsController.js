({
      	doInit: function(component, event, helper) {
      		var action = component.get("c.getAuraRelatedDeals");
      		action.setCallback(this, function(response) {
                          var state = response.getState();
                          if (state === "SUCCESS") {
                              var responseValue = response.getReturnValue();
                              component.set('v.deals',responseValue);
                          }
                  });
                         $A.enqueueAction(action);
      	}
      })