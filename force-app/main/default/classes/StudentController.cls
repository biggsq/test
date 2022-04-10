public with sharing class StudentController {
    public List<student__c> studentlist{get;set;}
    List<student> slist{get;set;}
    public List<SelectOption> sexTypes = new List<SelectOption>();
    //public student__c student{get;set;}
    public String id{get;set;}
    public String name{get;set;}
    public String sex{get;set;}
    public String paramstuid{get;set;}
    Integer pagesize=5;
    //public boolean checked{get;set;}
    
    /*public StudentController(){
String stusql='select id,name,sex__c from student__c limit 10';
studentlist=Database.query(stusql);
}*/
    /* public StudentController(){
List<student> sl=new List<student>();
for (Student__c s : [select id,name,sex__c from student__c limit 5]) {
Student stu = new Student(s);            
sl.add(stu);
}
slist=sl;
}*/
    public ApexPages.StandardSetController con {
        get {
            if(con == null) {             
                con = new ApexPages.StandardSetController(Database.getQueryLocator([select id,sid__c,name,sex__c from student__c order by sid__c]));
                // sets the number of records in each page set
                con.setPageSize(pagesize);
            }
            return con;
        }
        set;
    }
    public List<student> getSlist() {
        slist = new List<student>();
        for (Student__c s : (List<Student__c>)con.getRecords()){
            slist.add(new Student(s));
        }
        System.debug(con.getRecords());
        return slist;
    }
    
    public StudentController(){
        //getSlist();
    }
    
    public List<selectOption> getTypeNames() {
        sexTypes.clear();
        sexTypes.add(new SelectOption('%','请选择'));
        sexTypes.add(new SelectOption('男','男'));
        sexTypes.add(new SelectOption('女','女'));
        return sexTypes;
    }
    
    public void refresh(){
        String stusql='select id,sid__c,name,sex__c from student__c';
        studentlist=Database.query(stusql);
    }
    
    
    public void query(){
        String stusql='select id,sid__c,name,sex__c from student__c ';
        String a='%';
        stusql +='where name like :a';
        // stusql +='where IsDeleted = false';    
        if(name!=null &&''!=name){
            name='%'+name+'%';
            stusql +=' and name like :name ';           
        }
        if(sex!=null &&''!=sex){
            sex='%'+sex+'%';
            stusql +=' and sex__c like :sex ';
        }
        stusql +=' order by sid__c ';
        /* stusql +=' limit :pagesize offset 0 ';
studentlist=Database.query(stusql);
List<student> sl=new List<student>();
for(student__c s:studentlist){
Student stu=new Student(s);
sl.add(stu);
}
slist=sl;*/
        con = new ApexPages.StandardSetController(Database.getQueryLocator(stusql));
        con.setPageSize(pagesize);
        name=name.remove('%');
        sex=sex.remove('%');
    }
    
    public void add(){
       
        if(sex=='%'){
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, '请选择sex'));
            return;
        }
        Student__c stu=new Student__c();
        stu.Name=name;
        stu.sex__c=sex;
        insert stu;
        name='';
        sex='';
        con = new ApexPages.StandardSetController(Database.getQueryLocator([select id,sid__c,name,sex__c from student__c order by sid__c]));
        con.setPageSize(pagesize);
        con.last();
    }
    
    public void all(){
        con = new ApexPages.StandardSetController(Database.getQueryLocator([select id,sid__c,name,sex__c from student__c order by sid__c]));
        con.setPageSize(pagesize);
    }
    
    public void deletestu() {
        //Database.delete(paramstuid);
        //query();
        for(student sccc:slist){
            if(sccc.checked){
                Database.delete(sccc.student.id);
            }
        }
        currentpage(); 
    }
    public void updatestu(){
        List<student> sl=new List<student>();
        for(student sccc:slist){
            if(sccc.checked){
                sl.add(sccc);
            }
        }
        if(sl.size()!=1){
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, '请选择一条信息'));
            return;
        }
        student__c stu=new student__c();
        stu.Id=sl.get(0).student.id;
        if(name!=null &&''!=name){
            stu.Name=name;
        }
        if(sex!=null && ''!=sex){
            stu.sex__c=sex;
        }
        database.update(stu);
        name='';
        sex='';
        currentpage();    
    }
    
    //跳转当前页 
    public void currentpage(){
        Integer pp= pageNumber;
        String stusql='select id,sid__c,name,sex__c from student__c ';
        String a='%';
        stusql +='where name like :a';
        // stusql +='where IsDeleted = false';    
        if(name!=null &&''!=name){
            name='%'+name+'%';
            stusql +=' and name like :name ';           
        }
        if(sex!=null &&''!=sex){
            stusql +=' and sex__c like :sex ';
        }
        stusql +=' order by sid__c ';
        con = new ApexPages.StandardSetController(Database.getQueryLocator(stusql));
        con.setPageSize(pagesize);
        for(Integer p=1;p<pp;p++){
            con.next();
        }
        name=name.remove('%');
        sex=sex.remove('%');
    }
    
    // indicates whether there are more records after the current page set.
    public Boolean hasNext {
        get {
            return con.getHasNext();
        }
        set;
    }
    
    // indicates whether there are more records before the current page set.
    public Boolean hasPrevious {
        get {
            return con.getHasPrevious();
        }
        set;
    }
    
    // returns the page number of the current page set
    public Integer pageNumber {
        get {
            return con.getPageNumber();
        }
        set;
    }
    
    // returns the first page of records
    public void first() {
        // querypage(0);
        con.first();
    }
    
    // returns the last page of records
    public void last() {
        /* String stusql='select id,name,sex__c from student__c ';
String a='%';
stusql +='where name like :a';
// stusql +='where IsDeleted = false';    
if(name!=null &&''!=name){
name='%'+name+'%';
stusql +=' and name like :name ';           
}
if(sex!=null &&''!=sex){
sex='%'+sex+'%';
stusql +=' and sex__c like :sex ';
}  
studentlist=database.query(stusql);
Integer x=studentlist.size()/pagesize;
if(x*pagesize<studentlist.size()){
x++;
}
querypage((x-1)*5);*/
        con.last();
    }
    
    // returns the previous page of records
    public void previous() {
        //querypage((pageNumber-2)*pagesize);
        con.previous();
    }
    
    // returns the next page of records
    public void next() {
        // querypage(pageNumber*pagesize);
        System.debug(con.getRecords());
        con.next();
    }
}