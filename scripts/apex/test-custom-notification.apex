static final Id SELF = UserInfo.getUserId();

// Send a basic notification
ICustomNotification basicNoty = new ExampleNotification().setTargetId(SELF).setSenderId(SELF).setUsers(new Set<String>{ String.valueOf(SELF) });
basicNoty.send();

// Send a formatted notification
List<String> formattedTitle = new List<String>{ 'Title' };
List<String> formattedBody = new List<String>{ 'Body' };
ICustomNotification formattedNoty = new ExampleNotification(formattedTitle, formattedBody).setTargetId(SELF).setSenderId(SELF).setUsers(new Set<String>{ String.valueOf(SELF) });
formattedNoty.send();
