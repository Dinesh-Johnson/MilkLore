package com.xworkz.milklore.service;

import com.xworkz.milklore.configuration.EmailConfiguration;
import com.xworkz.milklore.dto.PaymentDetailsDTO;
import com.xworkz.milklore.entity.AdminEntity;
import com.xworkz.milklore.entity.PaymentDetailsEntity;
import com.xworkz.milklore.entity.SupplierBankDetailsEntity;
import com.xworkz.milklore.entity.SupplierEntity;
import com.xworkz.milklore.repository.AdminRepo;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.FileSystemResource;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Service;
import org.thymeleaf.context.Context;
import org.thymeleaf.spring5.SpringTemplateEngine;

import javax.mail.internet.MimeMessage;
import java.io.File;
import java.time.LocalDate;
import java.util.List;

@Slf4j
@Service
public class EmailSenderServiceImpl implements EmailSenderService {

    @Autowired
    private EmailConfiguration emailConfig;

    @Autowired
    private AdminRepo adminRepository;

    @Autowired
    private SpringTemplateEngine emailTemplateEngine;

    public EmailSenderServiceImpl() {
        log.info("Admin EmailSenderServiceImpl constructor");
    }

    private MimeMessageHelper getHtmlMessageHelper(String to, String subject) throws Exception {
        MimeMessage mimeMessage = emailConfig.mailSender().createMimeMessage();
        MimeMessageHelper helper = new MimeMessageHelper(mimeMessage, true, "UTF-8");

        helper.setTo(to);
        helper.setSubject(subject);

        return helper;
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
        } catch (Exception e) {
            log.error("Exception in Admin mailSend method in service: {}", e.getMessage());
            return false;
        }

    }

    @Override
    @Async
    public void mailForSupplierRegisterSuccess(String email, String supplierName, String qrCodePath) {
        log.info("mailForSupplierRegisterSuccess method");

        try {
            String subject = "Welcome to MilkLore - Registration Successful";

            String messageBody = "<p>Dear <b>" + supplierName + "</b>,</p>"
                    + "<p>We are happy to inform you that your registration as a Milk Supplier with <b>MilkLore</b> has been successfully completed.</p>"
                    + "<p>You are now officially part of our trusted network of suppliers. "
                    + "Our team is committed to supporting you in delivering high-quality milk efficiently.</p>"
                    + "<p><b>Your QR Code:</b> This QR code will be used for quick identification during milk collection.</p>"
                    + "<p><img src='cid:qrCodeImage' alt='QR Code' style='width:150px;height:150px;'/></p>"
                    + "<p>If you have any questions, reach out to us at <a href='mailto:info@milklore.com'>info@milklore.com</a>.</p>"
                    + "<p>Warm regards,<br/>MilkLore Team</p>";

            MimeMessage mimeMessage = emailConfig.mailSender().createMimeMessage();
            MimeMessageHelper helper = new MimeMessageHelper(mimeMessage, true);

            helper.setTo(email);
            helper.setSubject(subject);
            helper.setText(messageBody, true);

            FileSystemResource qrImage = new FileSystemResource(new File(qrCodePath));
            helper.addInline("qrCodeImage", qrImage);

            emailConfig.mailSender().send(mimeMessage);
            log.info("Registration email with QR sent to: {}", email);

        } catch (Exception e) {
            log.error("Error while sending registration success email: {}", e.getMessage(), e);
        }
    }

    @Override
    public boolean supplierMailOtp(String email, String otp) {
        log.info("Executing supplierMailOtp() for email: {}", email);

        try {
            // Build message
            String subject = "MilkLore - Login OTP";
            String messageBody = "Dear Supplier,\n\n"
                    + "Your One-Time Password (OTP) for login is: " + otp + "\n\n"
                    + "Please do not share this code with anyone.\n\n"
                    + "Warm regards,\n"
                    + "Team MilkLore";

            // Create and send mail
            SimpleMailMessage message = new SimpleMailMessage();
            message.setTo(email);
            message.setSubject(subject);
            message.setText(messageBody);

            emailConfig.mailSender().send(message);

            log.info("OTP email sent successfully to: {} | OTP: {}", email, otp);
            return true;

        } catch (Exception ex) {
            log.error("Failed to send OTP email to {}. Error: {}", email, ex.getMessage(), ex);
            return false;
        }
    }


    @Override
    @Async
    public void mailForSupplierBankDetails(String email, SupplierBankDetailsEntity bankDetails) {
        log.info("Entered mailForSupplierBankDetails() in EmailSender for email: {}", email);
        try {
            String subject = "MilkLore - Bank Details Updated Successfully";

            String messageBody = "Dear Supplier,\n\n"
                    + "We’re writing to inform you that your bank details have been successfully added or updated in your MilkLore account.\n\n"
                    + "Here are the details currently registered in our system:\n"
                    + "----------------------------------------------------\n"
                    + "Bank Name       : " + bankDetails.getBankName() + "\n"
                    + "Account Number  : " + bankDetails.getAccountNumber() + "\n"
                    + "IFSC Code       : " + bankDetails.getIFSCCode() + "\n"
                    + "Branch Name     : " + bankDetails.getBankBranch() + "\n"
                    + "----------------------------------------------------\n\n"
                    + "If you did not request this update, please contact our support team immediately at support@milklore.com.\n\n"
                    + "Thank you for helping us keep your account information accurate and secure.\n\n"
                    + "Warm regards,\n"
                    + "The MilkLore Team";

            SimpleMailMessage simpleMailMessage = new SimpleMailMessage();
            simpleMailMessage.setTo(email);
            simpleMailMessage.setSubject(subject);
            simpleMailMessage.setText(messageBody);

            emailConfig.mailSender().send(simpleMailMessage);
            log.info("Successfully sent bank details update email to: {}", email);
        } catch (Exception e) {
            log.error("Failed to send bank details update email to {}. Error: {}", email, e.getMessage());
        }
    }

    @Override
    @Async
    public void mailForSupplierPayment(SupplierEntity supplier, PaymentDetailsEntity paymentDetails) {
        log.info("Sending payment email to supplier: {}", supplier.getEmail());

        try {
            String subject = "MilkLore - Payment Confirmation";

            Context context = new Context();
            context.setVariable("firstName", supplier.getFirstName());
            context.setVariable("lastName", supplier.getLastName());
            context.setVariable("paymentDate", paymentDetails.getPaymentDate());
            context.setVariable("amount", paymentDetails.getTotalAmount());
            context.setVariable("periodStart", paymentDetails.getPeriodStart());
            context.setVariable("periodEnd", paymentDetails.getPeriodEnd());

            String htmlContent = emailTemplateEngine.process("payment-confirmation", context);

            MimeMessageHelper helper = getHtmlMessageHelper(supplier.getEmail(), subject);
            helper.setText(htmlContent, true);
            FileSystemResource logo = new FileSystemResource(new File("src/main/webapp/images/milklore.png"));
            helper.addInline("milkloreLogo", logo);



            emailConfig.mailSender().send(helper.getMimeMessage());

            log.info("Payment email sent to supplier");

        } catch (Exception e) {
            log.error("Error sending payment email: {}", e.getMessage());
        }
    }
    @Override
    @Async
    public void mailForBankDetailsRequest(SupplierEntity supplier) {
        log.info("mailForBankDetailsRequest method in EmailSender");

        try {
            String subject = "MilkLore - Action Required: Update Your Bank Details";

            String messageBody = "Dear " + supplier.getFirstName()+" "+supplier.getLastName() + ",\n\n"
                    + "We hope you're doing well!\n\n"
                    + "Our records show that your bank details are not yet provided in your MilkLore account.\n"
                    + "Please update your bank details as soon as possible to ensure smooth and timely payments.\n\n"
                    + "⚠️ Note: Payments will not be processed until your bank details are submitted and verified.\n\n"
                    + "To update your bank details, please log in to your MilkLore Supplier Dashboard.\n\n"
                    + "Thank you for your cooperation.\n\n"
                    + "Best regards,\n"
                    + "MilkLore Team";

            SimpleMailMessage message = new SimpleMailMessage();
            message.setTo(supplier.getEmail());
            message.setSubject(subject);
            message.setText(messageBody);

            emailConfig.mailSender().send(message);

            log.info("Bank details reminder email sent successfully to {}", supplier.getEmail());

        } catch (Exception e) {
            log.error("Error while sending bank details reminder email to {}", supplier.getEmail(), e);
        }
    }

    @Override
    @Async
    public void mailForAdminPaymentSummary(List<PaymentDetailsDTO> payments) {
        log.info("mailForAdminPaymentSummary method in EmailSender");

        try {
            LocalDate today=LocalDate.now();
            StringBuilder html = new StringBuilder();
            html.append("<h2>📅 Payment Summary for ").append(today).append("</h2>");
            html.append("<table border='1' cellspacing='0' cellpadding='6' style='border-collapse:collapse;width:100%;'>")
                    .append("<tr style='background:#f2f2f2;'>")
                    .append("<th>Supplier</th>")
                    .append("<th>Amount Paid (₹)</th>")
                    .append("<th>Status</th>")
                    .append("<th>Period</th>")
                    .append("</tr>");

            for (PaymentDetailsDTO p : payments) {
                String color = "Paid".equalsIgnoreCase(p.getPaymentStatus()) ? "green" : "red";
                html.append("<tr>")
                        .append("<td>").append(p.getSupplier().getFirstName()).append(" ").append(p.getSupplier().getLastName()).append("</td>")
                        .append("<td>").append(p.getTotalAmount()).append("</td>")
                        .append("<td style='color:").append(color).append(";'>").append(p.getPaymentStatus()).append("</td>")
                        .append("<td>").append(p.getPeriodStart()).append(" to ").append(p.getPeriodEnd()).append("</td>")
                        .append("</tr>");
            }
            html.append("</table>");

            List<AdminEntity> admins = adminRepository.findAll();

            for (AdminEntity admin : admins) {
                if (admin.getEmail() != null && !admin.getEmail().isEmpty()) {
                    MimeMessage message = emailConfig.mailSender().createMimeMessage();
                    MimeMessageHelper helper = new MimeMessageHelper(message, true);
                    helper.setTo(admin.getEmail());
                    helper.setSubject("Evening Payment Summary - " + today);
                    helper.setText(html.toString(), true);
                    emailConfig.mailSender().send(message);
                    log.info("Payment summary email sent to admin: {}", admin.getEmail());
                }
            }
        } catch (Exception e) {
            log.error("Error while sending admin payment summary email: {}", e.getMessage(), e);
        }
    }
}
