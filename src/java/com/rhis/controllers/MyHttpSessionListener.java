package com.rhis.controllers;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.atomic.AtomicInteger;
import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpSessionEvent;
import javax.servlet.http.HttpSessionListener;

/**
 *
 * @author Helal
 */
public class MyHttpSessionListener implements HttpSessionListener, Serializable {

    private List<String> sessions = new ArrayList<>();
    public static final String COUNTER = "session-counter";

    public void sessionCreated(HttpSessionEvent event) {
        System.out.println("SessionCounter.sessionCreated");
        HttpSession session = event.getSession();
        sessions.add(session.getId());
        session.setAttribute(MyHttpSessionListener.COUNTER, this);
    }

    public void sessionDestroyed(HttpSessionEvent event) {
        System.out.println("SessionCounter.sessionDestroyed");
        HttpSession session = event.getSession();
        sessions.remove(session.getId());
        session.setAttribute(MyHttpSessionListener.COUNTER, this);
    }

    public int getActiveSessionNumber() {
        return sessions.size();
    }
}
