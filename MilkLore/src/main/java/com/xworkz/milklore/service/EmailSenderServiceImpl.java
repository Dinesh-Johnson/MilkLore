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
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;

import javax.mail.internet.MimeMessage;
import java.time.LocalDate;
import java.util.List;

@Slf4j
@Service
public class EmailSenderServiceImpl implements EmailSenderService {

    @Autowired
    private EmailConfiguration emailConfig;

    @Autowired
    private AdminRepo adminRepository;

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
        } catch (Exception e) {
            log.error("Exception in Admin mailSend method in service: {}", e.getMessage());
            return false;
        }

    }

    @Override
    public boolean mailForSupplierRegisterSuccess(String email, String supplierName) {
        log.info("mailForSupplierRegisterSuccess method");
        try {
            String subject = "Welcome to MilkLore - Registration Successful";

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
    public boolean mailForSupplierBankDetails(String email, SupplierBankDetailsEntity bankDetails) {
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
            return true;
        } catch (Exception e) {
            log.error("Failed to send bank details update email to {}. Error: {}", email, e.getMessage());
            return false;
        }
    }

    @Override
    public boolean mailForSupplierPayment(SupplierEntity supplier, PaymentDetailsEntity paymentDetails) {
        log.info("mailForSupplierPayment method in email sender");
        try {
            String subject = "MilkLore - Milk Supply Payment Confirmation";

            String messageBody = "Dear " + supplier.getFirstName()+" "+supplier.getLastName() + ",\n\n"
                    + "We are pleased to inform you that the payment for your milk supply has been successfully processed.\n\n"
                    + "Below are the payment details:\n"
                    + "---------------------------------------\n"
                    + "Payment Date: " + paymentDetails.getPaymentDate() + "\n"
                    + "Amount Paid: ₹" + paymentDetails.getTotalAmount() + "\n"
                    + "Supply Period: " + paymentDetails.getPeriodStart() + " to " + paymentDetails.getPeriodEnd() + "\n"
                    + "---------------------------------------\n\n"
                    + "This payment covers the total amount for the milk supplied during the above period.\n\n"
                    + "If you have any questions or concerns regarding this payment, please contact our accounts team at info@milklore.com.\n\n"
                    + "Thank you for your consistent and quality milk supply.\n\n"
                    + "Warm regards,\n"
                    + "MilkLore Team";

            SimpleMailMessage simpleMailMessage = new SimpleMailMessage();
            simpleMailMessage.setTo(supplier.getEmail());
            simpleMailMessage.setSubject(subject);
            simpleMailMessage.setText(messageBody);

            emailConfig.mailSender().send(simpleMailMessage);
            log.info("Payment confirmation mail sent successfully to: {}", supplier.getEmail());
            return true;
        } catch (Exception e) {
            log.error("Error while sending payment confirmation email: {}", e.getMessage());
            return false;
        }
    }

    @Override
    public boolean mailForBankDetailsRequest(SupplierEntity supplier) {
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
            return true;

        } catch (Exception e) {
            log.error("Error while sending bank details reminder email to {}", supplier.getEmail(), e);
            return false;
        }
    }

    @Override
    public boolean mailForAdminPaymentSummary(List<PaymentDetailsDTO> payments) {
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
            return true;
        } catch (Exception e) {
            log.error("Error while sending admin payment summary email: {}", e.getMessage(), e);
        }
        return false;
    }
}
