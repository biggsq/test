({
	scriptsLoaded:function(component,event,helper){
		$('.slds-tabs_default__item').on('click', function(){
        $(this).addClass('slds-is-active');
        $(this).find('a').attr('aria-selected', true);
        var $contentToShow = $('#'+$(this).find('a').attr('aria-controls'));
        $contentToShow.removeClass('slds-hide');
        $contentToShow.addClass('slds-show');

        $(this).siblings().removeClass('slds-is-active');
        $(this).siblings().find('a').attr('aria-selected', false);
        $contentToShow.siblings('.slds-tabs_default__content').removeClass('slds-show');
        $contentToShow.siblings('.slds-tabs_default__content').addClass('slds-hide');
    });
		$('.slds-tabs_scoped__item').on('click', function(){
        $(this).addClass('slds-is-active');
        $(this).find('a').attr('aria-selected', true);
        var $contentToShow = $('#'+$(this).find('a').attr('aria-controls'));
        $contentToShow.removeClass('slds-hide');
        $contentToShow.addClass('slds-show');

        $(this).siblings().removeClass('slds-is-active');
        $(this).siblings().find('a').attr('aria-selected', false);
        $contentToShow.siblings('.slds-tabs_scoped__content').removeClass('slds-show');
        $contentToShow.siblings('.slds-tabs_scoped__content').addClass('slds-hide');
    });
		$('.slds-vertical-tabs__nav-item').on('click', function(){
        $(this).addClass('slds-is-active');
        $(this).find('a').attr('aria-selected', true);
        var $contentToShow = $('#'+$(this).find('a').attr('aria-controls'));
        $contentToShow.removeClass('slds-hide');
        $contentToShow.addClass('slds-show');

        $(this).siblings().removeClass('slds-is-active');
        $(this).siblings().find('a').attr('aria-selected', false);
        $contentToShow.siblings('.slds-vertical-tabs__content').removeClass('slds-show');
        $contentToShow.siblings('.slds-vertical-tabs__content').addClass('slds-hide');
    });
	},
    doInit: function(component, event, helper) {
        component.set('v.mycolumns', [
                {label: '文档类型', fieldName: 'type', type: 'text',sortable: true },
                {label: '文档子类型', fieldName: 's_type', type: 'text'},
                {label: '文档名称', fieldName: 'name', type: 'text'},
                {label: '上传时间', fieldName: 'time', type: 'text'},
                {label: '更新人', fieldName: 'update', type: 'text'},
                {label: '版本号', fieldName: 'id', type: 'text'},
                {label: '说明', fieldName: 'describe', type: 'text'}
            ]);
        
    },


    test1:function(component, event, helper) {
        var fileinput = $("#file-upload-input-01")[0].files[0];
         var time = new Date();   
         var mon = time.getMonth() + 1; 
         var hour = time.getHours()<10?"0"+time.getHours():time.getHours();
         var min = time.getMinutes()<10?"0"+time.getMinutes():time.getMinutes();
         var sec = time.getSeconds()<10?"0"+time.getSeconds():time.getSeconds();
         var t = time.getFullYear() + "-" + mon + "-"     
         + time.getDate() + " " + hour + ":"     
         + min + ":" + sec;
         var resdata=[];
            resdata.push({
                type: fileinput.type,
                s_type: fileinput.name,
                name: fileinput.name,
                time: t,
                update: '1',
                id: '1',
                describe: '1'
            });
          var data=component.get('v.mydata');
          for(var i=0;i<data.length;i++){
            resdata.push(data[i]);
          }
        component.set('v.mydata', resdata);
        
    }
})