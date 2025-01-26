public class ExampleNotification extends CustomNotificationHandler {
    @TestVisible
    private static final String TITLE = 'Example Notification';

    @TestVisible
    private static final String BODY = 'Standard Body';

    private static final String FORMATTED_TITLE = 'Formatted {0} Title';
    private static final String FORMATTED_BODY = 'Formatted {0} Body';

    private static final String CUSTOM_NOTIFICATION = 'Example_Notification';

    public ExampleNotification() {
        this.title = TITLE;
        this.body = BODY;
        this.developerName = CUSTOM_NOTIFICATION;
    }

    /**
     * @param List<Object> title params 
     * @param List<Object> body params 
     */
    public ExampleNotification(List<Object> formattedTitleParameters, List<Object> formattedBodyParameters) {
        this.title = String.format(FORMATTED_BODY, formattedTitleParameters);
        this.body = String.format(FORMATTED_BODY, formattedBodyParameters);
        this.developerName = CUSTOM_NOTIFICATION;
    }
}