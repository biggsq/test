public class tournamentView {
  public tournament__c tournament{get;set;}
  public boolean checked{get;set;}
   
  public String Id = system.currentPageReference().getParameters().get('Id');
    List<entry__c> elist=[select id,name,registration__c,tournament__c from entry__c where registration__c=:id];
    
    public tournamentView(tournament__c tou) {
        this.tournament = tou;
        this.checked=false;      
        for(Integer i=0;i<elist.size();i++){
            if(elist.get(i).tournament__c == this.tournament.id){
                this.checked=true;
            }
        }
        String rcheckinfo=registrationController.checkinfo;
        String[] rrrcheckinfo = rcheckinfo.split('&&');
        for(Integer i=1;i<rrrcheckinfo.size();i++){          
            if(rrrcheckinfo[i]==this.tournament.id){
                this.checked=true;
            }
        }         
    }
}