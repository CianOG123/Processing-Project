class Notification_Handler{
  
  ArrayList <Notification> notifications = new ArrayList <Notification>();
  
  private void draw(){
    for(int i = 0; i < notifications.size(); i++){
      notifications.get(i).draw();
      if(notifications.get(i).isFinished == true)
        notifications.remove(i);
    }
  }
  
  public void createNotification(String heading, String body){
    notifications.add(new Notification(heading, body));
  }
}
