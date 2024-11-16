package com.yc_your_way.chat.controller;

import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.SendTo;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestParam;


@Controller
public class ChatController {
    @MessageMapping("/chat/{roomId}")
    @SendTo("/topic/{roomId}")
    public String getMethodName(@RequestParam String param) {
        return new String();
    }
    
}
