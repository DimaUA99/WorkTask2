({
	doInit : function(component, event, helper) {
            helper.loadData(component);

	},
    doToggle:function(component, event, helper){
        helper.toggle(component,event);
    }
})