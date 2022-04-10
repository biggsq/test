public class student {
  public student__c student{get;set;}
  public boolean checked{get;set;}
    
    public student(Student__c stu) {
        this.student = stu;
        this.checked=false;
    }
}