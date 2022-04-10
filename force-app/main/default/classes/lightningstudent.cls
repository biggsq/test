public  class lightningstudent {
      @AuraEnabled 
      public student__c student{get;set;}
      @AuraEnabled 
      public boolean checked{get;set;}
    
    public  lightningstudent(Student__c stu) {
        this.student = stu;
        this.checked=false;
        String checkinfo=HelloWorld.checked;
        if(checkinfo.indexOf(stu.sid__c)>=0){
           this.checked=true;
        }
    }     
}