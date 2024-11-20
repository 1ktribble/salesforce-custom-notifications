public without sharing virtual class CustomNotificationHandler implements ICustomNotification {
	private String title;
	private String body;
	private Id targetId;
	private Set<String> userIds;
	private Id senderId;
	private String developerName;
	private String pageReferenceDevName;

	/**
	 * @description Get all custom notification types from the org
	 * @return `Map<String, CustomNotificationType>` developerNameToCustomNotification
	 */
	private Map<String, CustomNotificationType> developerNameToCustomNotification {
		get {
			if(this.developerNameToCustomNotification == null) {
				return [SELECT Id, DeveloperName, Language, MasterLabel, NamespacePrefix, CreatedDate, CreatedById, LastModifiedDate, LastModifiedById, SystemModStamp, Description, Desktop, Mobile FROM CustomNotificationType WHERE IsDeleted = false];
			}
			return this.developerNameToCustomNotification;
		}
		set;
	}

	public CustomNotificationHandler() {
		this.setDevNameToCustomNotificationMap();
	}

	public virtual ICustomNotification setTitle(String title) {
		this.title = title;
		return this;
	}

	public virtual ICustomNotification setBody(String body) {
		this.body = body;
		return this;
	}

	public virtual ICustomNotification setTargetId(Id targetId) {
		this.targetId = targetId;
		return this;
	}

	public virtual ICustomNotification setUsers(
		Set<String> userIds
	) {
		this.userIds = userIds;
		return this;
	}

	public virtual ICustomNotification setSenderId(Id senderId) {
		this.senderId = senderId;
		return this;
	}

	public virtual ICustomNotification setDeveloperName(
		String developerName
	) {
		this.developerName = developerName;
		return this;
	}

	/**
	 * @description developer name of page reference to navigate to
	 */
	public virtual ICustomNotification setPageReferenceDevName(
		String pageReferenceDevName
	) {
		this.pageReferenceDevName = pageReferenceDevName;
		return this;
	}

	private void setDevNameToCustomNotificationMap() {
		for (CustomNotificationType customNoty : this.developerNameToCustomNotification.values()) {
			this.developerNameToCustomNotification.put(
				customNoty.DeveloperName, customNoty
			);
		}
	}

	public void send() {
		if (
			this.title == null ||
			this.body == null ||
			this.developerName == null ||
			this.userIds == null ||
			(this.targetId == null && this.pageReferenceDevName == null)
		) {
			throw new IncompleteNotificationException();
		} else {
			Messaging.CustomNotification notification = makeCustomNotification();
			notification.send(this.userIds);
		}
	}

	private Messaging.CustomNotification makeCustomNotification() {
		return new Messaging.CustomNotification(
			// typeId
			this.developerNameToCustomNotification.get(this.developerName).Id,
			// sender
			this.senderId,
			// title
			this.title,
			// body
			this.body,
			// targetId
			this.targetId,
			// targetPageRef
			this.pageReferenceDevName
		);
	}

	public class IncompleteNotificationException extends Exception {}
}