package com.thienday.headup.constants;

public class AppEnvironmentLoader {
    public static final String GOOGLE_PROVIDER = "GG_AUTH";
    public static final String GOOGLE_SOURCE = "Google";

    public static final String REGISTER_SUBJECT = System.getenv("headup_mail_register_confirmation_subject");
    public static final String FROM_ADDRESS = System.getenv("headup_from_mail_address");
    public static final String GOOGLE_CLIENT_ID = System.getenv("google-client-id");

    public static final String[] WHITE_LIST = {"/api/auth"};

    public static boolean checkPublic(String requestURI) {
        boolean check = false;
        for(String pattern : WHITE_LIST) {
            if (requestURI.startsWith(pattern)) {
                return true;
            }
        }
        return check;
    }
}
