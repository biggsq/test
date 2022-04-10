global  class registrationController {
 Integer pagesize=5;
 String type;
 Decimal totalfee;
 public List<SelectOption> sexTypes = new List<SelectOption>();
 public String status{get;set;}
 public String player{get;set;}
 public String rdate{get;set;}
 public String game{get;set;}
 public String paramtid{get;set;}
 public String paramtest{get;set;}
 List<tournamentView> tlist{get;set;}

 registration__c registration{get;set;}
     public String divinfo{
         get{
             List<entry__c> elist=[select id,name,registration__c,tournament__c from entry__c where registration__c=:id];
             if(elist.size()>0){
                 divinfo='display:none;';}
             if(totalfee==0){
                divinfo='';
             }
             return divinfo;
         }set;
     }

     public List<selectOption> getTypeNames() {
        sexTypes.clear();
        sexTypes.add(new SelectOption('%','-- Any Type --'));
        sexTypes.add(new SelectOption('Badminton','Badminton'));
        sexTypes.add(new SelectOption('Basketball','Basketball'));
        sexTypes.add(new SelectOption('Football','Football'));
        sexTypes.add(new SelectOption('Swim','Swim'));
        sexTypes.add(new SelectOption('Volleyball','Volleyball'));
        return sexTypes;
    }
    
    public String Id = system.currentPageReference().getParameters().get('Id');

    //check 框
    public static String checkinfo{
        get{
            String Idd = system.currentPageReference().getParameters().get('Id');
            {                
             if(checkinfo==null){
                 checkinfo='';
                 List<entry__c> elist=[select id,name,registration__c,tournament__c from entry__c where registration__c=:idd];
                 for(Integer i=0;i<elist.size();i++){
                     checkinfo=checkinfo+'&&'+elist.get(i).tournament__c;
                 }
             }
             return checkinfo;
         } 
     }
     set;
 } 
 public String title{        
    get{
        String t ='New Registration';
        if(Id!=null){
            t=id;               
        }
        return t;
    }
    set;
}   
public registrationController(ApexPages.StandardController acon) {

}

   //文本框信息绑定数据库
public registration__c getRegistration(){
    if(registration==null){
        this.registration=new registration__c();
        if(id!=null){
           this.registration=[select name,player__c,status__c,date__c,entry_fee_total__c from registration__c where id=:id];
       }}
       return registration;
   }

    //翻页
   public  ApexPages.StandardSetController con {
    get {
        if(con == null) {              
            List<entry__c> elist5=[select tournament__c from entry__c where registration__c =:id];
            List<Id> tidlist5=new List<Id>();
            for(Integer i=0;i<elist5.size();i++){
                tidlist5.add(elist5.get(i).tournament__c);
            } 
            List<Tournament__c> tlist5=[select id,name,date__c,entry_fee__c,game__c from tournament__c where date__c >= :this.registration.date__c or id in :tidlist5 order by date__c];
            con = new ApexPages.StandardSetController(tlist5);
            con.setPageSize(pagesize);
        }
        return con;
    }
    set;
}





    //赛事信息绑定check按钮显示
public List<tournamentView> getTlist(){
    tlist = new List<tournamentView>();
        //system.debug(checkinfo);
    for(Tournament__c t: (List<tournament__c>)con.getRecords()){
        tlist.add(new tournamentView(t));
    }
    return tlist;

}

    //选择赛事类型
public void selecttype(){
    List<entry__c> elist5=[select tournament__c from entry__c where registration__c =:id];
    List<Id> tidlist5=new List<Id>();
    for(Integer i=0;i<elist5.size();i++){
        tidlist5.add(elist5.get(i).tournament__c);
    } 
    List<Tournament__c> tlist5=[select id,name,date__c,entry_fee__c,game__c from tournament__c where (date__c >= :this.registration.date__c or id in :tidlist5) and game__c like :game  order by date__c];
    con = new ApexPages.StandardSetController(tlist5);
    con.setPageSize(pagesize); 
}



public PageReference add(){
    List<registration__c> rlist=[select id,name,player__c,status__c,date__c,entry_fee_total__c from registration__c where player__c=:registration.player__c];
    if(rlist.size()==0){
        registration__c gregistration=new registration__c();
        gregistration.player__c=registration.player__c;
        gregistration.status__c=registration.status__c;
        gregistration.date__c=registration.date__c;
        gregistration.entry_fee_total__c=0;
        String rcheckinfo=registrationController.checkinfo;
        String[] rrrcheckinfo = rcheckinfo.split('&&');
        for(Integer i=1;i<rrrcheckinfo.size();i++){          
            List<tournament__c> tclist=[select id,name,date__c,entry_fee__c,game__c from tournament__c where id=:rrrcheckinfo[i]];
            gregistration.entry_fee_total__c=gregistration.entry_fee_total__c+tclist.get(0).entry_fee__c;
        }     
        insert gregistration;
        for(Integer i=1;i<rrrcheckinfo.size();i++){          
         entry__c gentry=new entry__c();
         gentry.registration__c=gregistration.id;
         gentry.tournament__c=rrrcheckinfo[i];
         insert gentry;
     }
     List<registration__c> rlist2=[select id from registration__c where player__c =:registration.player__c]; 
     PageReference pr = new PageReference('https://c.ap5.visual.force.com/apex/registration?id='+rlist2.get(0).id+'&sfdc.override=1'); 
     pr.setRedirect(true);
    return pr;                
 }
 else{
    if(title=='New Registration'){
        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'This player has already registered'));
        return null;
    }
 registration__c gregistration=new registration__c();
 gregistration.id=registration.id;    
        //gregistration.player__c=registration.player__c;
 gregistration.status__c=registration.status__c;
 gregistration.date__c=registration.date__c;
 gregistration.entry_fee_total__c=0;
 String rcheckinfo=registrationController.checkinfo;
 if(rcheckinfo==''){divinfo='';}
 String[] rrrcheckinfo = rcheckinfo.split('&&');
 for(Integer i=1;i<rrrcheckinfo.size();i++){          
    List<tournament__c> tclist=[select id,name,date__c,entry_fee__c,game__c from tournament__c where id=:rrrcheckinfo[i]];
    gregistration.entry_fee_total__c=gregistration.entry_fee_total__c+tclist.get(0).entry_fee__c;
}    
database.update(gregistration);
List<entry__c> dellist=[select id,name,registration__c,tournament__c from entry__c where registration__c=:registration.id];
for(entry__c e:dellist){
 database.delete(e);
}            
for(Integer i=1;i<rrrcheckinfo.size();i++){          
 entry__c gentry=new entry__c();
 gentry.registration__c=gregistration.id;
 gentry.tournament__c=rrrcheckinfo[i];
 insert gentry;
}    
List<entry__c> elist5=[select tournament__c from entry__c where registration__c =:id];
List<Id> tidlist5=new List<Id>();
for(Integer i=0;i<elist5.size();i++){
    tidlist5.add(elist5.get(i).tournament__c);
} 
List<Tournament__c> tlist5=[select id,name,date__c,entry_fee__c,game__c from tournament__c where date__c >= :this.registration.date__c or id in :tidlist5 order by date__c];
game='%';
con = new ApexPages.StandardSetController(tlist5);
con.setPageSize(pagesize);
return null;      
}      
}

public void can(){
  system.debug(checkinfo);   
}

public PageReference docan(){
    PageReference pr = new PageReference('https://ap5.salesforce.com/a07/o'); 
    pr.setRedirect(true);
    return pr;
}

public PageReference tnamelink(){
    PageReference pr = new PageReference('https://ap5.salesforce.com/'+paramtid); 
    pr.setRedirect(true);
    return pr;
}

    //跨页
@RemoteAction
global static void check(String a) {
    system.debug(a);

}
     //翻页组件
     // indicates whether there are more records after the current page set.
public Integer allpage {
    get{
        Integer a=0;
        List<tournament__c> toulist=new List<tournament__c>();
        if(game==null){
            List<entry__c> elist5=[select tournament__c from entry__c where registration__c =:id];
            List<Id> tidlist5=new List<Id>();
            for(Integer i=0;i<elist5.size();i++){
                tidlist5.add(elist5.get(i).tournament__c);
            } 
            toulist=[select id,name,date__c,entry_fee__c,game__c from tournament__c where date__c >= :this.registration.date__c or id in :tidlist5 order by date__c];
        }
        else{
            List<entry__c> elist5=[select tournament__c from entry__c where registration__c =:id];
            List<Id> tidlist5=new List<Id>();
            for(Integer i=0;i<elist5.size();i++){
                tidlist5.add(elist5.get(i).tournament__c);
            } 
            toulist=[select id,name,date__c,entry_fee__c,game__c from tournament__c where (date__c >= :this.registration.date__c or id in :tidlist5) and game__c like :game order by date__c];
        }
        a=toulist.size()/pagesize;
        if(a*pagesize < toulist.size()){
            a++;
        }
        if(a==0){
            a=1;
        }
        return a;
    }
    set;
} 

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
   con.first();
}

    // returns the last page of records
public void last() {
    con.last();
}

    // returns the previous page of records
public void previous() {
    con.previous();
}

    // returns the next page of records
public void next() {
   con.next();  
}

    //图表
public List<demodata> getData() {
 return getChartData();
}


	    // The actual chart data; needs to be static to be
	    // called by a @RemoteAction method
public  List<demodata> getChartData() {
 List<demodata> data = new List<demodata>();
 List<Tournament__c> tlist4=(List<Tournament__c>)con.getRecords();
 //List<tournament__c> tclist=[select id,name,date__c,entry_fee__c,game__c from tournament__c order by date__c];
 List<entry__c> elist5=[select tournament__c from entry__c where registration__c =:id];
 List<Id> tidlist5=new List<Id>();
            for(Integer i=0;i<elist5.size();i++){
                tidlist5.add(elist5.get(i).tournament__c);
            }
            List<Tournament__c> tclist=new List<Tournament__c>();
            if(game==null){
            if(tlist4.size()>0) {
  tclist=[select id,name,date__c,entry_fee__c,game__c from tournament__c where date__c>=:tlist4.get(0).date__c and (id in:tidlist5 or date__c >=:this.registration.date__c) order by date__c  ];
    }
}
else{
    if(tlist4.size()>0){
    tclist=[select id,name,date__c,entry_fee__c,game__c from tournament__c where (date__c>=:tlist4.get(0).date__c and (id in:tidlist5 or date__c >=:this.registration.date__c)) and game__c like :game order by date__c ];
}
}
 List<entry__c> elist=[select id,name,registration__c,tournament__c from entry__c where registration__c=:id];
 /*List<Tournament__c> tlist2=new List<Tournament__c>();
 if(game==null){
    tlist2=[select id,name,game__c,date__c from Tournament__c where (date__c>=:tlist4.get(0).date__c and date__c<=:tclist.get(tclist.size()-1).date__c)  and id in :tidlist5 ];
 }
 else{
    tlist2=[select id,name,game__c,date__c from Tournament__c where (date__c>=:tlist4.get(0).date__c and date__c<=:tclist.get(tclist.size()-1).date__c and game__c like :game) and id in :tidlist5 ];
 }*/
 List<tournament__c> tclist2=new List<tournament__c>();
 List<Id> idlist =new List<Id>();
 for(Integer i=0;i<elist.size();i++){
    idlist.add(elist.get(i).tournament__c);
 }
 if(elist.size()>0){
    if(game==null){
        tclist2=[select id,name,date__c,entry_fee__c,game__c from tournament__c where id in :idlist ];
  }
else{
    tclist2=[select id,name,date__c,entry_fee__c,game__c from tournament__c where id in :idlist and game__c like :game];
}
String a='';
totalfee=0;
Integer k=0;
for(Integer i=0;i<tclist.size();i++){
    Decimal fees=0;
    for(Integer j=0;j<tclist2.size();j++){
        if(tclist2.get(j).date__c==tclist.get(i).date__c){
            fees=fees+tclist2.get(j).entry_fee__c;
        }
    }
    if(a.indexOf(String.valueof(tclist.get(i).date__c))<0){
        a=a+String.valueof(tclist.get(i).date__c);
        data.add(new demodata(String.valueof(DateTime.newInstance(tclist.get(i).date__c.year(),tclist.get(i).date__c.month(),tclist.get(i).date__c.day()).format('M/d/y')),fees));
        k++;
    }
    totalfee+=fees;
    if(k==7){
        break;
    }
}
if(totalfee==0){
    data.clear();
}
}            
return data;
}

}