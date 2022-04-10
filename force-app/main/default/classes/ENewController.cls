public class ENewController {
    public static Integer pagesize=10;

     //查询新房
    @AuraEnabled
    public static Map<String,Object>  getNewHouses(Decimal pageNumber,String area,String subway,String price,String layout,String type,String feature,String ename) {
        Integer offset = ((Integer)pageNumber - 1) * pagesize;
        String sql='select id,Name,name__c,feature__c,price__c,type__c,developer__c,area__c,address__c,houseLayout__c,licence__c,number__c,process__c,etc__c,image__c,payDate__c,status__c,size__c from New_houses__c ';
       String a='%';
        sql=sql+' where Name like :a ' ;
         if(ename!=null&&ename!=''){
          ename='%'+ename+'%';
          sql=sql+' and name__c like :ename  ';
         }
         if(area!='unlimited'&&area!=null){
          area='%'+area+'%' ;
          sql=sql+' and area__c like :area ';
       }
        if(price!='unlimited'&&price!=null){
          if(price=='price0'){sql=sql+' and price__c <10000 ';}
          if(price=='price1'){sql=sql+' and price__c >=10000 and price__c <20000 ';}
          if(price=='price2'){sql=sql+' and price__c >=20000 and price__c <30000 ';}
          if(price=='price3'){sql=sql+' and price__c >=30000 and price__c <40000 ';}
          if(price=='price4'){sql=sql+' and price__c >=40000 and price__c <50000 ';}
          if(price=='price5'){sql=sql+' and price__c >=50000 ';}
        }
        if(layout!='unlimited'&&layout!=null){
          layout='%'+layout+'%';
          sql=sql+' and houselayout__c like :layout ';
        }
        if(type!='unlimited'&&type!=null){
          type='%'+type+'%';
          sql=sql+' and type__c like :type ';
        }
        if(feature!='unlimited'&&feature!=null){
          feature='%'+feature+'%';
          sql=sql+' and feature__c like :feature ';
        }
        if(subway!=''&&subway!=null){
          String ac='';String fc='';
          if(subway=='subway1'){ac='%徐汇%';fc='%轨交房%'; sql=sql+' and area__c like :ac and feature__c like :fc ';}
          if(subway=='subway2'){ac='%浦东%';fc='%轨交房%'; sql=sql+' and area__c like :ac and feature__c like :fc ';}
          if(subway=='subway3'){ac='%黄浦%';fc='%轨交房%'; sql=sql+' and area__c like :ac and feature__c like :fc ';}
          if(subway=='subway4'){ac='%长宁%';fc='%轨交房%'; sql=sql+' and area__c like :ac and feature__c like :fc ';}
          if(subway=='subway5'){ac='%静安%';fc='%轨交房%'; sql=sql+' and area__c like :ac and feature__c like :fc ';}
          if(subway=='subway6'){ac='%普陀%';fc='%轨交房%'; sql=sql+' and area__c like :ac and feature__c like :fc ';}
          if(subway=='subway7'){ac='%虹口%';fc='%轨交房%'; sql=sql+' and area__c like :ac and feature__c like :fc ';}
          if(subway=='subway8'){ac='%杨浦%';fc='%轨交房%'; sql=sql+' and area__c like :ac and feature__c like :fc ';}
          if(subway=='subway9'){ac='%松江%';fc='%轨交房%'; sql=sql+' and area__c like :ac and feature__c like :fc ';}
          if(subway=='subway11'){ac='%嘉定%';fc='%轨交房%'; sql=sql+' and area__c like :ac and feature__c like :fc ';}
          if(subway=='subway16'){ac='%宝山%';fc='%轨交房%'; sql=sql+' and area__c like :ac and feature__c like :fc ';}
        }
       List<New_houses__c> ecount = database.query(sql);
       sql=sql+' order by Name limit :pagesize  offset :offset ';
        List<New_houses__c> enewlist=new List<New_houses__c>(); 
        enewlist=database.query(sql);
        Integer totalpage=ecount.size()/pagesize;
        if(totalpage*pagesize<ecount.size()){
        	totalpage++;
        }    
        Map<String,Object> resmap=new Map<String,Object>();
        resmap.put('enewlist',enewlist);
        resmap.put('totalpage', totalpage);
        return resmap;
    }
   

    //查看新房具体信息
    @AuraEnabled
    public static Map<String,Object> getNewhouseDetail(String id){
       New_houses__c eone=[select id,Name,name__c,feature__c,price__c,type__c,developer__c,area__c,address__c,houseLayout__c,licence__c,number__c,process__c,etc__c,image__c,payDate__c,status__c,size__c from New_houses__c where id=:id order by Name limit 1];
       Map<String,Object> resmap=new Map<String,Object>();
       resmap.put('eone', eone);
       return resmap;
    }

    @AuraEnabled
    public static Map<String,Object> csearchByselect(String area ,String subway,String price,String layout,String type,String feature){
       String sql='select id,Name,name__c,feature__c,price__c,type__c,developer__c,area__c,address__c,houseLayout__c,licence__c,number__c,process__c,etc__c,image__c,payDate__c,status__c,size__c from New_houses__c ';
       String a='%';
       sql=sql+' where Name like :a ' ;
       if(area!='unlimited'){
          area='%'+area+'%' ;
          sql=sql+' and area__c like :area ';
       }
       sql=sql+' order by Name limit 1';
       if(price!='unlimited'){
          
       }
      System.debug(database.query(sql));
       Map<String,Object> resmap=new Map<String,Object>();
       
       return resmap;
    }
}