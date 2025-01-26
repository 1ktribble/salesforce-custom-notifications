public without sharing virtual class CustomNotificationHandler implements ICustomNotification {
	private static final Integer TITLE_UPPER_BOUND = 250;
	private static final Integer BODY_UPPER_BOUND = 750;

	protected String title;
	protected String body;
	protected String developerName;
	private Id targetId;
	private Set<String> userIds;
	private Id senderId;
	private String pageReferenceDevName;

	/**
	 * @description Get all custom notification types from the org
	 * @return `Map<String, CustomNotificationType>` developerNameToCustomNotification
	 */
	private Map<String, CustomNotificationType> developerNameToCustomNotification {
		get {
			if(this.developerNameToCustomNotification == null) {
				this.developerNameToCustomNotification = new Map<String, CustomNotificationType>();
				for (CustomNotificationType customNoty : [SELECT Id, DeveloperName, Language, MasterLabel, NamespacePrefix, CreatedDate, CreatedById, LastModifiedDate, LastModifiedById, SystemModStamp, Description, Desktop, Mobile FROM CustomNotificationType WHERE IsDeleted = false]) {
					this.developerNameToCustomNotification.put(
						customNoty.DeveloperName, customNoty
					);
				}
			}
			return this.developerNameToCustomNotification;
		}
		set;
	}

	/**
	 * @description Specify a target record to display when 
	 */
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

	public virtual ICustomNotification setTitle(String title) {
		this.title = title;
		return this;
	}

	public virtual ICustomNotification setBody(String body) {
		this.body = body;
		return this;
	}

	public virtual ICustomNotification setDeveloperName(String developerName) {
		this.developerName = developerName;
		return this;
	}

	public virtual ICustomNotification setSenderId(Id senderId) {
		this.senderId = senderId;
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

	public virtual void send() {
		if (
			(
				String.isBlank(this.title) || 
				String.isBlank(this.body) || 
				this.developerName == null ||
				this.userIds.isEmpty() ||
				(this.targetId == null && this.pageReferenceDevName == null)
			)
		) {
			throw new IncompleteNotificationException(
				String.format(
					'Please provide the following required fields: Title: {0}. Body: {1}. Developer Name: {2}. User Ids: {3}. And one of either Target Id: {4} or Page Reference Developer Name: {5}', 
					new List<Object>{
						this.title,
						this.body,
						this.developerName,
						this.userIds,
						this.targetId,
						this.pageReferenceDevName 
					}
				)
			);
		} else if(this.title.length() > TITLE_UPPER_BOUND || this.body.length() > BODY_UPPER_BOUND) {
			throw new InvalidMessageContentsException();
		} else {
			Messaging.CustomNotification notification = makeCustomNotification();
			notification.send(this.userIds);
		}
	}

	private Messaging.CustomNotification makeCustomNotification() {
		return new Messaging.CustomNotification(
			this.developerNameToCustomNotification.get(this.developerName).Id,
			this.senderId,
			this.title,
			this.body,
			this.targetId,
			this.pageReferenceDevName
		);
	}

	public class IncompleteNotificationException extends Exception {}

	public class InvalidMessageContentsException extends Exception {}
}