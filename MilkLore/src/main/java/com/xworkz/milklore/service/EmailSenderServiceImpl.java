package com.xworkz.milklore.service;

import com.xworkz.milklore.configuration.EmailConfiguration;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.stereotype.Service;

@Slf4j
@Service
public class EmailSenderServiceImpl implements EmailSenderService{

    @Autowired
    private EmailConfiguration emailConfig;

    public EmailSenderServiceImpl() {
        log.info("Admin EmailSenderServiceImpl constructor");
    }

    @Override
    public boolean mailSend(String email) {

        log.info("Admin mailSend method in service");
        try {
            String passwordLink = "http://localhost:8080/MilkLore/setPassword?email=" + email;
            SimpleMailMessage message = new SimpleMailMessage();
            message.setTo(email);
            message.setSubject("Reset Password");

            String messageBody = "Hello,\n\n"
                    + "It looks like you requested to reset your Milk Lore account password. "
                    + "You can reset it by clicking the link below:\n\n"
                    + passwordLink + "\n\n"
                    + "If you didn’t make this request, no worries — just ignore this email and your account will stay safe.\n\n"
                    + "Warm regards,\nMilk Lore Team";
            message.setText(messageBody);

            emailConfig.mailSender().send(message);
            log.info("Admin mailSend method in service");
            return true;
        }catch(Exception e) {
            log.error("Exception in Admin mailSend method in service: {}",e.getMessage());
            return false;
        }

    }
    @Override
    public boolean mailForSupplierRegisterSuccess(String email, String supplierName) {
        log.info("mailForSupplierRegisterSuccess method");
        try {
            String subject = "Welcome to Farm Fresh - Registration Successful";

            String messageBody = "Dear " + supplierName + ",\n\n"
                    + "We are pleased to inform you that your registration as a Milk Supplier with MilkLore has been successfully completed.\n\n"
                    + "You are now officially part of our trusted network of suppliers. "
                    + "Our team is dedicated to supporting you in consistently delivering high-quality milk to our customers with efficiency and reliability.\n\n"
                    + "Should you have any questions or require assistance, please feel free to contact us at info@milklore.com or call our support line.\n\n"
                    + "Once again, welcome to MilkLore. We look forward to a strong and enduring partnership.\n\n"
                    + "Warm regards,\n"
                    + "MilkLore Team";

            SimpleMailMessage simpleMailMessage = new SimpleMailMessage();
            simpleMailMessage.setTo(email);
            simpleMailMessage.setSubject(subject);
            simpleMailMessage.setText(messageBody);

            emailConfig.mailSender().send(simpleMailMessage);
            log.info("Registration success mail sent to: {}", email);
            return true;
        } catch (Exception e) {
            log.error("Error while sending registration success email: {}", e.getMessage());
            return false;
        }
    }

}
