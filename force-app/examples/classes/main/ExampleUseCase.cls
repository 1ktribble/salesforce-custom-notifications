public with sharing class ExampleUseCase {
    private static final Id SELF = UserInfo.getUserId();

    public void sendBasicNotification() {
        ICustomNotification basicNoty = new ExampleNotification().setTargetId(SELF).setSenderId(SELF).setUsers(new Set<String>{ String.valueOf(SELF) });
        basicNoty.send();
    }

    public void sendFormattedNotification(List<String> formattedTitle, List<String> formattedBody) {
        ICustomNotification formattedNoty = new ExampleNotification(formattedTitle, formattedBody).setTargetId(SELF).setSenderId(SELF).setUsers(new Set<String>{ String.valueOf(SELF) });
        formattedNoty.send();
    }
}