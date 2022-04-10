public class HelloWorld {
	@AuraEnabled 
	public static String checked{get{if(checked==null){checked='';}return checked;}set;}
	public HelloWorld(ApexPages.StandardController acon) { }
	public static void sayYou() {
		System.debug( 'You') ;
	}
	String sayMe;
	public String aa{get;set;}
	public String bb{get;set;}
	public String getsayMe() {
		return sayMe;
	}

	public void pp(){
		check__c check=new check__c();
		check.name='new';
		insert(check);
	}

	public List<Data> getData() {
		return HelloWorld.getChartData();
	}

	    // Make the chart data available via JavaScript remoting
	@RemoteAction
	public static List<Data> getRemoteData() {
		return HelloWorld.getChartData();
	}

	    // The actual chart data; needs to be static to be
	    // called by a @RemoteAction method
	public static List<Data> getChartData() {
		List<Data> data = new List<Data>();
		data.add(new Data('Jan', 30, 90, 55));
		data.add(new Data('Feb', 44, 15, 65));
		data.add(new Data('Mar', 25, 32, 75));
		data.add(new Data('Apr', 74, 28, 85));
		data.add(new Data('May', 65, 51, 95));
		data.add(new Data('Jun', 33, 45, 99));
		data.add(new Data('Jul', 92, 82, 30));
		data.add(new Data('Aug', 87, 73, 45));
		data.add(new Data('Sep', 34, 65, 55));
		data.add(new Data('Oct', 78, 66, 56));
		data.add(new Data('Nov', 80, 67, 53));
		data.add(new Data('Dec', 17, 70, 70));
		return data;

	}  
//hello lighening
	  public static Integer pagesize=5;
	 public static ApexPages.StandardSetController con {
        get {
            if(con == null) {          
                con = new ApexPages.StandardSetController(Database.getQueryLocator([select id,name,date__c,entry_fee__c,game__c from tournament__c order by date__c]));
                // sets the number of records in each page set
                con.setPageSize(pagesize);
            }
            return con;
        }
        set;
    }
    public static Integer pageNumber {
        get {
            return con.getPageNumber();
        }
        set;
    }
    
    // returns the first page of records
    @AuraEnabled 
    public static Map<String,Object> first2() {
    	con.first();
    	Map<String,Object> resmap=new Map<String,Object>();
    	List<Tournament__c> tlist=(List<Tournament__c>)con.getRecords();
        resmap.put('tlist',tlist);
        return resmap;
    }
    
    // returns the last page of records
    @AuraEnabled 
    public static Map<String,Object> last2() {
    	con.last();
    	Map<String,Object> resmap=new Map<String,Object>();
    	List<Tournament__c> tlist=(List<Tournament__c>)con.getRecords();
        resmap.put('tlist',tlist);
        resmap.put('pageNumber', pageNumber);
        return resmap;
    }
    // returns the previous page of records
    @AuraEnabled 
    public static Map<String,Object> previous2(Integer page) {
    	//con.previous();
    	for(Integer i=1; i<Integer.valueOf(page); i++){
    	con.next();}
    	Map<String,Object> resmap=new Map<String,Object>();
    	List<Tournament__c> tlist=(List<Tournament__c>)con.getRecords();
        resmap.put('tlist',tlist);
        resmap.put('page',page);
        return resmap;
    }
    
    // returns the next page of records
    @AuraEnabled 
    public static Map<String,Object> next2(Integer page) {
    	system.debug(page);
    	for(Integer i=1; i<Integer.valueOf(page); i++){
    	con.next();}
    	Map<String,Object> resmap=new Map<String,Object>();
    	List<Tournament__c> tlist=(List<Tournament__c>)con.getRecords();
        resmap.put('tlist',tlist);
        resmap.put('page', page);
        return resmap;
    }

   public static ApexPages.StandardSetController scon {
        get {
            if(scon == null) {          
                scon = new ApexPages.StandardSetController(Database.getQueryLocator([select id,sid__c,name,sex__c from student__c order by sid__c]));
                // sets the number of records in each page set
                scon.setPageSize(pagesize);
            }
            return scon;
        }
        set;
    }

    @AuraEnabled 
    public static Map<String,Object> sfirst2(String schecked) {
    	scon.first();
    	HelloWorld.checked=schecked;
    	Map<String,Object> resmap=new Map<String,Object>();
    	List<Student__c> slist1 =(List<Student__c>)scon.getRecords();
    	List<lightningstudent> slist=new List<lightningstudent>();
        for(student__c s:slist1){
             slist.add(new lightningstudent(s));
        } 
        resmap.put('slist',slist);
        return resmap;
    }
    
    // returns the last page of records
    @AuraEnabled 
    public static Map<String,Object> slast2(String schecked) {
    	scon.last();
    	HelloWorld.checked=schecked;
    	Map<String,Object> resmap=new Map<String,Object>();
    	List<Student__c> slist1 =(List<Student__c>)scon.getRecords();
    	List<lightningstudent> slist=new List<lightningstudent>();
        for(student__c s:slist1){
             slist.add(new lightningstudent(s));
        } 
        resmap.put('slist',slist);
        return resmap;
    }
    // returns the previous page of records
    @AuraEnabled 
    public static Map<String,Object> sprevious2(Integer spage,String schecked) {
    	//scon.previous();
    	for(Integer i=1; i<Integer.valueOf(spage); i++){
    	scon.next();}
    	HelloWorld.checked=schecked;
    	Map<String,Object> resmap=new Map<String,Object>();
    	List<Student__c> slist1 =(List<Student__c>)scon.getRecords();
    	List<lightningstudent> slist=new List<lightningstudent>();
        for(student__c s:slist1){
             slist.add(new lightningstudent(s));
        } 
        resmap.put('slist',slist);
        resmap.put('spage', spage);
        return resmap;
    }
    
    // returns the next page of records
    @AuraEnabled 
    public static Map<String,Object> snext2(Integer spage,String schecked) {
    	for(Integer i=1; i<Integer.valueOf(spage); i++){
    	scon.next();}
    	HelloWorld.checked=schecked;
    	Map<String,Object> resmap=new Map<String,Object>();
    	List<Student__c> slist1 =(List<Student__c>)scon.getRecords();
    	system.debug(slist1);
    	List<lightningstudent> slist=new List<lightningstudent>();
        for(student__c s:slist1){
             slist.add(new lightningstudent(s));
        } 
        resmap.put('slist',slist);
        resmap.put('spage', spage);
        return resmap;
    }

   @AuraEnabled 
   public static Map<String,Object> sonepage2(Integer spage,String schecked){
       for(Integer i=1;i<Integer.valueOf(spage); i++){
       	scon.next();
       }
       HelloWorld.checked=schecked;
       Map<String,Object> resmap=new Map<String,Object>();
       List<student__c> slist1=(List<student__c>)scon.getRecords();
       List<lightningstudent> slist=new List<lightningstudent>();
       for(student__c s:slist1){
          slist.add(new lightningstudent(s));
       }
       resmap.put('slist', slist);
       resmap.put('spage', spage);
       return resmap;
   }

	@AuraEnabled   
	public static Map<String,Object> addexpense(expense__c newExpense){
		system.debug(newExpense);
		system.debug(newExpense.name);
       	insert newExpense;
		Map<String,Object> resmap=new Map<String,Object>();
		resmap.put('a', '1');
		resmap.put('b', '2');
		return resmap;
	} 

	  @AuraEnabled
    public static  Map<String,Object> getExpenses() {
        // Perform isAccessible() checking first, then
        List<Expense__c> elist= [SELECT Id, Name, Amount__c, Client__c, Date__c, 
                       Reimbursed__c, CreatedDate 
                FROM Expense__c order by CreatedDate];
          Expense__c e=[SELECT Id, Name, Amount__c, Client__c, Date__c, 
                       Reimbursed__c, CreatedDate 
                FROM Expense__c limit 1];
        List<Student__c> slist1 =(List<Student__c>)scon.getRecords();
        List<lightningstudent> slist=new List<lightningstudent>();
        for(student__c s:slist1){
             slist.add(new lightningstudent(s));
        }        
        List<Tournament__c> tlist=[select id,name,date__c,entry_fee__c,game__c from tournament__c order by date__c];
            Integer totalpage=tlist.size()/pagesize;
            if(totalpage*pagesize<tlist.size()){
            	totalpage=totalpage+1;
            }
         List<Student__c> slist2=[select id,sid__c,name,sex__c from student__c order by sid__c];
         Integer stotalpage=slist2.size()/pagesize;
            if(stotalpage*pagesize<slist2.size()){
            	stotalpage=stotalpage+1;
            }
        Map<String,Object> resmap=new Map<String,Object>();
        resmap.put('a', elist.get(0).name);
        resmap.put('elist', elist);
        resmap.put('c', e);
        resmap.put('totalpage', totalpage);
        resmap.put('stotalpage', stotalpage);
        resmap.put('slist', slist);
        system.debug(UserInfo.getUserName());
                return resmap;
    }
    
    @AuraEnabled
    public static  Map<String,Object> getExpenses2() {
        // Perform isAccessible() checking first, then
          Expense__c e=[SELECT Id, Name, Amount__c, Client__c, Date__c, 
                       Reimbursed__c, CreatedDate 
                FROM Expense__c limit 1];
        Map<String,Object> resmap=new Map<String,Object>();
        resmap.put('e', e);
                return resmap;
    }

    @AuraEnabled
    public static Expense__c saveExpense(Expense__c expense) {
        // Perform isUpdatable() checking first, then
        upsert expense;
        return expense;
    }
    //多少多少天前 标签是时间戳
    @AuraEnabled
    public static Long getFormatdate2(Expense__c expense) {
    	Long formatdate=expense.Date__c.getTime();
       return formatdate;     
    }

    @AuraEnabled
   public static Map<String,Object> getTournaments(){
    Map<String,Object> resmap=new Map<String,Object>();
    List<Tournament__c> tlist=new List<Tournament__c>();
    tlist=(List<Tournament__c>)con.getRecords(); 
    /*tlist=[select id,name,date__c,entry_fee__c,game__c from tournament__c order by date__c];*/
    resmap.put('tlist', tlist);
    return resmap;
   }   
}