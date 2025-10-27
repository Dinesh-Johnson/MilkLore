package com.xworkz.milklore.configuration;

import com.xworkz.milklore.dto.AdminDTO;
import com.xworkz.milklore.dto.SupplierDTO;
import com.xworkz.milklore.entity.NotificationEntity;
import com.xworkz.milklore.service.AdminService;
import com.xworkz.milklore.service.MilkProductReceiveService;
import com.xworkz.milklore.service.NotificationService;
import com.xworkz.milklore.service.SupplierService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import java.time.LocalDate;
import java.util.List;

@Component
@Slf4j
public class PaymentNotificationScheduler {

    @Autowired
    private NotificationService paymentNotificationService;

    @Scheduled(cron = "0 0 9 13,28 * *",zone = "Asia/Kolkata")
    public void runAdvanceNotification() {
        paymentNotificationService.generateAdvanceNotifications();
    }

    // every day at 9 AM    // 0 */1 * * * *
    @Scheduled(cron = "0 0 9 * * *", zone = "Asia/Kolkata")
    public void runPaymentNotification() {
        LocalDate today = LocalDate.now();
        int dayOfMonth = today.getDayOfMonth();
        int lastDayOfMonth = today.lengthOfMonth();

        if (dayOfMonth == 15 || dayOfMonth == lastDayOfMonth) {
            paymentNotificationService.generatePaymentNotifications();
        } else {
            log.info("Today ({}) is not 15th or last day ({}), skipping payment notification.",
                    dayOfMonth, lastDayOfMonth);
        }
    }

    @Scheduled(cron = "0 0 18 * * *", zone = "Asia/Kolkata") // every day at 6 PM
    public void runEveningPaymentSummary() {
        LocalDate today = LocalDate.now();
        int dayOfMonth = today.getDayOfMonth();
        int lastDayOfMonth = today.lengthOfMonth();

        if (dayOfMonth == 15 || dayOfMonth == lastDayOfMonth) {
            if(paymentNotificationService.getPaymentDetailsForAdminEmailSummary())
                log.info("Email summary send to admins");
        } else {
            log.info("Today ({}) is not 15th or last day ({}), skipping admin payment summary.",
                    dayOfMonth, lastDayOfMonth);
        }
    }
}
