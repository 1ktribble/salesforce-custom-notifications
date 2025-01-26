@isTest
public class MockCustomNotificationHandler extends CustomNotificationHandler {
	public static List<Messaging.CustomNotification> notificationsSent = 
		new List<Messaging.CustomNotification>();
	public static Set<String> usersSent;
	public static Id mockedNotificationId;
	
	public String title;
	public String body;
	private Id targetId;
	private Id senderId;
	private String pageReferenceDevName;

	public override ICustomNotification setTitle(String title) {
		this.title = title;
		return this;
	}

	public override ICustomNotification setBody(String body) {
		this.body = body;
		return this;
	}

	public override ICustomNotification setTargetId(Id targetId) {
		return this;
	}

	public override ICustomNotification setUsers(Set<String> userIds) {
		usersSent = userIds;
		return this;
	}

	public override ICustomNotification setSenderId(Id senderId) {
		return this;
	}

	public override ICustomNotification setDeveloperName(String developerName) {
		return this;
	}

	public override ICustomNotification setPageReferenceDevName(String pageReferenceDevName) {
		return this;
	}

	public override void send() {
		Messaging.CustomNotification mockedNoty = 
			new Messaging.CustomNotification();

		mockedNoty.setTitle(this.title);
		mockedNoty.setBody(this.body);
		mockedNoty.setTargetId(this.targetId);
		mockedNoty.setSenderId(this.senderId);
		mockedNoty.setTargetPageRef(this.pageReferenceDevName);
		mockedNoty.setNotificationTypeId(mockedNotificationId);
		
		notificationsSent.add(mockedNoty);
	}
}