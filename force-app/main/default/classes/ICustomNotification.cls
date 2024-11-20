public interface ICustomNotification {
	ICustomNotification setTitle(String title);
	ICustomNotification setBody(String body);
	ICustomNotification setTargetId(Id targetId);
	ICustomNotification setUsers(Set<String> userIds);
	ICustomNotification setSenderId(Id senderId);
	ICustomNotification setDeveloperName(String developerName);
	ICustomNotification setPageReferenceDevName(String pageReferenceDevName);
	void send();
}