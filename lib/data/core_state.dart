class CoreState{
   List<String> dashboards; 

   CoreState({ 
     this.dashboards
  });

   @override
  bool operator ==(Object right)=>
    identical(this,right) || 
     right is CoreState &&
      runtimeType == right.runtimeType &&
      !confirmChangesDashboard(dashboards, right);
  
  @override
  int get hashCode => dashboards.hashCode;
  

  bool confirmChangesDashboard(List left, dynamic right){
    //if is true have changes, if not no changes 
    bool result = false;
  
    for (int i=0; i == dashboards.length +1; i++) {
        if(i == dashboards.length+1){
          if(right[i]!= null)return true;
          else return false;
        }
        if(dashboards[i]!= right[i]) return true;
    }
    return result;
  }
  
  CoreState copy ({List<String> dashboards}) => CoreState(dashboards: dashboards ?? this.dashboards);
}