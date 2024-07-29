/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.fuhousefinder.entity;

import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author phung
 */
public class FeedbackWithReplies {
     Feedback feedback;
        List<ReplyFeedback> replies;

        FeedbackWithReplies(Feedback feedback, List<ReplyFeedback> replies) {
            this.feedback = feedback;
            this.replies = replies != null ? replies : new ArrayList<>();
        }
}
