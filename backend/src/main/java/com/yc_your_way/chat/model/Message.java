package com.yc_your_way.chat.model;

import com.fasterxml.jackson.annotation.JsonProperty;

import lombok.Data;

@Data
public class Message {
    @JsonProperty("sender")
    private String sender;
    @JsonProperty("content")
    private String content;
}
