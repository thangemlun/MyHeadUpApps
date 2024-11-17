package com.thienday.headup.utillize;

import jakarta.annotation.PostConstruct;
import jakarta.mail.internet.MimeMessage;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.DefaultResourceLoader;
import org.springframework.core.io.Resource;
import org.springframework.core.io.ResourceLoader;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;
import org.springframework.util.FileCopyUtils;

import java.nio.charset.StandardCharsets;

import static com.thienday.headup.constants.AppEnvironmentLoader.FROM_ADDRESS;
import static com.thienday.headup.constants.AppEnvironmentLoader.REGISTER_SUBJECT;

@Service
@Slf4j
public class EmailService {

    private static final String APP_PATH = "";
//            System.getenv("context_path");

    private static final String VERIFY_API = "/api/auth/verify-register";

    @Autowired
    private JavaMailSender mailSender;

    private static String REGISTER_CONFIRMATION_MAIL_TEMPLATE = "";

    private static Resource LOGO_IMG_RESOURCE;

    @PostConstruct
    private void load() {
        String templateDir = "/templates";
        REGISTER_CONFIRMATION_MAIL_TEMPLATE = getTemplateStrFromResource(String.format("%s/register-mail-template.html", templateDir));
        LOGO_IMG_RESOURCE = loadResource(templateDir.concat("/logo.png"));
    }

    private String getTemplateStrFromResource(String path) {
        try {
            ResourceLoader loader = new DefaultResourceLoader();
            String html = null;
            Resource src = loader.getResource(path);
            html = new String(FileCopyUtils.copyToByteArray(src.getInputStream()), StandardCharsets.UTF_8);
            src.getInputStream().close();
            return html;
        } catch (Exception e) {
            e.printStackTrace();
            return "";
        }
    }

    private Resource loadResource(String path) {
        try {
            ResourceLoader resLoader = new DefaultResourceLoader();
            Resource res = resLoader.getResource(path);
            return res;
        } catch (Exception e) {
			throw e;
        }
    }

    public void sendRegisterEmail(String toEmail) {
        try {
            MimeMessage message = mailSender.createMimeMessage();
            MimeMessageHelper helper = new MimeMessageHelper(message, true, StandardCharsets.UTF_8.toString());
            buildBodyRegisterMail(helper, toEmail);
            helper.setTo(toEmail);
            helper.setFrom(FROM_ADDRESS);
            helper.setSubject(REGISTER_SUBJECT);
            mailSender.send(message);
        } catch (Exception e) {
            e.printStackTrace();
            log.error("{}", e.getMessage());
        }
    }

    private void buildBodyRegisterMail(MimeMessageHelper helper, String toEmail) {
        try {
            String body = REGISTER_CONFIRMATION_MAIL_TEMPLATE.replace("${recipient}", toEmail)
                    .replace("${verify-api}", "http://localhost:8080".concat(APP_PATH).concat(VERIFY_API)
                            .concat("?mail=" + toEmail));
            helper.setText(body, true);
            String templateDir = "templates";
            helper.addInline("registerImage", LOGO_IMG_RESOURCE);
        } catch (Exception e) {
            log.error("Build body mail failed: {}", e.getMessage());
        }
    }

}
