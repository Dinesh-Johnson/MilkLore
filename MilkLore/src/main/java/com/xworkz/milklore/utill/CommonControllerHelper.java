package com.xworkz.milklore.utill;

import com.xworkz.milklore.entity.NotificationEntity;
import com.xworkz.milklore.service.NotificationService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.ui.Model;

import java.util.List;

@Component
@Slf4j
public class CommonControllerHelper {

    @Autowired
    private NotificationService notificationService;

    public void addNotificationData(Model model, String email) {
        List<NotificationEntity> notifications = notificationService.getNotificationsByAdminEmail(email);
        log.error("size {}",notifications.size());
        model.addAttribute("notifications", notifications);
        model.addAttribute("unreadCount", notifications.size());
    }
}
